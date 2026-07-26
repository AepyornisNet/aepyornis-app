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
  String get login => 'Anmelden';

  @override
  String get logout => 'Abmelden';

  @override
  String get home => 'Home';

  @override
  String get trainings => 'Trainings';

  @override
  String get recording => 'Aufzeichnung';

  @override
  String get statistics => 'Statistiken';

  @override
  String get settings => 'Einstellungen';

  @override
  String get loginError => 'Anmeldung fehlgeschlagen';

  @override
  String get location => 'Ort';

  @override
  String get source => 'Quelle';

  @override
  String get total_duration => 'Gesamtdauer';

  @override
  String get time_paused => 'Pausenzeit';

  @override
  String get total_distance => 'Gesamtdistanz';

  @override
  String get average_speed => 'Ø Geschwindigkeit';

  @override
  String get average_speed_no_pause => 'Ø Geschwindigkeit (ohne Pause)';

  @override
  String get average_tempo => 'Ø Tempo';

  @override
  String get average_tempo_no_pause => 'Ø Tempo (ohne Pause)';

  @override
  String get max_speed => 'Max. Geschwindigkeit';

  @override
  String get min_elevation => 'Min. Höhe';

  @override
  String get max_elevation => 'Max. Höhe';

  @override
  String get total_up => 'Höhenmeter auf';

  @override
  String get total_down => 'Höhenmeter ab';

  @override
  String get est_calories_burned => 'Geschätzte Kalorien';

  @override
  String get equipment => 'Ausrüstung';

  @override
  String get extra_metrics => 'Zusätzliche Metriken';

  @override
  String get total_repetitions => 'Wiederholungen gesamt';

  @override
  String get total_weight => 'Gesamtgewicht';

  @override
  String get steps => 'Schritte';

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

  @override
  String get workoutDetail => 'Trainingsdetails';

  @override
  String get following => 'Gefolgt';

  @override
  String get global => 'Global';

  @override
  String get failedToLoadFeed => 'Feed konnte nicht geladen werden';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get noActivitiesFound => 'Keine Aktivitäten gefunden';

  @override
  String get emptyFeedFollowing =>
      'Folge Nutzern, um hier ihre Aktivitäten zu sehen.';

  @override
  String get emptyFeedGlobal => 'Noch keine globalen Aktivitäten.';

  @override
  String get athlete => 'Athlet';

  @override
  String likesAndComments(int likesCount, int repliesCount) {
    return '$likesCount Likes • $repliesCount Kommentare';
  }

  @override
  String get noCommentsYet =>
      'Noch keine Kommentare. Schreibe den ersten Kommentar!';

  @override
  String get addComment => 'Kommentar hinzufügen...';

  @override
  String get like => 'Gefällt mir';

  @override
  String get comments => 'Kommentare';

  @override
  String get summary => 'Zusammenfassung';

  @override
  String get metricsAndDetails => 'Metriken & Details';

  @override
  String get notes => 'Notizen';

  @override
  String get avgHeartRate => 'Ø Herzfrequenz';

  @override
  String get maxHeartRate => 'Max. Herzfrequenz';

  @override
  String get avgCadence => 'Ø Trittfrequenz';

  @override
  String get maxCadence => 'Max. Trittfrequenz';

  @override
  String get avgPower => 'Ø Leistung';

  @override
  String get maxPower => 'Max. Leistung';

  @override
  String get speed => 'Geschwindigkeit';

  @override
  String get elevation => 'Höhe';

  @override
  String get heartRate => 'Herzfrequenz';

  @override
  String get cadence => 'Trittfrequenz';

  @override
  String get power => 'Leistung';

  @override
  String get timeMin => 'Zeit (min)';

  @override
  String get distKm => 'Distanz (km)';

  @override
  String noDataForMetric(String metricName) {
    return 'Keine Daten für $metricName';
  }

  @override
  String get overview => 'Übersicht';

  @override
  String get records => 'Rekorde';

  @override
  String get since => 'Seit';

  @override
  String get per => 'Pro';

  @override
  String get day => 'Tag';

  @override
  String get week => 'Woche';

  @override
  String get month => 'Monat';

  @override
  String get year => 'Jahr';

  @override
  String get days7 => '7 Tage';

  @override
  String get month1 => '1 Monat';

  @override
  String get months3 => '3 Monate';

  @override
  String get months6 => '6 Monate';

  @override
  String get year1 => '1 Jahr';

  @override
  String get years2 => '2 Jahre';

  @override
  String get years5 => '5 Jahre';

  @override
  String get years10 => '10 Jahre';

  @override
  String get forever => 'Für immer';

  @override
  String get noStatisticsAvailable => 'Keine Statistiken verfügbar';

  @override
  String get noRecordsAvailable => 'Keine Rekorde verfügbar';

  @override
  String get workoutsCount => 'Workouts';

  @override
  String get distanceKm => 'Distanz (km)';
}
