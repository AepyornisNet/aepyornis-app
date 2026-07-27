import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';
import 'package:aepyornis_app/l10n/app_localizations.dart';
import 'package:aepyornis_app/routing/routes.dart';
import 'package:aepyornis_app/ui/workout/detail/view_models/workout_detail_viewmodel.dart';
import 'package:aepyornis_app/ui/workout/detail/widgets/workout_climbs_widget.dart';
import 'package:aepyornis_app/ui/workout/detail/widgets/workout_detail_chart.dart';
import 'package:aepyornis_app/ui/workout/detail/widgets/workout_detail_data.dart';
import 'package:aepyornis_app/ui/workout/detail/widgets/workout_detail_map.dart';
import 'package:aepyornis_app/ui/workout/detail/widgets/workout_records_widget.dart';
import 'package:aepyornis_app/ui/workout/detail/widgets/workout_zone_distribution_widget.dart';

extension WorkoutGeoInfo on Workout {
  bool get hasGeoInfo {
    final points = data?.details?.points;
    if (points != null && points.any((p) => p.lat != 0.0 || p.lng != 0.0)) {
      return true;
    }
    if (data?.center != null &&
        (data!.center!.lat != 0.0 || data!.center!.lng != 0.0)) {
      return true;
    }
    return false;
  }
}

class WorkoutDetailScreen extends StatefulWidget {
  const WorkoutDetailScreen({super.key, required this.viewModel});

  final WorkoutDetailViewModel viewModel;

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.workoutDetail ?? 'Workout Detail'),
        elevation: 0,
        actions: [
          ListenableBuilder(
            listenable: widget.viewModel.loadWorkout,
            builder: (context, child) {
              final workout = widget.viewModel.workout;
              if (workout == null || !widget.viewModel.isCurrentOwner) {
                return const SizedBox.shrink();
              }

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (workout.locked)
                    IconButton(
                      icon: const Icon(Icons.lock_rounded, size: 20),
                      tooltip: 'Locked',
                      onPressed: () => _toggleLock(context),
                    ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) =>
                        _handleAction(context, value, workout),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_rounded, size: 20),
                            SizedBox(width: 12),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      if (workout.hasFile)
                        const PopupMenuItem(
                          value: 'refresh',
                          child: Row(
                            children: [
                              Icon(Icons.refresh_rounded, size: 20),
                              SizedBox(width: 12),
                              Text('Refresh'),
                            ],
                          ),
                        ),
                      PopupMenuItem(
                        value: 'toggleLock',
                        child: Row(
                          children: [
                            Icon(
                              workout.locked
                                  ? Icons.lock_open_rounded
                                  : Icons.lock_rounded,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(workout.locked ? 'Unlock' : 'Lock'),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline_rounded,
                                size: 20, color: Colors.red),
                            SizedBox(width: 12),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel.loadWorkout,
        builder: (context, child) {
          final workout = widget.viewModel.workout;
          if (workout == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final showMap = workout.hasGeoInfo;

          if (showMap) {
            return _buildLocationLayout(context, workout);
          } else {
            return _buildNonLocationLayout(context, workout);
          }
        },
      ),
    );
  }

  Widget _buildLocationLayout(BuildContext context, Workout workout) {
    final details = workout.data?.details;
    final hasPoints = details != null && details.points.isNotEmpty;

    final mediaQuery = MediaQuery.of(context);
    const initialSheetSize = 0.45;
    final bottomSheetHeight = mediaQuery.size.height * initialSheetSize;

    final mapPadding = EdgeInsets.only(
      top: 40,
      left: 32,
      right: 32,
      bottom: bottomSheetHeight + 24,
    );

    return Stack(
      children: [
        // Full screen map with custom bottom padding so route is fully framed above sheet
        Positioned.fill(
          child: WorkoutDetailMap(
            workout: workout,
            mapPadding: mapPadding,
          ),
        ),

        // Bottom sheet for workout details overlaying the map
        DraggableScrollableSheet(
          initialChildSize: initialSheetSize,
          minChildSize: 0.25,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.only(top: 12, bottom: 32),
                children: [
                  // Drag indicator handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Header section
                  _WorkoutHeader(workout: workout),

                  // Summary stats & breakdown details
                  WorkoutDetailData(workout),

                  // Time Series Chart (if available)
                  if (hasPoints) ...[
                    WorkoutDetailChart(workoutDetails: details),
                    WorkoutZoneDistributionWidget(
                      workoutDetails: details,
                      maxHeartRate: workout.maxHeartRate,
                      maxPower: workout.maxPower,
                    ),
                    WorkoutClimbsWidget(
                      workout: workout,
                      workoutDetails: details,
                    ),
                    WorkoutRecordsWidget(
                      workout: workout,
                      workoutDetails: details,
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNonLocationLayout(BuildContext context, Workout workout) {
    final details = workout.data?.details;
    final hasPoints = details != null && details.points.isNotEmpty;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header section
            _WorkoutHeader(workout: workout),
            const SizedBox(height: 12),

            // Summary stats & breakdown details
            WorkoutDetailData(workout),

            // Time series charts & analytical components if available
            if (hasPoints) ...[
              WorkoutDetailChart(workoutDetails: details),
              WorkoutZoneDistributionWidget(
                workoutDetails: details,
                maxHeartRate: workout.maxHeartRate,
                maxPower: workout.maxPower,
              ),
              WorkoutClimbsWidget(
                workout: workout,
                workoutDetails: details,
              ),
              WorkoutRecordsWidget(
                workout: workout,
                workoutDetails: details,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _toggleLock(BuildContext context) async {
    final result = await widget.viewModel.toggleLock();
    if (result.isSuccess() && context.mounted) {
      final isLocked = result.getOrThrow().locked;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isLocked ? 'Workout locked' : 'Workout unlocked'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _handleAction(
      BuildContext context, String action, Workout workout) async {
    switch (action) {
      case 'edit':
        if (workout.id != null) {
          context.push(Routes.workoutEdit(workout.id!));
        }
        break;
      case 'toggleLock':
        await _toggleLock(context);
        break;
      case 'refresh':
        final res = await widget.viewModel.refreshWorkout();
        if (res.isSuccess() && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Workout refreshed')),
          );
        } else if (res.isError() && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to refresh: ${res.exceptionOrNull()}')),
          );
        }
        break;
      case 'delete':
        await _confirmAndDelete(context, workout);
        break;
    }
  }

  Future<void> _confirmAndDelete(BuildContext context, Workout workout) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Workout'),
        content: Text(
          'Are you sure you want to delete "${workout.name}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final res = await widget.viewModel.deleteWorkout();
      if (res.isSuccess() && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Workout deleted')),
        );
        context.go(Routes.workouts);
      } else if (res.isError() && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete: ${res.exceptionOrNull()}'),
          ),
        );
      }
    }
  }
}

class _WorkoutHeader extends StatelessWidget {
  const _WorkoutHeader({required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat.yMMMMd().format(workout.date.toLocal());
    final timeStr = DateFormat.jm().format(workout.date.toLocal());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Activity Type Icon Badge
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              workout.type.icon,
              size: 28,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$dateStr - $timeStr',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
