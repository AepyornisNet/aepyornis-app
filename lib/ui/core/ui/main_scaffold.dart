import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:aepyornis_app/l10n/app_localizations.dart';

class MainScaffold extends StatelessWidget {
  static const Key homeScreenKey = ValueKey('home_screen');
  static const Key trainingsScreenKey = ValueKey('trainings_screen');
  static const Key statisticsScreenKey = ValueKey('statistics_screen');
  static const Key settingsScreenKey = ValueKey('settings_screen');

  final StatefulNavigationShell navigationShell;

  const MainScaffold(this.navigationShell, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center),
            label: AppLocalizations.of(context)!.trainings,
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: AppLocalizations.of(context)!.statistics,
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
    );
  }
}
