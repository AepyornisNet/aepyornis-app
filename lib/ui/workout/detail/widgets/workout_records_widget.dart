import 'package:flutter/material.dart';
import 'package:aepyornis_app/domain/models/map_data_details/map_data_details.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';

class BestRecordItem {
  BestRecordItem({
    required this.label,
    required this.targetDistanceMeters,
    required this.durationSeconds,
    required this.averageSpeedKmh,
    required this.rank,
  });

  final String label;
  final double targetDistanceMeters;
  final double durationSeconds;
  final double averageSpeedKmh;
  final int rank;
}

class WorkoutRecordsWidget extends StatelessWidget {
  const WorkoutRecordsWidget({
    super.key,
    required this.workout,
    required this.workoutDetails,
  });

  final Workout workout;
  final MapDataDetails workoutDetails;

  List<BestRecordItem> _calculateBestRecords() {
    if (workout.intervalBests.isNotEmpty) {
      final result = <BestRecordItem>[];
      for (final item in workout.intervalBests) {
        final label = (item['label'] as String?) ?? 'Record';
        final targetDist =
            (item['target_distance'] ?? item['distance'] as num?)?.toDouble() ??
                0.0;
        final durationSecs =
            (item['duration_seconds'] as num?)?.toDouble() ?? 0.0;
        var avgSpeed = (item['average_speed'] as num?)?.toDouble() ?? 0.0;
        if (avgSpeed > 0 && avgSpeed < 30) {
          avgSpeed = avgSpeed * 3.6;
        }
        final rank = (item['rank'] as num?)?.toInt() ?? 1;

        result.add(
          BestRecordItem(
            label: label,
            targetDistanceMeters: targetDist,
            durationSeconds: durationSecs,
            averageSpeedKmh: avgSpeed,
            rank: rank,
          ),
        );
      }
      return result;
    }
    final points = workoutDetails.points;
    if (points.length < 5) return [];

    final totalDist = points.last.totalDistance;
    if (totalDist < 500) return [];

    final targets = <double, String>{
      500: '500m',
      1000: '1 km',
      1609.34: '1 mi',
      5000: '5 km',
      10000: '10 km',
      21097.5: 'Half Marathon',
      42195: 'Marathon',
    };

    final result = <BestRecordItem>[];

    for (final entry in targets.entries) {
      final targetMeters = entry.key;
      final label = entry.value;
      if (totalDist < targetMeters) continue;

      double minDuration = double.infinity;
      int startIdx = 0;
      int endIdx = 0;

      for (var i = 0; i < points.length; i++) {
        final pStart = points[i];
        for (var j = i + 1; j < points.length; j++) {
          final pEnd = points[j];
          final dist = pEnd.totalDistance - pStart.totalDistance;
          if (dist >= targetMeters) {
            final durationSecs =
                (pEnd.totalDuration - pStart.totalDuration) / 1e9;
            if (durationSecs > 0 && durationSecs < minDuration) {
              minDuration = durationSecs;
              startIdx = i;
              endIdx = j;
            }
            break;
          }
        }
      }

      if (minDuration != double.infinity && minDuration > 0) {
        final actualDist =
            points[endIdx].totalDistance - points[startIdx].totalDistance;
        final speedKmh = (actualDist / 1000.0) / (minDuration / 3600.0);

        result.add(
          BestRecordItem(
            label: label,
            targetDistanceMeters: targetMeters,
            durationSeconds: minDuration,
            averageSpeedKmh: speedKmh,
            rank: 1,
          ),
        );
      }
    }

    return result;
  }

  String _formatTime(double seconds) {
    final secs = seconds.round();
    final mins = secs ~/ 60;
    final hrs = mins ~/ 60;
    final remMins = mins % 60;
    final remSecs = secs % 60;

    if (hrs > 0) {
      return '$hrs:${remMins.toString().padLeft(2, '0')}:${remSecs.toString().padLeft(2, '0')}';
    }
    return '$mins:${remSecs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final records = _calculateBestRecords();
    if (records.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  Icons.emoji_events,
                  color: Colors.amber.shade700,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Best Interval Records',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${records.length} PRs',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Table of records
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24,
                headingRowHeight: 36,
                dataRowMinHeight: 40,
                dataRowMaxHeight: 44,
                columns: const [
                  DataColumn(label: Text('Distance')),
                  DataColumn(label: Text('Time')),
                  DataColumn(label: Text('Avg Speed')),
                  DataColumn(label: Text('Rank')),
                ],
                rows: records.map((r) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          r.label,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataCell(
                        Text(
                          _formatTime(r.durationSeconds),
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '${r.averageSpeedKmh.toStringAsFixed(1)} km/h',
                          style: const TextStyle(fontFamily: 'monospace'),
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '#${r.rank}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
