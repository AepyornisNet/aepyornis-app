import 'package:file_picker/file_picker.dart';
import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/data/repositories/workout/workout_repository.dart';
import 'package:aepyornis_app/data/services/api/api_client.dart';
import 'package:aepyornis_app/domain/models/equipment/equipment.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';
import 'package:aepyornis_app/domain/models/workout_reply/workout_reply.dart';

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
      final result = await getWorkoutsPage(page: 1, limit: 20);
      if (result.isError()) {
        return Failure(Exception('Failed to fetch workouts'));
      }
    }

    return Success(_cachedWorkouts!);
  }

  @override
  Future<Result<List<Workout>>> getWorkoutsPage({
    int page = 1,
    int limit = 20,
  }) async {
    final result = await _apiClient.getWorkouts(page: page, limit: limit);
    if (result.isSuccess()) {
      final pageWorkouts = result.getOrThrow();
      if (page == 1) {
        _cachedWorkouts = List.from(pageWorkouts);
      } else if (_cachedWorkouts != null) {
        for (final w in pageWorkouts) {
          final idx = _cachedWorkouts!.indexWhere((item) => item.id == w.id);
          if (idx >= 0) {
            _cachedWorkouts![idx] = w;
          } else {
            _cachedWorkouts!.add(w);
          }
        }
      }
    }
    return result;
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
    final result = await getWorkoutsPage(page: 1, limit: 20);
    if (result.isError()) {
      return Failure(
        result.exceptionOrNull() ?? Exception('Failed to update workouts'),
      );
    }
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

  @override
  Future<Result<Workout>> updateWorkout(
      int id, Map<String, dynamic> data) async {
    final result = await _apiClient.updateWorkout(id, data);
    if (result.isSuccess()) {
      addWorkout(result.getOrThrow());
    }
    return result;
  }

  @override
  Future<Result<void>> deleteWorkout(int id) async {
    final result = await _apiClient.deleteWorkout(id);
    if (result.isSuccess() && _cachedWorkouts != null) {
      _cachedWorkouts!.removeWhere((w) => w.id == id);
    }
    return result;
  }

  @override
  Future<Result<Workout>> toggleWorkoutLock(int id) async {
    final result = await _apiClient.toggleWorkoutLock(id);
    if (result.isSuccess()) {
      addWorkout(result.getOrThrow());
    }
    return result;
  }

  @override
  Future<Result<void>> refreshWorkout(int id) async {
    return _apiClient.refreshWorkout(id);
  }
}
