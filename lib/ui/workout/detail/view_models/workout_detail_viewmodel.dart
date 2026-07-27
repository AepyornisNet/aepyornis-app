import 'package:flutter_command/flutter_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/data/repositories/auth/auth_repository.dart';
import 'package:aepyornis_app/data/repositories/workout/workout_repository.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';

class WorkoutDetailViewModel {
  WorkoutDetailViewModel({
    required WorkoutRepository workoutRepository,
    AuthRepository? authRepository,
  })  : _workoutRepository = workoutRepository,
        _authRepository = authRepository {
    loadWorkout = Command.createAsync(
      _loadWorkout,
      initialValue: null,
    );
  }

  final WorkoutRepository _workoutRepository;
  final AuthRepository? _authRepository;
  Workout? _workout;

  Workout? get workout => _workout;

  bool get isCurrentOwner =>
      _workout == null || _workout!.isOwnedBy(_authRepository?.currentUser);

  late Command<int, Result<void>?> loadWorkout;

  Future<Result<void>> _loadWorkout(int id) async {
    final result = await _workoutRepository.getOne(id);
    if (result.isError()) {
      return Failure(Exception('Failed to fetch workouts'));
    }

    _workout = result.getOrThrow();
    return Success(0);
  }

  Future<Result<void>> deleteWorkout() async {
    if (_workout?.id == null) {
      return Failure(Exception('No workout loaded'));
    }
    if (!isCurrentOwner) {
      return Failure(Exception('Cannot delete another user\'s workout'));
    }
    return _workoutRepository.deleteWorkout(_workout!.id!);
  }

  Future<Result<Workout>> toggleLock() async {
    if (_workout?.id == null) {
      return Failure(Exception('No workout loaded'));
    }
    if (!isCurrentOwner) {
      return Failure(Exception('Cannot lock another user\'s workout'));
    }
    final result = await _workoutRepository.toggleWorkoutLock(_workout!.id!);
    if (result.isSuccess()) {
      _workout = result.getOrThrow();
      loadWorkout.execute(_workout!.id!);
    }
    return result;
  }

  Future<Result<void>> refreshWorkout() async {
    if (_workout?.id == null) {
      return Failure(Exception('No workout loaded'));
    }
    if (!isCurrentOwner) {
      return Failure(Exception('Cannot refresh another user\'s workout'));
    }
    final result = await _workoutRepository.refreshWorkout(_workout!.id!);
    if (result.isSuccess()) {
      loadWorkout.execute(_workout!.id!);
    }
    return result;
  }
}
