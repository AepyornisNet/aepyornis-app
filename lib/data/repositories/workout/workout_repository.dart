import 'package:result_dart/result_dart.dart';
import 'package:workout_tracker_app/domain/models/workout/workout.dart';

abstract class WorkoutRepository {
  // Returns all [Workout]s
  Future<Result<List<Workout>>> getAll();

  // Returns all [Workout]s
  Future<Result<Workout>> getOne(int id);

  // Fetches the full [Workout] list from the server and updates the local cache
  Future<Result<void>> updateWorkouts();

  // Adds a newly created or uploaded [Workout] to local repository cache
  void addWorkout(Workout workout);
}
