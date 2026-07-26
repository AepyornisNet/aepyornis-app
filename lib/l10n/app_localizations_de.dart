// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get url => 'URL';

  @override
  String get apiKey => 'API-Schlüssel';

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
  String get connectHealth => 'Health verbinden';

  @override
  String get connectHealthSuccess => 'Zugriff gewährt';

  @override
  String get connectHealthFailure => 'Zugriff verweigert';

  @override
  String get syncHealthDaysLabel => 'Tage zum Synchronisieren';

  @override
  String get syncHealthDescription =>
      'Anzahl der letzten Tage, die importiert werden sollen.';

  @override
  String get syncHealthButton => 'Messungen synchronisieren';

  @override
  String syncHealthSuccess(int count) {
    return '$count Tag(e) importiert';
  }

  @override
  String get syncHealthFailure => 'Synchronisierung fehlgeschlagen';

  @override
  String get syncHealthInvalidDays => 'Bitte mindestens einen Tag angeben';

  @override
  String get healthConnect => 'Health Connect';

  @override
  String get healthKit => 'Apple Health';

  @override
  String get healthConnectSubtitle =>
      'Schritt- und Körperwert-Synchronisierung verwalten';

  @override
  String get aboutTitle => 'Über Workout Tracker';

  @override
  String get aboutSubtitle => 'Version 1.0.0+1';

  @override
  String get sectionIntegrations => 'Integrationen';

  @override
  String get sectionGeneral => 'Allgemein';

  @override
  String get sectionAccount => 'Konto';

  @override
  String get healthWorkouts => 'Health Workouts';

  @override
  String get healthWorkoutsSubtitle =>
      'Trainingseinheiten anzeigen und hochladen';

  @override
  String get syncAllWorkouts => 'Alle synchronisieren';

  @override
  String get workoutSynced => 'Synchronisiert';

  @override
  String get syncWorkout => 'Synchronisieren';

  @override
  String get syncingWorkout => 'Synchronisiere...';

  @override
  String get noWorkoutsFound =>
      'Keine Trainingseinheiten im Health-Speicher gefunden';

  @override
  String get hasGpsRoute => 'GPS Route';
}
