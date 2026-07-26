import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:health_connector/health_connector.dart';
import 'package:result_dart/result_dart.dart';
import 'package:workout_tracker_app/data/repositories/workout/workout_repository.dart';
import 'package:workout_tracker_app/data/services/api/api_client.dart';
import 'package:workout_tracker_app/data/services/health_connect/gpx_exporter.dart';
import 'package:workout_tracker_app/data/services/health_connect/health_connect_service.dart';
import 'package:workout_tracker_app/domain/models/workout/workout.dart';

class HealthWorkoutItem {
  HealthWorkoutItem({
    required this.session,
    required this.isSynced,
    this.route,
    this.isSyncing = false,
  });

  final ExerciseSessionRecord session;
  bool isSynced;
  ExerciseRoute? route;
  bool isSyncing;

  String get title {
    if (session.title != null && session.title!.trim().isNotEmpty) {
      return session.title!.trim();
    }
    switch (session.exerciseType) {
      case ExerciseType.running:
      case ExerciseType.runningTreadmill:
        return 'Running';
      case ExerciseType.cycling:
      case ExerciseType.cyclingStationary:
        return 'Cycling';
      case ExerciseType.walking:
      case ExerciseType.hiking:
        return 'Walking / Hiking';
      default:
        return 'Exercise Session';
    }
  }

  Duration get duration => session.endTime.difference(session.startTime);

  bool get hasRoute => route != null && route!.isNotEmpty;
}

class HealthWorkoutsViewModel extends ChangeNotifier {
  HealthWorkoutsViewModel({
    required HealthConnectService healthConnectService,
    required WorkoutRepository workoutRepository,
    required ApiClient apiClient,
  })  : _healthConnectService = healthConnectService,
        _workoutRepository = workoutRepository,
        _apiClient = apiClient {
    loadWorkouts = Command.createAsyncNoParam(_loadWorkouts, initialValue: []);
    syncWorkout = Command.createAsync(_syncWorkout, initialValue: null);
    syncAll = Command.createAsyncNoParam(_syncAll, initialValue: null);
  }

  final HealthConnectService _healthConnectService;
  final WorkoutRepository _workoutRepository;
  final ApiClient _apiClient;

  List<HealthWorkoutItem> workouts = [];

  late Command<void, List<HealthWorkoutItem>> loadWorkouts;
  late Command<HealthWorkoutItem, Result<void>?> syncWorkout;
  late Command<void, Result<int>?> syncAll;

  Future<List<HealthWorkoutItem>> _loadWorkouts() async {
    final sessions = await _healthConnectService.readExerciseSessions();
    List<Workout> existingWorkouts = [];

    try {
      final repoResult = await _workoutRepository.getAll();
      existingWorkouts = repoResult.getOrDefault([]);
    } catch (_) {}

    final items = <HealthWorkoutItem>[];

    for (final session in sessions) {
      final isAlreadySynced = _checkIsSynced(session, existingWorkouts);
      final route = await _healthConnectService.readExerciseRoute(session.id);

      items.add(
        HealthWorkoutItem(
          session: session,
          isSynced: isAlreadySynced,
          route: route,
        ),
      );
    }

    workouts = items;
    notifyListeners();
    return items;
  }

  bool _checkIsSynced(
    ExerciseSessionRecord session,
    List<Workout> existingWorkouts,
  ) {
    for (final w in existingWorkouts) {
      final diff = session.startTime.difference(w.date).inMinutes.abs();
      if (diff <= 3) {
        return true;
      }
    }
    return false;
  }

  Future<Result<void>> _syncWorkout(HealthWorkoutItem item) async {
    if (item.isSynced || item.isSyncing) {
      return Success(0);
    }

    item.isSyncing = true;
    notifyListeners();

    try {
      final session = item.session;
      final route =
          item.route ?? await _healthConnectService.readExerciseRoute(session.id);

      final heartRates = await _healthConnectService.readHeartRates(
        session.startTime,
        session.endTime,
      );
      final cadences = await _healthConnectService.readCadence(
        session.startTime,
        session.endTime,
      );
      final powers = await _healthConnectService.readPower(
        session.startTime,
        session.endTime,
      );

      final gpxXml = GpxExporter.buildGpx(
        title: item.title,
        activityType: session.exerciseType.name,
        startTime: session.startTime,
        locations: route?.locations ?? [],
        heartRates: heartRates,
        cadences: cadences,
        powers: powers,
      );

      final filename =
          'workout_${session.startTime.millisecondsSinceEpoch}.gpx';

      final uploadResult = await _apiClient.uploadWorkoutGpx(
        gpxXml: gpxXml,
        filename: filename,
        type: session.exerciseType.name,
        notes: session.notes ?? '',
      );

      if (uploadResult.isSuccess()) {
        item.isSynced = true;
        item.isSyncing = false;
        notifyListeners();
        unawaited(_workoutRepository.updateWorkouts());
        return Success(0);
      } else {
        item.isSyncing = false;
        notifyListeners();
        return Failure(
          uploadResult.exceptionOrNull() ?? Exception('Upload failed'),
        );
      }
    } on Exception catch (e) {
      item.isSyncing = false;
      notifyListeners();
      return Failure(e);
    }
  }

  Future<Result<int>> _syncAll() async {
    final unsynced = workouts.where((w) => !w.isSynced).toList();
    if (unsynced.isEmpty) {
      return Success(0);
    }

    int syncedCount = 0;
    for (final item in unsynced) {
      final res = await _syncWorkout(item);
      if (res.isSuccess()) {
        syncedCount++;
      }
    }
    return Success(syncedCount);
  }
}
