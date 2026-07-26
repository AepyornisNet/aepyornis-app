import 'package:result_dart/result_dart.dart';
import 'package:workout_tracker_app/data/repositories/workout/workout_repository.dart';
import 'package:workout_tracker_app/data/services/api/api_client.dart';
import 'package:workout_tracker_app/domain/models/workout/workout.dart';

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
}
