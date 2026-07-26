import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:intl/intl.dart';
import 'package:aepyornis_app/l10n/app_localizations.dart';
import 'package:aepyornis_app/ui/core/utils/formatters.dart';
import 'package:aepyornis_app/ui/settings/view_models/health_workouts_viewmodel.dart';

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
    widget.viewModel.syncWorkout.addListener(_onSyncWorkoutResult);
  }

  @override
  void didUpdateWidget(covariant HealthWorkoutsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.syncAll.removeListener(_onSyncAllResult);
    oldWidget.viewModel.syncWorkout.removeListener(_onSyncWorkoutResult);
    widget.viewModel.syncAll.addListener(_onSyncAllResult);
    widget.viewModel.syncWorkout.addListener(_onSyncWorkoutResult);
  }

  @override
  void dispose() {
    widget.viewModel.syncAll.removeListener(_onSyncAllResult);
    widget.viewModel.syncWorkout.removeListener(_onSyncWorkoutResult);
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

  void _onSyncWorkoutResult() {
    if (!mounted) {
      return;
    }
    final res = widget.viewModel.syncWorkout.value;
    if (res != null && res.isError()) {
      final error = res.exceptionOrNull();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sync failed: ${error?.toString() ?? "Unknown error"}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
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
      ),
      floatingActionButton: ListenableBuilder(
        listenable: Listenable.merge([
          widget.viewModel,
          widget.viewModel.syncAll.isExecuting,
        ]),
        builder: (context, child) {
          final hasUnsynced = widget.viewModel.workouts.any((w) => !w.isSynced);
          if (!hasUnsynced) {
            return const SizedBox.shrink();
          }

          final isSyncingAll = widget.viewModel.syncAll.isExecuting.value;

          return FloatingActionButton.extended(
            onPressed:
                isSyncingAll ? null : () => widget.viewModel.syncAll.execute(),
            icon: isSyncingAll
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.sync_rounded),
            label: Text(isSyncingAll ? l10n.syncingWorkout : l10n.syncAllWorkouts),
          );
        },
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
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
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 16.0,
                      bottom: 88.0,
                    ),
                    itemCount: widget.viewModel.workouts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == widget.viewModel.workouts.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: OutlinedButton.icon(
                              onPressed: widget.viewModel.loadMore,
                              icon: const Icon(Icons.history_rounded),
                              label: Text(
                                'Load older workouts (${widget.viewModel.daysToLoad} days)',
                              ),
                            ),
                          ),
                        );
                      }
                      final item = widget.viewModel.workouts[index];
                      return _buildWorkoutCard(
                        context,
                        item,
                        l10n,
                        colorScheme,
                      );
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
                Icons.check_circle_outline_rounded,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.noWorkoutsFound,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => widget.viewModel.loadWorkouts.execute(),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Refresh'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: widget.viewModel.loadMore,
                    icon: const Icon(Icons.history_rounded),
                    label: Text(
                      'Load older (${widget.viewModel.daysToLoad}d)',
                    ),
                  ),
                ],
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
    final durationStr = formatWorkoutDuration(item.duration.inSeconds);

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
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
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          item.title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (item.hasRoute) ...[
                        const SizedBox(width: 6),
                        Icon(
                          Icons.route_rounded,
                          size: 18,
                          color: colorScheme.tertiary,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _dateFormat.format(item.session.startTime),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    durationStr,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
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
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
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

    if (item.errorMessage != null) {
      return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.error,
          side: BorderSide(color: colorScheme.error),
        ),
        onPressed: () => widget.viewModel.syncWorkout.execute(item),
        icon: const Icon(Icons.error_outline_rounded, size: 16),
        label: const Text('Retry'),
      );
    }

    return IconButton.filledTonal(
      onPressed: () => widget.viewModel.syncWorkout.execute(item),
      icon: const Icon(Icons.cloud_upload_rounded),
      tooltip: l10n.syncWorkout,
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
