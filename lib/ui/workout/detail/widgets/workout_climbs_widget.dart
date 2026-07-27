import 'package:flutter/material.dart';
import 'package:aepyornis_app/domain/models/map_data_details/map_data_details.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';

class WorkoutClimbItem {
  WorkoutClimbItem({
    required this.index,
    required this.isClimb,
    required this.startDistanceMeters,
    required this.lengthMeters,
    required this.elevationMeters,
    required this.avgSlopePercent,
    required this.category,
  });

  final int index;
  final bool isClimb;
  final double startDistanceMeters;
  final double lengthMeters;
  final double elevationMeters;
  final double avgSlopePercent;
  final String category;
}

class WorkoutClimbsWidget extends StatelessWidget {
  const WorkoutClimbsWidget({
    super.key,
    required this.workout,
    required this.workoutDetails,
  });

  final Workout workout;
  final MapDataDetails workoutDetails;

  List<WorkoutClimbItem> _detectClimbsAndDescents() {
    if (workout.climbs.isNotEmpty) {
      final result = <WorkoutClimbItem>[];
      for (final item in workout.climbs) {
        final idx = (item['index'] as num?)?.toInt() ?? (result.length + 1);
        final typeStr = (item['type'] as String?) ?? 'climb';
        final isClimb = typeStr != 'descent';
        final startDist = (item['start_distance'] as num?)?.toDouble() ?? 0.0;
        final length = (item['length'] as num?)?.toDouble() ?? 0.0;
        final elevation = (item['elevation'] as num?)?.toDouble() ?? 0.0;
        var avgSlope = (item['avg_slope'] as num?)?.toDouble() ?? 0.0;
        if (avgSlope.abs() < 1.0 && avgSlope != 0.0) {
          avgSlope = avgSlope * 100.0;
        }
        final cat = (item['category'] as String?) ?? 'Uncategorized';

        result.add(
          WorkoutClimbItem(
            index: idx,
            isClimb: isClimb,
            startDistanceMeters: startDist,
            lengthMeters: length,
            elevationMeters: elevation,
            avgSlopePercent: avgSlope,
            category: cat,
          ),
        );
      }
      return result;
    }
    final points = workoutDetails.points;
    if (points.length < 5) return [];

    final result = <WorkoutClimbItem>[];
    int climbIndex = 1;

    double segStartDist = 0;
    double segStartElev = 0;
    bool inSegment = false;
    bool isClimbing = false;

    for (var i = 1; i < points.length; i++) {
      final pPrev = points[i - 1];
      final pCurr = points[i];
      final deltaElev = pCurr.elevation - pPrev.elevation;

      if (!inSegment) {
        if (deltaElev.abs() > 1.0) {
          inSegment = true;
          isClimbing = deltaElev > 0;
          segStartDist = pPrev.totalDistance;
          segStartElev = pPrev.elevation;
        }
      } else {
        final isSameDirection =
            isClimbing ? deltaElev >= -0.5 : deltaElev <= 0.5;
        if (!isSameDirection || i == points.length - 1) {
          final segEndDist = pCurr.totalDistance;
          final segEndElev = pCurr.elevation;
          final length = segEndDist - segStartDist;
          final eleDiff = (segEndElev - segStartElev).abs();

          if (length >= 250 && eleDiff >= 15) {
            final slope = (eleDiff / length) * 100.0;
            String cat = 'Uncategorized';
            if (isClimbing) {
              final score = length * (slope / 100);
              if (score > 8000) {
                cat = 'HC';
              } else if (score > 3200) {
                cat = 'Cat 1';
              } else if (score > 1600) {
                cat = 'Cat 2';
              } else if (score > 800) {
                cat = 'Cat 3';
              } else if (score > 300) {
                cat = 'Cat 4';
              }
            }

            result.add(
              WorkoutClimbItem(
                index: climbIndex++,
                isClimb: isClimbing,
                startDistanceMeters: segStartDist,
                lengthMeters: length,
                elevationMeters: eleDiff,
                avgSlopePercent: slope,
                category: cat,
              ),
            );
          }

          inSegment = false;
        }
      }
    }

    return result;
  }

  String _formatDist(double meters) {
    if (meters >= 1000) {
      return '${(meters / 1000.0).toStringAsFixed(1)} km';
    }
    return '${meters.round()} m';
  }

  @override
  Widget build(BuildContext context) {
    final climbs = _detectClimbsAndDescents();
    if (climbs.isEmpty) {
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
                  Icons.terrain,
                  color: Colors.green.shade700,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Climbs & Descents',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${climbs.length}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Table list of climbs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 16,
                headingRowHeight: 36,
                dataRowMinHeight: 40,
                dataRowMaxHeight: 44,
                columns: const [
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Start')),
                  DataColumn(label: Text('Length')),
                  DataColumn(label: Text('Elevation')),
                  DataColumn(label: Text('Avg Slope')),
                  DataColumn(label: Text('Category')),
                ],
                rows: climbs.map((c) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              c.isClimb
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                              size: 16,
                              color: c.isClimb ? Colors.green : Colors.orange,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              c.isClimb
                                  ? 'Climb ${c.index}'
                                  : 'Descent ${c.index}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: c.isClimb
                                    ? Colors.green.shade800
                                    : Colors.orange.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataCell(Text(_formatDist(c.startDistanceMeters))),
                      DataCell(Text(_formatDist(c.lengthMeters))),
                      DataCell(
                        Text(
                          '${c.isClimb ? '+' : '-'}${c.elevationMeters.round()} m',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      DataCell(
                          Text('${c.avgSlopePercent.toStringAsFixed(1)}%')),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: c.category == 'HC' || c.category == 'Cat 1'
                                ? Colors.red.shade100
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            c.category,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: c.category == 'HC' || c.category == 'Cat 1'
                                  ? Colors.red.shade900
                                  : Colors.black87,
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
