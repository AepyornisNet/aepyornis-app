import 'package:result_dart/result_dart.dart';
import 'package:workout_tracker_app/domain/models/workout/workout.dart';
import 'package:workout_tracker_app/domain/models/workout_reply/workout_reply.dart';

abstract class WorkoutRepository {
  // Returns cached workouts if available
  List<Workout>? get cachedWorkouts;

  // Returns all [Workout]s
  Future<Result<List<Workout>>> getAll();

  // Returns all [Workout]s
  Future<Result<Workout>> getOne(int id);

  // Fetches the full [Workout] list from the server and updates the local cache
  Future<Result<void>> updateWorkouts();

  // Adds a newly created or uploaded [Workout] to local repository cache
  void addWorkout(Workout workout);

  // Returns recent workouts for social feed
  Future<Result<List<Workout>>> getRecentWorkouts({
    int limit = 10,
    int offset = 0,
    String scope = 'following',
  });

  // Toggles like status for a workout
  Future<Result<Map<String, dynamic>>> likeWorkout(int workoutId);

  // Fetches replies/comments for a workout
  Future<Result<List<WorkoutReply>>> getWorkoutReplies(int workoutId);

  // Posts a new reply/comment for a workout
  Future<Result<WorkoutReply>> createReply(int workoutId, String content);
}
