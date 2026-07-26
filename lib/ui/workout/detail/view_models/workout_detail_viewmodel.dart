import 'package:flutter_command/flutter_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/data/repositories/workout/workout_repository.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';

class WorkoutDetailViewModel {
  WorkoutDetailViewModel({
    required WorkoutRepository workoutRepository,
  }) : _workoutRepository = workoutRepository {
    loadWorkout = Command.createAsync(
      _loadWorkout,
      initialValue: null,
    );
  }

  final WorkoutRepository _workoutRepository;
  Workout? _workout;

  Workout? get workout => _workout;

  late Command<int, Result<void>?> loadWorkout;

  Future<Result<void>> _loadWorkout(int id) async {
    final result = await _workoutRepository.getOne(id);
    if (result.isError()) {
      return Failure(Exception('Failed to fetch workouts'));
    }

    _workout = result.getOrThrow();
    return Success(0);
  }
}
