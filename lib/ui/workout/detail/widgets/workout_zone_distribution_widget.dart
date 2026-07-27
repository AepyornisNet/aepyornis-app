import 'package:flutter/material.dart';
import 'package:aepyornis_app/domain/models/map_data_details/map_data_details.dart';

enum ZoneType { heartRate, power }

class ZoneInfo {
  ZoneInfo({
    required this.zoneNumber,
    required this.name,
    required this.color,
    required this.durationSeconds,
    required this.percentage,
    this.rangeText,
  });

  final int zoneNumber;
  final String name;
  final Color color;
  final double durationSeconds;
  final double percentage;
  final String? rangeText;
}

class WorkoutZoneDistributionWidget extends StatefulWidget {
  const WorkoutZoneDistributionWidget({
    super.key,
    required this.workoutDetails,
    this.maxHeartRate,
    this.maxPower,
  });

  final MapDataDetails workoutDetails;
  final double? maxHeartRate;
  final double? maxPower;

  @override
  State<WorkoutZoneDistributionWidget> createState() =>
      _WorkoutZoneDistributionWidgetState();
}

class _WorkoutZoneDistributionWidgetState
    extends State<WorkoutZoneDistributionWidget> {
  ZoneType _selectedType = ZoneType.heartRate;

  @override
  void initState() {
    super.initState();
    final hasHr = _hasHeartRateData();
    final hasPow = _hasPowerData();
    if (!hasHr && hasPow) {
      _selectedType = ZoneType.power;
    }
  }

  bool _hasHeartRateData() {
    final points = widget.workoutDetails.points;
    return points.any((p) {
      final hr = p.extraMetrics['heart-rate'] ??
          p.extraMetrics['heart_rate'] ??
          p.extraMetrics['hr'] ??
          p.extraMetrics['hr-zone'];
      return hr != null;
    });
  }

  bool _hasPowerData() {
    final points = widget.workoutDetails.points;
    return points.any((p) {
      final pow = p.extraMetrics['power'] ?? p.extraMetrics['zone'];
      return pow != null;
    });
  }

  Map<int, String> _getApiZoneRanges(String typeKey) {
    final raw = widget.workoutDetails.zoneRanges;
    if (raw == null) return {};

    final list = raw[typeKey];
    if (list is! List) return {};

    final result = <int, String>{};
    final unit = typeKey == 'heart-rate' ? 'bpm' : 'W';

    for (final item in list) {
      if (item is Map) {
        final zoneNum = (item['zone'] as num?)?.toInt();
        final minVal = item['min'] as num?;
        final maxVal = item['max'] as num?;

        if (zoneNum != null) {
          if (minVal != null && maxVal != null) {
            if (minVal == maxVal) {
              result[zoneNum] = '${minVal.round()} $unit';
            } else {
              result[zoneNum] = '${minVal.round()} - ${maxVal.round()} $unit';
            }
          } else if (minVal != null) {
            result[zoneNum] = '> ${minVal.round()} $unit';
          } else if (maxVal != null) {
            result[zoneNum] = '< ${maxVal.round()} $unit';
          }
        }
      }
    }
    return result;
  }

  List<ZoneInfo> _calculateHrZones() {
    final points = widget.workoutDetails.points;
    if (points.isEmpty) return [];

    final apiRanges = _getApiZoneRanges('heart-rate');

    final zoneColors = [
      Colors.blueGrey.shade400, // Z1 Recovery
      Colors.blue.shade600, // Z2 Aerobic
      Colors.green.shade600, // Z3 Tempo
      Colors.orange.shade700, // Z4 Threshold
      Colors.red.shade600, // Z5 Anaerobic
    ];

    final zoneNames = [
      'Z1 Recovery',
      'Z2 Aerobic',
      'Z3 Tempo',
      'Z4 Threshold',
      'Z5 Anaerobic',
    ];

    // Find max HR observed or parameter
    double maxHr = widget.maxHeartRate ?? 190.0;
    for (final p in points) {
      final hr = p.extraMetrics['heart-rate'] ??
          p.extraMetrics['heart_rate'] ??
          p.extraMetrics['hr'];
      if (hr is num && hr > maxHr) {
        maxHr = hr.toDouble();
      }
    }

    final fallbackZoneRanges = [
      '< ${(maxHr * 0.6).round()} bpm',
      '${(maxHr * 0.6).round()} - ${(maxHr * 0.7).round()} bpm',
      '${(maxHr * 0.7).round()} - ${(maxHr * 0.8).round()} bpm',
      '${(maxHr * 0.8).round()} - ${(maxHr * 0.9).round()} bpm',
      '> ${(maxHr * 0.9).round()} bpm',
    ];

    final durations = List<double>.filled(5, 0.0);
    double totalTime = 0.0;

    for (var i = 0; i < points.length; i++) {
      final p = points[i];
      final hrZoneVal = p.extraMetrics['hr-zone'];
      int zoneIdx = -1;

      if (hrZoneVal is num && hrZoneVal >= 1 && hrZoneVal <= 5) {
        zoneIdx = hrZoneVal.toInt() - 1;
      } else {
        final hr = p.extraMetrics['heart-rate'] ??
            p.extraMetrics['heart_rate'] ??
            p.extraMetrics['hr'];
        if (hr is num && hr > 0) {
          final hrVal = hr.toDouble();
          final ratio = hrVal / maxHr;
          if (ratio < 0.6) {
            zoneIdx = 0;
          } else if (ratio < 0.7) {
            zoneIdx = 1;
          } else if (ratio < 0.8) {
            zoneIdx = 2;
          } else if (ratio < 0.9) {
            zoneIdx = 3;
          } else {
            zoneIdx = 4;
          }
        }
      }

      if (zoneIdx >= 0 && zoneIdx < 5) {
        final dt = p.duration > 0 ? (p.duration / 1e9) : 1.0;
        durations[zoneIdx] += dt;
        totalTime += dt;
      }
    }

    if (totalTime <= 0) return [];

    final result = <ZoneInfo>[];
    for (var i = 0; i < 5; i++) {
      final pct = (durations[i] / totalTime) * 100.0;
      final zoneNum = i + 1;
      final rangeText = apiRanges[zoneNum] ?? fallbackZoneRanges[i];
      result.add(
        ZoneInfo(
          zoneNumber: zoneNum,
          name: zoneNames[i],
          color: zoneColors[i],
          durationSeconds: durations[i],
          percentage: pct,
          rangeText: rangeText,
        ),
      );
    }
    return result;
  }

  List<ZoneInfo> _calculatePowerZones() {
    final points = widget.workoutDetails.points;
    if (points.isEmpty) return [];

    final apiRanges = _getApiZoneRanges('power');

    final zoneColors = [
      Colors.grey.shade600, // Z1 Active Recovery
      Colors.blue.shade600, // Z2 Endurance
      Colors.green.shade600, // Z3 Tempo
      Colors.yellow.shade800, // Z4 Threshold
      Colors.orange.shade700, // Z5 VO2 Max
      Colors.red.shade600, // Z6 Anaerobic
      Colors.purple.shade600, // Z7 Neuromuscular
    ];

    final zoneNames = [
      'Z1 Active Recovery',
      'Z2 Endurance',
      'Z3 Tempo',
      'Z4 Threshold',
      'Z5 VO2 Max',
      'Z6 Anaerobic',
      'Z7 Neuromuscular',
    ];

    double ftp = (widget.maxPower ?? 250.0) * 0.75;
    final durations = List<double>.filled(7, 0.0);
    double totalTime = 0.0;

    for (var i = 0; i < points.length; i++) {
      final p = points[i];
      final zoneVal = p.extraMetrics['zone'];
      int zoneIdx = -1;

      if (zoneVal is num && zoneVal >= 1 && zoneVal <= 7) {
        zoneIdx = zoneVal.toInt() - 1;
      } else {
        final pow = p.extraMetrics['power'];
        if (pow is num && pow > 0) {
          final pVal = pow.toDouble();
          final ratio = pVal / ftp;
          if (ratio < 0.55) {
            zoneIdx = 0;
          } else if (ratio < 0.75) {
            zoneIdx = 1;
          } else if (ratio < 0.90) {
            zoneIdx = 2;
          } else if (ratio < 1.05) {
            zoneIdx = 3;
          } else if (ratio < 1.20) {
            zoneIdx = 4;
          } else if (ratio < 1.50) {
            zoneIdx = 5;
          } else {
            zoneIdx = 6;
          }
        }
      }

      if (zoneIdx >= 0 && zoneIdx < 7) {
        final dt = p.duration > 0 ? (p.duration / 1e9) : 1.0;
        durations[zoneIdx] += dt;
        totalTime += dt;
      }
    }

    if (totalTime <= 0) return [];

    final result = <ZoneInfo>[];
    for (var i = 0; i < 7; i++) {
      final pct = (durations[i] / totalTime) * 100.0;
      final zoneNum = i + 1;
      final rangeText = apiRanges[zoneNum];
      result.add(
        ZoneInfo(
          zoneNumber: zoneNum,
          name: zoneNames[i],
          color: zoneColors[i],
          durationSeconds: durations[i],
          percentage: pct,
          rangeText: rangeText,
        ),
      );
    }
    return result;
  }

  String _formatDuration(double seconds) {
    final secs = seconds.round();
    final mins = secs ~/ 60;
    final hrs = mins ~/ 60;
    final remMins = mins % 60;
    final remSecs = secs % 60;

    if (hrs > 0) {
      return '${hrs}h ${remMins}m';
    } else if (mins > 0) {
      return '${mins}m ${remSecs}s';
    } else {
      return '${secs}s';
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasHr = _hasHeartRateData();
    final hasPow = _hasPowerData();
    if (!hasHr && !hasPow) {
      return const SizedBox.shrink();
    }

    final zones = _selectedType == ZoneType.heartRate
        ? _calculateHrZones()
        : _calculatePowerZones();

    if (zones.isEmpty) {
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
            // Header with title and mode selector if both exist
            Row(
              children: [
                Icon(
                  _selectedType == ZoneType.heartRate
                      ? Icons.favorite
                      : Icons.bolt,
                  color: _selectedType == ZoneType.heartRate
                      ? Colors.red
                      : Colors.purple,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _selectedType == ZoneType.heartRate
                      ? 'Heart Rate Zones'
                      : 'Power Zones',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (hasHr && hasPow) ...[
                  SegmentedButton<ZoneType>(
                    segments: const [
                      ButtonSegment(
                        value: ZoneType.heartRate,
                        label: Text('HR'),
                        icon: Icon(Icons.favorite, size: 14),
                      ),
                      ButtonSegment(
                        value: ZoneType.power,
                        label: Text('Power'),
                        icon: Icon(Icons.bolt, size: 14),
                      ),
                    ],
                    selected: {_selectedType},
                    onSelectionChanged: (set) {
                      setState(() {
                        _selectedType = set.first;
                      });
                    },
                    style: const ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),

            // Horizontal Segmented Distribution Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 14,
                child: Row(
                  children: zones.map((z) {
                    final flex = z.percentage.round();
                    if (flex <= 0) return const SizedBox.shrink();
                    return Expanded(
                      flex: flex,
                      child: Container(color: z.color),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Zone Rows
            ...zones.map((z) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: z.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        z.name,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (z.rangeText != null) ...[
                      Text(
                        z.rangeText!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    SizedBox(
                      width: 60,
                      child: Text(
                        _formatDuration(z.durationSeconds),
                        textAlign: TextAlign.right,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 55,
                      child: Text(
                        '${z.percentage.toStringAsFixed(1)}%',
                        textAlign: TextAlign.right,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
