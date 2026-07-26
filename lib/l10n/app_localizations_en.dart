// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get url => 'URL';

  @override
  String get apiKey => 'API-Key';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get home => 'Home';

  @override
  String get trainings => 'Trainings';

  @override
  String get recording => 'Recording';

  @override
  String get statistics => 'Statistics';

  @override
  String get settings => 'Settings';

  @override
  String get loginError => 'Could not login';

  @override
  String get location => 'Location';

  @override
  String get source => 'Source';

  @override
  String get total_duration => 'Total duration';

  @override
  String get time_paused => 'Time paused';

  @override
  String get total_distance => 'Total distance';

  @override
  String get average_speed => 'Average speed';

  @override
  String get average_speed_no_pause => 'Average speed (no pause)';

  @override
  String get average_tempo => 'Average tempo';

  @override
  String get average_tempo_no_pause => 'Average tempo (no pause)';

  @override
  String get max_speed => 'Max speed';

  @override
  String get min_elevation => 'Min elevation';

  @override
  String get max_elevation => 'Max elevation';

  @override
  String get total_up => 'Total up';

  @override
  String get total_down => 'Total down';

  @override
  String get est_calories_burned => 'Est. calories burned';

  @override
  String get equipment => 'Equipment';

  @override
  String get extra_metrics => 'Extra metrics';

  @override
  String get total_repetitions => 'Total repetitions';

  @override
  String get total_weight => 'Total weight';

  @override
  String get steps => 'Steps';

  @override
  String get connectHealth => 'Connect Health';

  @override
  String get connectHealthSuccess => 'Health access granted';

  @override
  String get connectHealthFailure => 'Health permission denied';

  @override
  String get syncHealthDaysLabel => 'Days to sync';

  @override
  String get syncHealthDescription =>
      'Number of recent days to import from health store.';

  @override
  String get syncHealthButton => 'Sync measurements';

  @override
  String syncHealthSuccess(int count) {
    return 'Synced $count day(s) from health store';
  }

  @override
  String get syncHealthFailure => 'Health sync failed';

  @override
  String get syncHealthInvalidDays => 'Enter at least one day';

  @override
  String get healthConnect => 'Health Connect';

  @override
  String get healthKit => 'Apple Health';

  @override
  String get healthConnectSubtitle =>
      'Configure step tracking and body measurements sync';

  @override
  String get aboutTitle => 'About Workout Tracker';

  @override
  String get aboutSubtitle => 'Version 1.0.0+1';

  @override
  String get sectionIntegrations => 'Integrations';

  @override
  String get sectionGeneral => 'General';

  @override
  String get sectionAccount => 'Account';

  @override
  String get healthWorkouts => 'Health Workouts';

  @override
  String get healthWorkoutsSubtitle =>
      'List and upload exercise sessions from health store';

  @override
  String get syncAllWorkouts => 'Sync All Unsynced';

  @override
  String get workoutSynced => 'Synced';

  @override
  String get syncWorkout => 'Sync';

  @override
  String get syncingWorkout => 'Syncing...';

  @override
  String get noWorkoutsFound => 'No exercise sessions found in health store';

  @override
  String get hasGpsRoute => 'GPS Route';

  @override
  String get workoutDetail => 'Workout Detail';

  @override
  String get following => 'Following';

  @override
  String get global => 'Global';

  @override
  String get failedToLoadFeed => 'Failed to load feed';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get noActivitiesFound => 'No activities found';

  @override
  String get emptyFeedFollowing => 'Follow users to see their activities here.';

  @override
  String get emptyFeedGlobal => 'No global activities yet.';

  @override
  String get athlete => 'Athlete';

  @override
  String likesAndComments(int likesCount, int repliesCount) {
    return '$likesCount likes • $repliesCount comments';
  }

  @override
  String get noCommentsYet => 'No comments yet. Be the first to comment!';

  @override
  String get addComment => 'Add a comment...';

  @override
  String get like => 'Like';

  @override
  String get comments => 'Comments';

  @override
  String get summary => 'Summary';

  @override
  String get metricsAndDetails => 'Metrics & Details';

  @override
  String get notes => 'Notes';

  @override
  String get avgHeartRate => 'Avg Heart Rate';

  @override
  String get maxHeartRate => 'Max Heart Rate';

  @override
  String get avgCadence => 'Avg Cadence';

  @override
  String get maxCadence => 'Max Cadence';

  @override
  String get avgPower => 'Avg Power';

  @override
  String get maxPower => 'Max Power';

  @override
  String get speed => 'Speed';

  @override
  String get elevation => 'Elevation';

  @override
  String get heartRate => 'Heart Rate';

  @override
  String get cadence => 'Cadence';

  @override
  String get power => 'Power';

  @override
  String get timeMin => 'Time (min)';

  @override
  String get distKm => 'Dist (km)';

  @override
  String noDataForMetric(String metricName) {
    return 'No data for $metricName';
  }

  @override
  String get overview => 'Overview';

  @override
  String get records => 'Records';

  @override
  String get since => 'Since';

  @override
  String get per => 'Per';

  @override
  String get day => 'Day';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get days7 => '7 days';

  @override
  String get month1 => '1 month';

  @override
  String get months3 => '3 months';

  @override
  String get months6 => '6 months';

  @override
  String get year1 => '1 year';

  @override
  String get years2 => '2 years';

  @override
  String get years5 => '5 years';

  @override
  String get years10 => '10 years';

  @override
  String get forever => 'Forever';

  @override
  String get noStatisticsAvailable => 'No statistics available';

  @override
  String get noRecordsAvailable => 'No records available';

  @override
  String get workoutsCount => 'Workouts';

  @override
  String get distanceKm => 'Distance (km)';
}
