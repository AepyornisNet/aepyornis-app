import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:aepyornis_app/config/dependencies.dart';
import 'package:aepyornis_app/data/repositories/auth/auth_repository_remote.dart';
import 'package:aepyornis_app/data/repositories/measurement/measurement_repository_remote.dart';
import 'package:aepyornis_app/data/services/api/api_client.dart';
import 'package:aepyornis_app/data/services/health_connect/health_connect_service.dart';
import 'package:aepyornis_app/data/services/shared_preferences_service.dart';
import 'package:aepyornis_app/routing/router.dart';
import 'package:aepyornis_app/ui/core/themes/theme.dart';

void main() {
  Command.globalExceptionHandler = (error, stackTrace) {
    debugPrint(
        '[CommandError] ${error.commandName ?? 'unknown'}: ${error.error}');
  };

  Intl.defaultLocale = Platform.localeName;
  initializeDateFormatting(Platform.localeName, null).then((_) {
    runApp(MultiProvider(providers: providersRemote, child: const MainApp()));
  });
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Aepyornis',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }

  Future<void> initPlatformState() async {
    BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 55,
        stopOnTerminate: false,
        enableHeadless: true,
        startOnBoot: true,
        requiresBatteryNotLow: true,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.ANY,
      ),
      (String taskId) async {
        debugPrint('[BackgroundFetch] Event received $taskId');
        backgroundUpdateSteps();
        BackgroundFetch.finish(taskId);
      },
      (String taskId) async {
        debugPrint('[BackgroundFetch] Timeout $taskId');
        BackgroundFetch.finish(taskId);
      },
    );
  }
}

Future<void> backgroundUpdateSteps() async {
  final sharedPreferencesService = SharedPreferencesService();
  if (!await sharedPreferencesService.getSyncHealthConnect()) {
    return;
  }

  final apiClient = ApiClient();
  final authRepo = AuthRepositoryRemote(
    apiClient: apiClient,
    sharedPreferencesService: sharedPreferencesService,
  );

  if (!await authRepo.isAuthenticated) {
    return;
  }

  final healthConnectService = HealthConnectService();
  final metrics = await healthConnectService.readDailyMetrics(DateTime.now());
  if (metrics == null) {
    return;
  }

  await MeasurementRepositoryRemote(apiClient: apiClient).upsertMeasurement(
    date: metrics.date,
    steps: metrics.steps,
    weightKg: metrics.weightKg,
    heightCm: metrics.heightCm,
    restingHeartRate: metrics.restingHeartRateBpm,
  );
}
