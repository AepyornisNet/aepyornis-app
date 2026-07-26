import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracker_app/domain/models/workout/workout.dart';
import 'package:workout_tracker_app/ui/workout/detail/view_models/workout_detail_viewmodel.dart';
import 'package:workout_tracker_app/ui/workout/detail/widgets/workout_detail_chart.dart';
import 'package:workout_tracker_app/ui/workout/detail/widgets/workout_detail_data.dart';
import 'package:workout_tracker_app/ui/workout/detail/widgets/workout_detail_map.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Detail'),
        elevation: 0,
        actions: [
          ListenableBuilder(
            listenable: widget.viewModel.loadWorkout,
            builder: (context, child) {
              if (widget.viewModel.workout?.publicUUID == null) {
                return const SizedBox.shrink();
              }

              return IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // TODO: Implement share functionality
                },
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
            // Prominent Header Card for Non-Location Workout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _WorkoutHeader(workout: workout),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Summary stats & breakdown details
            WorkoutDetailData(workout),

            // Time series charts if available
            if (hasPoints) ...[
              WorkoutDetailChart(workoutDetails: details),
            ],
          ],
        ),
      ),
    );
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
