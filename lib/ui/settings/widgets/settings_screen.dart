import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:result_dart/result_dart.dart';
import 'package:workout_tracker_app/routing/routes.dart';
import 'package:workout_tracker_app/l10n/app_localizations.dart';

import 'package:workout_tracker_app/ui/settings/view_models/settings_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.viewModel});

  final SettingsViewModel viewModel;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _syncDaysController;

  @override
  void initState() {
    super.initState();
    _syncDaysController = TextEditingController(text: '7');
    widget.viewModel.logout.addListener(_onResult);
    widget.viewModel.connectHealth.addListener(_onConnectResult);
    widget.viewModel.syncHealthMeasurements.addListener(_onSyncResult);
  }

  @override
  void didUpdateWidget(covariant SettingsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.logout.removeListener(_onResult);
    oldWidget.viewModel.connectHealth.removeListener(_onConnectResult);
    oldWidget.viewModel.syncHealthMeasurements.removeListener(_onSyncResult);
    widget.viewModel.logout.addListener(_onResult);
    widget.viewModel.connectHealth.addListener(_onConnectResult);
    widget.viewModel.syncHealthMeasurements.addListener(_onSyncResult);
  }

  @override
  void dispose() {
    widget.viewModel.logout.removeListener(_onResult);
    widget.viewModel.connectHealth.removeListener(_onConnectResult);
    widget.viewModel.syncHealthMeasurements.removeListener(_onSyncResult);
    _syncDaysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Settings'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                widget.viewModel.connectHealth.execute();
              },
              child: Text(AppLocalizations.of(context)!.connectHealth),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _syncDaysController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context)!.syncHealthDaysLabel,
                      helperText:
                          AppLocalizations.of(context)!.syncHealthDescription,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListenableBuilder(
                    listenable: widget.viewModel.syncHealthMeasurements,
                    builder: (context, child) {
                      final syncing = widget
                          .viewModel.syncHealthMeasurements.isExecuting.value;
                      return FilledButton.tonal(
                        onPressed: syncing ? null : _onSyncPressed,
                        child: syncing
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(AppLocalizations.of(context)!
                                .syncHealthButton),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                widget.viewModel.logout.execute();
              },
              child: Text(AppLocalizations.of(context)!.logout),
            ),
          ],
        ),
      ),
    );
  }

  void _onResult() {
    if (widget.viewModel.logout.value!.isSuccess()) {
      widget.viewModel.logout.clearErrors();
      context.go(Routes.login);
    }
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
}
