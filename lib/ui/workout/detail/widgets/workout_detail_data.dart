import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracker_app/domain/models/workout/workout.dart';
import 'package:workout_tracker_app/l10n/app_localizations.dart';

class WorkoutDetailData extends StatelessWidget {
  const WorkoutDetailData(this.workout, {super.key});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final highlightCards = <Widget>[];

    if (workout.totalDuration > 0) {
      highlightCards.add(_StatTile(
        icon: Icons.timer,
        label: l10n.total_duration,
        value: _formatDuration(workout.totalDuration),
        color: Colors.blue,
      ));
    }

    if (workout.totalDistance > 0) {
      highlightCards.add(_StatTile(
        icon: Icons.straighten,
        label: l10n.total_distance,
        value:
            '${NumberFormat("#.##").format(workout.totalDistance / 1000)} km',
        color: Colors.indigo,
      ));
    }

    if (workout.averageSpeed > 0) {
      highlightCards.add(_StatTile(
        icon: Icons.speed,
        label: l10n.average_speed,
        value:
            '${NumberFormat("#.##").format(workout.averageSpeed * 3.6)} km/h',
        color: Colors.teal,
      ));
    }

    if ((workout.averageHeartRate ?? 0) > 0) {
      highlightCards.add(_StatTile(
        icon: Icons.favorite,
        label: 'Avg Heart Rate',
        value: '${workout.averageHeartRate!.round()} bpm',
        color: Colors.red,
      ));
    }

    if ((workout.averageCadence ?? 0) > 0) {
      highlightCards.add(_StatTile(
        icon: Icons.rotate_right,
        label: 'Avg Cadence',
        value: '${workout.averageCadence!.round()} rpm',
        color: Colors.orange,
      ));
    }

    if (workout.totalUp > 0) {
      highlightCards.add(_StatTile(
        icon: Icons.arrow_upward,
        label: l10n.total_up,
        value: '${NumberFormat("#.##").format(workout.totalUp)} m',
        color: Colors.green,
      ));
    }

    if (workout.totalWeight > 0) {
      highlightCards.add(_StatTile(
        icon: Icons.fitness_center,
        label: l10n.total_weight,
        value: '${NumberFormat("#.##").format(workout.totalWeight)} kg',
        color: Colors.deepPurple,
      ));
    }

    if (workout.totalRepetitions > 0) {
      highlightCards.add(_StatTile(
        icon: Icons.sync,
        label: l10n.total_repetitions,
        value: '${workout.totalRepetitions}',
        color: Colors.amber.shade800,
      ));
    }

    // Detailed List items
    final detailItems = <_DetailRowItem>[];

    final address = workout.addressString ?? '';
    if (address.isNotEmpty) {
      detailItems.add(_DetailRowItem(
        icon: Icons.location_on_outlined,
        label: l10n.location,
        value: address,
      ));
    }

    final source = workout.data?.creator ?? '';
    if (source.isNotEmpty) {
      detailItems.add(_DetailRowItem(
        icon: Icons.bookmark_border,
        label: l10n.source,
        value: source,
      ));
    }

    if (workout.pauseDuration > 0) {
      detailItems.add(_DetailRowItem(
        icon: Icons.pause_circle_outline,
        label: l10n.time_paused,
        value: _formatDuration(workout.pauseDuration),
      ));
    }

    if (workout.averageSpeedNoPause > 0) {
      detailItems.add(_DetailRowItem(
        icon: Icons.speed_outlined,
        label: l10n.average_speed_no_pause,
        value:
            '${NumberFormat("#.##").format(workout.averageSpeedNoPause * 3.6)} km/h',
      ));
    }

    if (workout.maxSpeed > 0) {
      detailItems.add(_DetailRowItem(
        icon: Icons.speed,
        label: l10n.max_speed,
        value: '${NumberFormat("#.##").format(workout.maxSpeed * 3.6)} km/h',
      ));
    }

    if ((workout.maxHeartRate ?? 0) > 0) {
      detailItems.add(_DetailRowItem(
        icon: Icons.favorite,
        label: 'Max Heart Rate',
        value: '${workout.maxHeartRate!.round()} bpm',
      ));
    }

    if ((workout.maxCadence ?? 0) > 0) {
      detailItems.add(_DetailRowItem(
        icon: Icons.rotate_right,
        label: 'Max Cadence',
        value: '${workout.maxCadence!.round()} rpm',
      ));
    }

    if ((workout.averagePower ?? 0) > 0) {
      detailItems.add(_DetailRowItem(
        icon: Icons.bolt,
        label: 'Avg Power',
        value: '${workout.averagePower!.round()} W',
      ));
    }

    if ((workout.maxPower ?? 0) > 0) {
      detailItems.add(_DetailRowItem(
        icon: Icons.bolt,
        label: 'Max Power',
        value: '${workout.maxPower!.round()} W',
      ));
    }

    if (workout.minElevation != 0) {
      detailItems.add(_DetailRowItem(
        icon: Icons.terrain,
        label: l10n.min_elevation,
        value: '${NumberFormat("#.##").format(workout.minElevation)} m',
      ));
    }

    if (workout.maxElevation != 0) {
      detailItems.add(_DetailRowItem(
        icon: Icons.terrain,
        label: l10n.max_elevation,
        value: '${NumberFormat("#.##").format(workout.maxElevation)} m',
      ));
    }

    if (workout.totalDown != 0) {
      detailItems.add(_DetailRowItem(
        icon: Icons.arrow_downward,
        label: l10n.total_down,
        value: '${NumberFormat("#.##").format(workout.totalDown)} m',
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Highlight Stat Tiles Grid
          if (highlightCards.isNotEmpty) ...[
            Text(
              'Summary',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.2,
              children: highlightCards,
            ),
            const SizedBox(height: 24),
          ],

          // Breakdown List Card
          if (detailItems.isNotEmpty) ...[
            Text(
              'Metrics & Details',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: detailItems.map((item) {
                    final isLast = item == detailItems.last;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Icon(item.icon,
                                  size: 20, color: theme.colorScheme.primary),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  item.label,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                              Text(
                                item.value,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isLast)
                          Divider(
                            height: 1,
                            thickness: 0.5,
                            color: Colors.grey.withValues(alpha: 0.2),
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Notes Section
          if (workout.notes.isNotEmpty) ...[
            Text(
              'Notes',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.note_alt_outlined,
                      size: 20,
                      color: theme.colorScheme.secondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        workout.notes,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color.shade700 ?? color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

extension on Color {
  Color? get shade700 {
    if (this is MaterialColor) {
      return (this as MaterialColor)[700];
    }
    return null;
  }
}

String _formatDuration(int seconds) {
  final duration = Duration(seconds: seconds);
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final secs = duration.inSeconds.remainder(60);
  if (hours > 0) {
    return '${hours}h ${minutes}m';
  }
  if (minutes > 0) {
    return '${minutes}m ${secs}s';
  }
  return '${secs}s';
}

class _DetailRowItem {
  const _DetailRowItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}
