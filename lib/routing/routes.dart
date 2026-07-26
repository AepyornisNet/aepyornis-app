abstract final class Routes {
  static const main = '/';
  static const home = '/home';
  static const login = '/login';
  static const workouts = '/$workoutRelative';
  static const workoutRelative = 'workout';
  static const workoutCreateRelative = 'new';
  static const workoutCreate = '$workouts/$workoutCreateRelative';
  static String workoutWithId(int id) => '$workouts/$id';
  static const record = '/record';
  static const stats = '/statistics';
  static const settings = '/settings';
  static const settingsHealthRelative = 'health';
  static const settingsHealth = '$settings/$settingsHealthRelative';
  static const settingsHealthWorkoutsRelative = 'workouts';
  static const settingsHealthWorkouts =
      '$settingsHealth/$settingsHealthWorkoutsRelative';
}
