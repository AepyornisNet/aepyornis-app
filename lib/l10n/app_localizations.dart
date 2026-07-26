import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url;

  /// No description provided for @apiKey.
  ///
  /// In en, this message translates to:
  /// **'API-Key'**
  String get apiKey;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @trainings.
  ///
  /// In en, this message translates to:
  /// **'Trainings'**
  String get trainings;

  /// No description provided for @recording.
  ///
  /// In en, this message translates to:
  /// **'Recording'**
  String get recording;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Could not login'**
  String get loginError;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @total_duration.
  ///
  /// In en, this message translates to:
  /// **'Total duration'**
  String get total_duration;

  /// No description provided for @time_paused.
  ///
  /// In en, this message translates to:
  /// **'Time paused'**
  String get time_paused;

  /// No description provided for @total_distance.
  ///
  /// In en, this message translates to:
  /// **'Total distance'**
  String get total_distance;

  /// No description provided for @average_speed.
  ///
  /// In en, this message translates to:
  /// **'Average speed'**
  String get average_speed;

  /// No description provided for @average_speed_no_pause.
  ///
  /// In en, this message translates to:
  /// **'Average speed (no pause)'**
  String get average_speed_no_pause;

  /// No description provided for @average_tempo.
  ///
  /// In en, this message translates to:
  /// **'Average tempo'**
  String get average_tempo;

  /// No description provided for @average_tempo_no_pause.
  ///
  /// In en, this message translates to:
  /// **'Average tempo (no pause)'**
  String get average_tempo_no_pause;

  /// No description provided for @max_speed.
  ///
  /// In en, this message translates to:
  /// **'Max speed'**
  String get max_speed;

  /// No description provided for @min_elevation.
  ///
  /// In en, this message translates to:
  /// **'Min elevation'**
  String get min_elevation;

  /// No description provided for @max_elevation.
  ///
  /// In en, this message translates to:
  /// **'Max elevation'**
  String get max_elevation;

  /// No description provided for @total_up.
  ///
  /// In en, this message translates to:
  /// **'Total up'**
  String get total_up;

  /// No description provided for @total_down.
  ///
  /// In en, this message translates to:
  /// **'Total down'**
  String get total_down;

  /// No description provided for @est_calories_burned.
  ///
  /// In en, this message translates to:
  /// **'Est. calories burned'**
  String get est_calories_burned;

  /// No description provided for @equipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get equipment;

  /// No description provided for @extra_metrics.
  ///
  /// In en, this message translates to:
  /// **'Extra metrics'**
  String get extra_metrics;

  /// No description provided for @total_repetitions.
  ///
  /// In en, this message translates to:
  /// **'Total repetitions'**
  String get total_repetitions;

  /// No description provided for @total_weight.
  ///
  /// In en, this message translates to:
  /// **'Total weight'**
  String get total_weight;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @connectHealth.
  ///
  /// In en, this message translates to:
  /// **'Connect Health'**
  String get connectHealth;

  /// No description provided for @connectHealthSuccess.
  ///
  /// In en, this message translates to:
  /// **'Health access granted'**
  String get connectHealthSuccess;

  /// No description provided for @connectHealthFailure.
  ///
  /// In en, this message translates to:
  /// **'Health permission denied'**
  String get connectHealthFailure;

  /// No description provided for @syncHealthDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Days to sync'**
  String get syncHealthDaysLabel;

  /// No description provided for @syncHealthDescription.
  ///
  /// In en, this message translates to:
  /// **'Number of recent days to import from health store.'**
  String get syncHealthDescription;

  /// No description provided for @syncHealthButton.
  ///
  /// In en, this message translates to:
  /// **'Sync measurements'**
  String get syncHealthButton;

  /// No description provided for @syncHealthSuccess.
  ///
  /// In en, this message translates to:
  /// **'Synced {count} day(s) from health store'**
  String syncHealthSuccess(int count);

  /// No description provided for @syncHealthFailure.
  ///
  /// In en, this message translates to:
  /// **'Health sync failed'**
  String get syncHealthFailure;

  /// No description provided for @syncHealthInvalidDays.
  ///
  /// In en, this message translates to:
  /// **'Enter at least one day'**
  String get syncHealthInvalidDays;

  /// No description provided for @healthConnect.
  ///
  /// In en, this message translates to:
  /// **'Health Connect'**
  String get healthConnect;

  /// No description provided for @healthKit.
  ///
  /// In en, this message translates to:
  /// **'Apple Health'**
  String get healthKit;

  /// No description provided for @healthConnectSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure step tracking and body measurements sync'**
  String get healthConnectSubtitle;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Workout Tracker'**
  String get aboutTitle;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0+1'**
  String get aboutSubtitle;

  /// No description provided for @sectionIntegrations.
  ///
  /// In en, this message translates to:
  /// **'Integrations'**
  String get sectionIntegrations;

  /// No description provided for @sectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get sectionGeneral;

  /// No description provided for @sectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get sectionAccount;

  /// No description provided for @healthWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Health Workouts'**
  String get healthWorkouts;

  /// No description provided for @healthWorkoutsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'List and upload exercise sessions from health store'**
  String get healthWorkoutsSubtitle;

  /// No description provided for @syncAllWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Sync All Unsynced'**
  String get syncAllWorkouts;

  /// No description provided for @workoutSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get workoutSynced;

  /// No description provided for @syncWorkout.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get syncWorkout;

  /// No description provided for @syncingWorkout.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get syncingWorkout;

  /// No description provided for @noWorkoutsFound.
  ///
  /// In en, this message translates to:
  /// **'No exercise sessions found in health store'**
  String get noWorkoutsFound;

  /// No description provided for @hasGpsRoute.
  ///
  /// In en, this message translates to:
  /// **'GPS Route'**
  String get hasGpsRoute;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
