import 'package:file_picker/file_picker.dart';
import 'package:result_dart/result_dart.dart';
import 'package:workout_tracker_app/data/repositories/workout/workout_repository.dart';
import 'package:workout_tracker_app/data/services/api/api_client.dart';
import 'package:workout_tracker_app/domain/models/equipment/equipment.dart';
import 'package:workout_tracker_app/domain/models/workout/workout.dart';
import 'package:workout_tracker_app/domain/models/workout_reply/workout_reply.dart';

class WorkoutRepositoryRemote implements WorkoutRepository {
  WorkoutRepositoryRemote({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  List<Workout>? _cachedWorkouts;

  @override
  List<Workout>? get cachedWorkouts => _cachedWorkouts;

  @override
  Future<Result<List<Workout>>> getAll({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (_cachedWorkouts == null) {
      final result = await updateWorkouts();
      if (result.isError()) {
        return Failure(Exception('Failed to fetch workouts'));
      }
    }

    return Success(_cachedWorkouts!);
  }

  @override
  Future<Result<Workout>> getOne(int id) async {
    final result = await _apiClient.getWorkout(id);
    try {
      final response = result.getOrThrow();
      return Success(response);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<void>> updateWorkouts() async {
    final allWorkouts = <Workout>[];
    int page = 1;
    bool hasMore = true;

    while (hasMore) {
      final result = await _apiClient.getWorkouts(page: page);
      if (result.isError()) {
        if (allWorkouts.isNotEmpty) {
          break;
        }
        return Failure(
          result.exceptionOrNull() ?? Exception('Failed to fetch workouts'),
        );
      }
      final pageWorkouts = result.getOrDefault([]);
      if (pageWorkouts.isEmpty) {
        hasMore = false;
      } else {
        allWorkouts.addAll(pageWorkouts);
        if (pageWorkouts.length < 20) {
          hasMore = false;
        } else {
          page++;
        }
      }
    }

    _cachedWorkouts = allWorkouts;
    return Success(0);
  }

  @override
  void addWorkout(Workout workout) {
    if (_cachedWorkouts == null) {
      _cachedWorkouts = [workout];
    } else {
      final existingIndex =
          _cachedWorkouts!.indexWhere((w) => w.id == workout.id);
      if (existingIndex >= 0) {
        _cachedWorkouts![existingIndex] = workout;
      } else {
        _cachedWorkouts!.insert(0, workout);
      }
    }
  }

  @override
  Future<Result<List<Workout>>> getRecentWorkouts({
    int limit = 10,
    int offset = 0,
    String scope = 'following',
  }) {
    return _apiClient.getRecentWorkouts(
      limit: limit,
      offset: offset,
      scope: scope,
    );
  }

  @override
  Future<Result<Map<String, dynamic>>> likeWorkout(int workoutId) {
    return _apiClient.likeWorkout(workoutId);
  }

  @override
  Future<Result<List<WorkoutReply>>> getWorkoutReplies(int workoutId) {
    return _apiClient.getWorkoutReplies(workoutId);
  }

  @override
  Future<Result<WorkoutReply>> createReply(int workoutId, String content) {
    return _apiClient.createReply(workoutId, content);
  }

  @override
  Future<Result<Workout>> createWorkoutManual(Map<String, dynamic> data) async {
    final result = await _apiClient.createWorkoutManual(data);
    if (result.isSuccess()) {
      addWorkout(result.getOrThrow());
    }
    return result;
  }

  @override
  Future<Result<List<Workout>>> uploadWorkoutFiles({
    required List<PlatformFile> files,
    String? type,
    String? notes,
  }) async {
    final result = await _apiClient.uploadWorkoutFiles(
      files: files,
      type: type,
      notes: notes,
    );
    if (result.isSuccess()) {
      for (final w in result.getOrThrow()) {
        addWorkout(w);
      }
    }
    return result;
  }

  @override
  Future<Result<List<Equipment>>> getEquipment() {
    return _apiClient.getEquipment();
  }
}
