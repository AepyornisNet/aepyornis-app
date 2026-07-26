import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracker_app/l10n/app_localizations.dart';
import 'package:workout_tracker_app/ui/settings/view_models/health_workouts_viewmodel.dart';

class HealthWorkoutsScreen extends StatefulWidget {
  const HealthWorkoutsScreen({super.key, required this.viewModel});

  final HealthWorkoutsViewModel viewModel;

  @override
  State<HealthWorkoutsScreen> createState() => _HealthWorkoutsScreenState();
}

class _HealthWorkoutsScreenState extends State<HealthWorkoutsScreen> {
  late final DateFormat _dateFormat;

  @override
  void initState() {
    super.initState();
    _dateFormat = DateFormat.yMMMd().add_jm();
    widget.viewModel.loadWorkouts.execute();
    widget.viewModel.syncAll.addListener(_onSyncAllResult);
  }

  @override
  void didUpdateWidget(covariant HealthWorkoutsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.syncAll.removeListener(_onSyncAllResult);
    widget.viewModel.syncAll.addListener(_onSyncAllResult);
  }

  @override
  void dispose() {
    widget.viewModel.syncAll.removeListener(_onSyncAllResult);
    super.dispose();
  }

  void _onSyncAllResult() {
    if (!mounted) {
      return;
    }
    final res = widget.viewModel.syncAll.value;
    if (res != null && res.isSuccess()) {
      final count = res.getOrNull() ?? 0;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully synced $count workout(s)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.healthWorkouts),
        actions: [
          ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, child) {
              final hasUnsynced = widget.viewModel.workouts.any((w) => !w.isSynced);
              return TextButton.icon(
                onPressed: hasUnsynced
                    ? () => widget.viewModel.syncAll.execute()
                    : null,
                icon: const Icon(Icons.sync_rounded),
                label: Text(l10n.syncAllWorkouts),
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel.loadWorkouts,
        builder: (context, child) {
          final isLoading = widget.viewModel.loadWorkouts.isExecuting.value;
          if (isLoading && widget.viewModel.workouts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              widget.viewModel.loadWorkouts.execute();
            },
            child: widget.viewModel.workouts.isEmpty
                ? _buildEmptyView(context, l10n)
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: widget.viewModel.workouts.length,
                    itemBuilder: (context, index) {
                      final item = widget.viewModel.workouts[index];
                      return _buildWorkoutCard(context, item, l10n, colorScheme);
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context, AppLocalizations l10n) {
    return ListView(
      children: [
        const SizedBox(height: 80),
        Center(
          child: Column(
            children: [
              Icon(
                Icons.directions_run_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.noWorkoutsFound,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => widget.viewModel.loadWorkouts.execute(),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Refresh'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutCard(
    BuildContext context,
    HealthWorkoutItem item,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    final minutes = item.duration.inMinutes;
    final seconds = item.duration.inSeconds % 60;
    final durationStr = '${minutes}m ${seconds}s';

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getExerciseIcon(item.session.exerciseType),
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _dateFormat.format(item.session.startTime),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        durationStr,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      if (item.hasRoute) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.map_rounded,
                                size: 12,
                                color: colorScheme.onTertiaryContainer,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                l10n.hasGpsRoute,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onTertiaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _buildSyncAction(item, l10n, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncAction(
    HealthWorkoutItem item,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    if (item.isSyncing) {
      return const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 2.5),
      );
    }

    if (item.isSynced) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 16,
              color: colorScheme.onSecondaryContainer,
            ),
            const SizedBox(width: 4),
            Text(
              l10n.workoutSynced,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      );
    }

    return FilledButton.tonal(
      onPressed: () => widget.viewModel.syncWorkout.execute(item),
      child: Text(l10n.syncWorkout),
    );
  }

  IconData _getExerciseIcon(ExerciseType type) {
    switch (type) {
      case ExerciseType.running:
      case ExerciseType.runningTreadmill:
        return Icons.directions_run_rounded;
      case ExerciseType.cycling:
      case ExerciseType.cyclingStationary:
        return Icons.directions_bike_rounded;
      case ExerciseType.walking:
      case ExerciseType.hiking:
        return Icons.directions_walk_rounded;
      default:
        return Icons.fitness_center_rounded;
    }
  }
}
