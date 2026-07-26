import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker_app/l10n/app_localizations.dart';
import 'package:workout_tracker_app/routing/routes.dart';
import 'package:workout_tracker_app/ui/settings/view_models/settings_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.viewModel});

  final SettingsViewModel viewModel;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.logout.addListener(_onLogoutResult);
  }

  @override
  void didUpdateWidget(covariant SettingsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.logout.removeListener(_onLogoutResult);
    widget.viewModel.logout.addListener(_onLogoutResult);
  }

  @override
  void dispose() {
    widget.viewModel.logout.removeListener(_onLogoutResult);
    super.dispose();
  }

  void _onLogoutResult() {
    if (widget.viewModel.logout.value?.isSuccess() ?? false) {
      widget.viewModel.logout.clearErrors();
      context.go(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final healthTitle = Platform.isIOS ? l10n.healthKit : l10n.healthConnect;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        children: [
          _buildSectionHeader(context, l10n.sectionIntegrations),
          const SizedBox(height: 6),
          Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite_rounded,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              title: Text(healthTitle),
              subtitle: Text(l10n.healthConnectSubtitle),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.push(Routes.settingsHealth),
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionHeader(context, l10n.sectionGeneral),
          const SizedBox(height: 6),
          Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.tertiaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: colorScheme.onTertiaryContainer,
                ),
              ),
              title: Text(l10n.aboutTitle),
              subtitle: Text(l10n.aboutSubtitle),
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionHeader(context, l10n.sectionAccount),
          const SizedBox(height: 6),
          Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: colorScheme.onErrorContainer,
                ),
              ),
              title: Text(
                l10n.logout,
                style: TextStyle(color: colorScheme.error),
              ),
              onTap: () => widget.viewModel.logout.execute(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
      ),
    );
  }
}
