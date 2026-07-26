import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'package:aepyornis_app/config/dependencies.dart';
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Aepyornis',
      localizationsDelegates: const [
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
}
