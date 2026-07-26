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
}
