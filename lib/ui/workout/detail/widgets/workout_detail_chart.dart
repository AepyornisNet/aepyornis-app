import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker_app/domain/models/map_data_details/map_data_details.dart';
import 'package:workout_tracker_app/domain/models/map_point/map_point.dart';

enum ChartMetricType { speed, elevation, heartRate, cadence, power }

class WorkoutDetailChart extends StatefulWidget {
  const WorkoutDetailChart({super.key, required this.workoutDetails});

  final MapDataDetails workoutDetails;

  @override
  State<WorkoutDetailChart> createState() => _WorkoutDetailChartState();
}

class _WorkoutDetailChartState extends State<WorkoutDetailChart> {
  ChartMetricType _selectedMetric = ChartMetricType.speed;
  bool _useDistanceXAxis = false;

  @override
  void initState() {
    super.initState();
    _selectAvailableMetric();
  }

  @override
  void didUpdateWidget(covariant WorkoutDetailChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.workoutDetails != widget.workoutDetails) {
      _selectAvailableMetric();
    }
  }

  void _selectAvailableMetric() {
    final available = _availableMetrics();
    if (available.isNotEmpty && !available.contains(_selectedMetric)) {
      _selectedMetric = available.first;
    }
  }

  List<ChartMetricType> _availableMetrics() {
    final points = widget.workoutDetails.points;
    if (points.isEmpty) return [];

    final available = <ChartMetricType>[];

    final hasSpeed =
        points.any((p) => _getMetricValue(p, ChartMetricType.speed) > 0);
    if (hasSpeed) available.add(ChartMetricType.speed);

    final hasElevation = points.any((p) => p.elevation != 0);
    if (hasElevation) available.add(ChartMetricType.elevation);

    final hasHr =
        points.any((p) => _getMetricValue(p, ChartMetricType.heartRate) > 0);
    if (hasHr) available.add(ChartMetricType.heartRate);

    final hasCadence =
        points.any((p) => _getMetricValue(p, ChartMetricType.cadence) > 0);
    if (hasCadence) available.add(ChartMetricType.cadence);

    final hasPower =
        points.any((p) => _getMetricValue(p, ChartMetricType.power) > 0);
    if (hasPower) available.add(ChartMetricType.power);

    return available;
  }

  double _getMetricValue(MapPoint point, ChartMetricType type) {
    switch (type) {
      case ChartMetricType.speed:
        final speedVal = point.extraMetrics['speed'];
        if (speedVal is num && speedVal > 0) {
          return speedVal.toDouble() * 3.6;
        }
        return point.speedInKmH;
      case ChartMetricType.elevation:
        return point.elevation;
      case ChartMetricType.heartRate:
        final hr = point.extraMetrics['heart-rate'] ??
            point.extraMetrics['heart_rate'] ??
            point.extraMetrics['hr'];
        return (hr is num) ? hr.toDouble() : 0.0;
      case ChartMetricType.cadence:
        final cad = point.extraMetrics['cadence'];
        return (cad is num) ? cad.toDouble() : 0.0;
      case ChartMetricType.power:
        final pow = point.extraMetrics['power'];
        return (pow is num) ? pow.toDouble() : 0.0;
    }
  }

  String _metricName(ChartMetricType type) {
    switch (type) {
      case ChartMetricType.speed:
        return 'Speed';
      case ChartMetricType.elevation:
        return 'Elevation';
      case ChartMetricType.heartRate:
        return 'Heart Rate';
      case ChartMetricType.cadence:
        return 'Cadence';
      case ChartMetricType.power:
        return 'Power';
    }
  }

  String _metricUnit(ChartMetricType type) {
    switch (type) {
      case ChartMetricType.speed:
        return 'km/h';
      case ChartMetricType.elevation:
        return 'm';
      case ChartMetricType.heartRate:
        return 'bpm';
      case ChartMetricType.cadence:
        return 'rpm';
      case ChartMetricType.power:
        return 'W';
    }
  }

  Color _metricColor(ChartMetricType type) {
    switch (type) {
      case ChartMetricType.speed:
        return Colors.blue;
      case ChartMetricType.elevation:
        return Colors.green;
      case ChartMetricType.heartRate:
        return Colors.red;
      case ChartMetricType.cadence:
        return Colors.orange;
      case ChartMetricType.power:
        return Colors.purple;
    }
  }

  IconData _metricIcon(ChartMetricType type) {
    switch (type) {
      case ChartMetricType.speed:
        return Icons.speed;
      case ChartMetricType.elevation:
        return Icons.terrain;
      case ChartMetricType.heartRate:
        return Icons.favorite;
      case ChartMetricType.cadence:
        return Icons.rotate_right;
      case ChartMetricType.power:
        return Icons.bolt;
    }
  }

  @override
  Widget build(BuildContext context) {
    final available = _availableMetrics();
    if (available.isEmpty) {
      return const SizedBox.shrink();
    }

    final points = widget.workoutDetails.points;
    final hasDistance = points.any((p) => p.totalDistance > 0);
    final useDist = hasDistance && _useDistanceXAxis;

    // Build spots for chart
    final spots = <FlSpot>[];
    double minVal = double.infinity;
    double maxVal = -double.infinity;
    double sumVal = 0;
    int countVal = 0;

    for (var p in points) {
      final val = _getMetricValue(p, _selectedMetric);
      if (_selectedMetric != ChartMetricType.elevation && val <= 0) {
        continue;
      }

      final x = useDist
          ? (p.totalDistance / 1000.0)
          : (p.totalDuration / 1000000000.0 / 60.0);

      spots.add(FlSpot(x, val));

      minVal = math.min(minVal, val);
      maxVal = math.max(maxVal, val);
      sumVal += val;
      countVal++;
    }

    final avgVal = countVal > 0 ? (sumVal / countVal) : 0.0;
    if (minVal == double.infinity) minVal = 0.0;
    if (maxVal == -double.infinity) maxVal = 0.0;

    // Downsample spots if too large (e.g. > 250 points) for slick performance
    final displaySpots = _downsampleSpots(spots, targetCount: 250);

    final color = _metricColor(_selectedMetric);
    final unit = _metricUnit(_selectedMetric);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Metric selector chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: available.map((type) {
                  final isSelected = type == _selectedMetric;
                  final chipColor = _metricColor(type);
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      avatar: Icon(
                        _metricIcon(type),
                        size: 16,
                        color: isSelected ? Colors.white : chipColor,
                      ),
                      label: Text(_metricName(type)),
                      selected: isSelected,
                      selectedColor: chipColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : null,
                        fontWeight: isSelected ? FontWeight.bold : null,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedMetric = type;
                          });
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 14),

            // Summary stats header
            if (countVal > 0) ...[
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatMiniColumn(
                      label: 'MIN',
                      value: '${minVal.toStringAsFixed(1)} $unit',
                    ),
                    _StatMiniColumn(
                      label: 'AVG',
                      value: '${avgVal.toStringAsFixed(1)} $unit',
                      highlight: true,
                      color: color,
                    ),
                    _StatMiniColumn(
                      label: 'MAX',
                      value: '${maxVal.toStringAsFixed(1)} $unit',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Chart Widget
            SizedBox(
              height: 220,
              child: displaySpots.isEmpty
                  ? Center(
                      child: Text(
                        'No data for ${_metricName(_selectedMetric)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  : LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval:
                              (maxVal - minVal) > 0 ? (maxVal - minVal) / 4 : 1,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: Colors.grey.withValues(alpha: 0.15),
                            strokeWidth: 1,
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 42,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toStringAsFixed(0),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade600,
                                  ),
                                );
                              },
                            ),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 22,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade600,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((spot) {
                                final xLabel = useDist
                                    ? '${spot.x.toStringAsFixed(2)} km'
                                    : '${spot.x.toStringAsFixed(1)} min';
                                return LineTooltipItem(
                                  '${spot.y.toStringAsFixed(1)} $unit\n$xLabel',
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: displaySpots,
                            isCurved: true,
                            barWidth: 2.5,
                            color: color,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: color.withValues(alpha: 0.15),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),

            // Toggle Distance / Time below the chart (only shown if distance is available)
            if (hasDistance) ...[
              const SizedBox(height: 12),
              Center(
                child: SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(
                      value: false,
                      label: Text('Time (min)'),
                      icon: Icon(Icons.access_time, size: 16),
                    ),
                    ButtonSegment(
                      value: true,
                      label: Text('Dist (km)'),
                      icon: Icon(Icons.straighten, size: 16),
                    ),
                  ],
                  selected: {_useDistanceXAxis},
                  onSelectionChanged: (set) {
                    setState(() {
                      _useDistanceXAxis = set.first;
                    });
                  },
                  style: const ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<FlSpot> _downsampleSpots(List<FlSpot> input, {int targetCount = 200}) {
    if (input.length <= targetCount) return input;
    final result = <FlSpot>[];
    final step = input.length / targetCount;
    for (var i = 0; i < targetCount; i++) {
      final index = (i * step).floor();
      if (index < input.length) {
        result.add(input[index]);
      }
    }
    if (input.isNotEmpty && result.last != input.last) {
      result.add(input.last);
    }
    return result;
  }
}

class _StatMiniColumn extends StatelessWidget {
  const _StatMiniColumn({
    required this.label,
    required this.value,
    this.highlight = false,
    this.color,
  });

  final String label;
  final String value;
  final bool highlight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: highlight ? 14 : 12,
            fontWeight: highlight ? FontWeight.bold : FontWeight.w600,
            color: highlight ? color : null,
          ),
        ),
      ],
    );
  }
}
