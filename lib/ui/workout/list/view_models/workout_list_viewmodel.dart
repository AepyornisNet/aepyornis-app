import 'package:flutter_command/flutter_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/data/repositories/workout/workout_repository.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';

class WorkoutListViewModel {
  WorkoutListViewModel({
    required WorkoutRepository workoutRepository,
  })  : _workoutRepository = workoutRepository,
        _workouts = workoutRepository.cachedWorkouts ?? [] {
    loadWorkouts = Command.createAsyncNoParam<Result<void>?>(
      _loadWorkouts,
      initialValue: null,
    );
    if (_workouts.isEmpty) {
      loadWorkouts.execute();
    }
  }

  final WorkoutRepository _workoutRepository;
  List<Workout> _workouts;

  // List of all [Workout]
  List<Workout> get workouts => _workouts;

  late Command<void, Result<void>?> loadWorkouts;

  Future<Result<void>> _loadWorkouts() async {
    final result = await _workoutRepository.getAll();
    if (result.isError()) {
      return Failure(Exception('Failed to fetch workouts'));
    }

    _workouts = result.getOrThrow();
    return Success(0);
  }

  Future<void> updateWorkouts() async {
    await _workoutRepository.updateWorkouts();
    await loadWorkouts.executeWithFuture();
  }
}
