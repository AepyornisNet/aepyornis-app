import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:result_dart/result_dart.dart';
import 'package:workout_tracker_app/l10n/app_localizations.dart';
import 'package:workout_tracker_app/routing/routes.dart';
import 'package:workout_tracker_app/ui/settings/view_models/settings_viewmodel.dart';

class HealthConnectSettingsScreen extends StatefulWidget {
  const HealthConnectSettingsScreen({super.key, required this.viewModel});

  final SettingsViewModel viewModel;

  @override
  State<HealthConnectSettingsScreen> createState() =>
      _HealthConnectSettingsScreenState();
}

class _HealthConnectSettingsScreenState
    extends State<HealthConnectSettingsScreen> {
  late final TextEditingController _syncDaysController;

  @override
  void initState() {
    super.initState();
    _syncDaysController = TextEditingController(text: '7');
    widget.viewModel.connectHealth.addListener(_onConnectResult);
    widget.viewModel.syncHealthMeasurements.addListener(_onSyncResult);
  }

  @override
  void didUpdateWidget(covariant HealthConnectSettingsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.connectHealth.removeListener(_onConnectResult);
    oldWidget.viewModel.syncHealthMeasurements.removeListener(_onSyncResult);
    widget.viewModel.connectHealth.addListener(_onConnectResult);
    widget.viewModel.syncHealthMeasurements.addListener(_onSyncResult);
  }

  @override
  void dispose() {
    widget.viewModel.connectHealth.removeListener(_onConnectResult);
    widget.viewModel.syncHealthMeasurements.removeListener(_onSyncResult);
    _syncDaysController.dispose();
    super.dispose();
  }

  void _onConnectResult() {
    if (!mounted) {
      return;
    }

    final granted = widget.viewModel.connectHealth.value;
    if (granted == null) {
      return;
    }

    final message = granted
        ? AppLocalizations.of(context)!.connectHealthSuccess
        : AppLocalizations.of(context)!.connectHealthFailure;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _onSyncResult() {
    if (!mounted) {
      return;
    }

    final Result<int>? result = widget.viewModel.syncHealthMeasurements.value;
    if (result == null) {
      return;
    }

    if (result.isSuccess()) {
      final count = result.getOrNull() ?? 0;
      final message =
          AppLocalizations.of(context)!.syncHealthSuccess(count);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.syncHealthFailure),
        ),
      );
    }
  }

  void _onSyncPressed() {
    final days = int.tryParse(_syncDaysController.text.trim()) ?? 0;
    if (days <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.syncHealthInvalidDays),
        ),
      );
      return;
    }

    widget.viewModel.syncHealthMeasurements.execute(days);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final healthTitle = Platform.isIOS ? l10n.healthKit : l10n.healthConnect;

    return Scaffold(
      appBar: AppBar(
        title: Text(healthTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_rounded,
                        color: colorScheme.primary,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          healthTitle,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.healthConnectSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        widget.viewModel.connectHealth.execute();
                      },
                      icon: const Icon(Icons.link_rounded),
                      label: Text(l10n.connectHealth),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.fitness_center_rounded,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
              title: Text(l10n.healthWorkouts),
              subtitle: Text(l10n.healthWorkoutsSubtitle),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.push(Routes.settingsHealthWorkouts),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manual Data Import',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _syncDaysController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: l10n.syncHealthDaysLabel,
                      helperText: l10n.syncHealthDescription,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListenableBuilder(
                    listenable: widget.viewModel.syncHealthMeasurements,
                    builder: (context, child) {
                      final syncing = widget
                          .viewModel.syncHealthMeasurements.isExecuting.value;
                      return SizedBox(
                        width: double.infinity,
                        child: FilledButton.tonalIcon(
                          onPressed: syncing ? null : _onSyncPressed,
                          icon: syncing
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.sync_rounded),
                          label: Text(l10n.syncHealthButton),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
