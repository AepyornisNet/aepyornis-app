import 'package:flutter/foundation.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/data/repositories/auth/auth_repository.dart';
import 'package:aepyornis_app/data/repositories/workout/workout_repository.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';

class WorkoutListViewModel extends ChangeNotifier {
  WorkoutListViewModel({
    required WorkoutRepository workoutRepository,
    AuthRepository? authRepository,
  })  : _workoutRepository = workoutRepository,
        _authRepository = authRepository,
        _workouts = workoutRepository.cachedWorkouts ?? [] {
    loadWorkouts = Command.createAsyncNoParam<Result<void>?>(
      _loadInitialWorkouts,
      initialValue: null,
    );
    if (_workouts.isEmpty) {
      loadWorkouts.execute();
    }
  }

  final WorkoutRepository _workoutRepository;
  final AuthRepository? _authRepository;
  List<Workout> _workouts;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  bool _hasMorePages = true;
  bool get hasMorePages => _hasMorePages;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  // List of all [Workout]
  List<Workout> get workouts => _workouts;

  bool isWorkoutOwned(Workout workout) =>
      workout.isOwnedBy(_authRepository?.currentUser);

  late Command<void, Result<void>?> loadWorkouts;

  Future<Result<void>> _loadInitialWorkouts() async {
    _currentPage = 1;
    _hasMorePages = true;

    final result = await _workoutRepository.getWorkoutsPage(page: 1, limit: 20);
    if (result.isError()) {
      if (_workoutRepository.cachedWorkouts != null &&
          _workoutRepository.cachedWorkouts!.isNotEmpty) {
        _workouts = _workoutRepository.cachedWorkouts!;
        notifyListeners();
        return Success(0);
      }
      return Failure(Exception('Failed to fetch workouts'));
    }

    final pageItems = result.getOrThrow();
    _workouts = List.from(pageItems);
    _hasMorePages = pageItems.length >= 20;
    notifyListeners();
    return Success(0);
  }

  Future<void> loadMoreWorkouts() async {
    if (_isLoadingMore || !_hasMorePages) return;

    _isLoadingMore = true;
    notifyListeners();

    final nextPage = _currentPage + 1;
    final result =
        await _workoutRepository.getWorkoutsPage(page: nextPage, limit: 20);

    _isLoadingMore = false;

    if (result.isSuccess()) {
      final newItems = result.getOrThrow();
      if (newItems.isEmpty) {
        _hasMorePages = false;
      } else {
        _currentPage = nextPage;
        for (final w in newItems) {
          if (!_workouts.any((item) => item.id == w.id)) {
            _workouts.add(w);
          }
        }
        if (newItems.length < 20) {
          _hasMorePages = false;
        }
      }
    }

    notifyListeners();
  }

  Future<void> updateWorkouts() async {
    await loadWorkouts.executeWithFuture();
  }

  Future<Result<void>> deleteWorkout(Workout workout) async {
    if (workout.id == null) return Failure(Exception('Invalid workout ID'));
    if (!isWorkoutOwned(workout)) {
      return Failure(Exception('Cannot delete another user\'s workout'));
    }
    final result = await _workoutRepository.deleteWorkout(workout.id!);
    if (result.isSuccess()) {
      _workouts.removeWhere((w) => w.id == workout.id);
      notifyListeners();
    }
    return result;
  }

  Future<Result<Workout>> toggleLock(Workout workout) async {
    if (workout.id == null) return Failure(Exception('Invalid workout ID'));
    if (!isWorkoutOwned(workout)) {
      return Failure(Exception('Cannot lock another user\'s workout'));
    }
    final result = await _workoutRepository.toggleWorkoutLock(workout.id!);
    if (result.isSuccess()) {
      final updated = result.getOrThrow();
      final idx = _workouts.indexWhere((w) => w.id == workout.id);
      if (idx >= 0) {
        _workouts[idx] = updated;
        notifyListeners();
      }
    }
    return result;
  }
}
