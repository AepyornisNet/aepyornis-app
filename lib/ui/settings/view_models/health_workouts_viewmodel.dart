import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:health_connector/health_connector.dart';
import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/data/repositories/workout/workout_repository.dart';
import 'package:aepyornis_app/data/services/api/api_client.dart';
import 'package:aepyornis_app/data/services/health_connect/fit_exporter.dart';
import 'package:aepyornis_app/data/services/health_connect/health_connect_service.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';

class HealthWorkoutItem {
  HealthWorkoutItem({
    required this.session,
    required this.isSynced,
    this.route,
    this.isSyncing = false,
    this.errorMessage,
  });

  final ExerciseSessionRecord session;
  bool isSynced;
  ExerciseRoute? route;
  bool isSyncing;
  String? errorMessage;

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
  int daysToLoad = 7;

  late Command<void, List<HealthWorkoutItem>> loadWorkouts;
  late Command<HealthWorkoutItem, Result<void>?> syncWorkout;
  late Command<void, Result<int>?> syncAll;

  Future<List<HealthWorkoutItem>> _loadWorkouts() async {
    final startTime = DateTime.now().subtract(Duration(days: daysToLoad));
    final sessions =
        await _healthConnectService.readExerciseSessions(startTime: startTime);
    final existingWorkouts = <Workout>[];

    try {
      int page = 1;
      bool hasMore = true;
      while (hasMore) {
        final repoResult =
            await _workoutRepository.getWorkoutsPage(page: page, limit: 50);
        final pageItems = repoResult.getOrDefault([]);
        if (pageItems.isEmpty) {
          break;
        }
        existingWorkouts.addAll(pageItems);
        final oldestDate = pageItems.last.date;
        if (oldestDate.isBefore(startTime) || pageItems.length < 50) {
          hasMore = false;
        } else {
          page++;
        }
      }
    } catch (_) {}

    final items = <HealthWorkoutItem>[];

    for (final session in sessions) {
      final isAlreadySynced = _checkIsSynced(session, existingWorkouts);
      if (isAlreadySynced) {
        continue;
      }

      final route = await _healthConnectService.readExerciseRoute(session.id);

      items.add(
        HealthWorkoutItem(
          session: session,
          isSynced: false,
          route: route,
        ),
      );
    }

    workouts = items;
    notifyListeners();
    return items;
  }

  void loadMore() {
    daysToLoad += 30;
    loadWorkouts.execute();
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
    item.errorMessage = null;
    notifyListeners();

    try {
      final session = item.session;
      final route = item.route ??
          await _healthConnectService.readExerciseRoute(session.id);

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
      final totalDistance = await _healthConnectService.readDistance(
        session.startTime,
        session.endTime,
      );
      final totalCalories = await _healthConnectService.readCalories(
        session.startTime,
        session.endTime,
      );

      double? fallbackDistance = totalDistance;
      if (fallbackDistance == null && session.lapEvents.isNotEmpty) {
        double sum = 0;
        bool hasDist = false;
        for (final lap in session.lapEvents) {
          if (lap.distance != null) {
            sum += lap.distance!.inMeters;
            hasDist = true;
          }
        }
        if (hasDist) {
          fallbackDistance = sum;
        }
      }

      final fitBytes = FitExporter.buildFit(
        title: item.title,
        exerciseType: session.exerciseType,
        startTime: session.startTime,
        endTime: session.endTime,
        locations: route?.locations ?? [],
        heartRates: heartRates,
        cadences: cadences,
        powers: powers,
        totalDistance: fallbackDistance,
        totalCalories: totalCalories,
      );

      final filename =
          'workout_${session.startTime.millisecondsSinceEpoch}.fit';

      final uploadResult = await _apiClient.uploadWorkoutFile(
        bytes: fitBytes,
        filename: filename,
        type: session.exerciseType.name,
        notes: session.notes ?? '',
      );

      if (uploadResult.isSuccess()) {
        final uploadedWorkout = uploadResult.getOrNull();
        if (uploadedWorkout != null) {
          _workoutRepository.addWorkout(uploadedWorkout);
        }
        item.isSynced = true;
        item.isSyncing = false;
        notifyListeners();

        await Future<void>.delayed(const Duration(milliseconds: 1200));
        workouts.remove(item);
        notifyListeners();

        unawaited(_workoutRepository.updateWorkouts());
        return Success(0);
      } else {
        item.isSyncing = false;
        item.errorMessage =
            uploadResult.exceptionOrNull()?.toString() ?? 'Upload failed';
        notifyListeners();
        return Failure(
          uploadResult.exceptionOrNull() ?? Exception('Upload failed'),
        );
      }
    } on Exception catch (e) {
      item.isSyncing = false;
      item.errorMessage = e.toString();
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
