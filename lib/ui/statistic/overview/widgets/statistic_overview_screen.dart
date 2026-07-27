import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:aepyornis_app/domain/models/statistics/statistics_response.dart';
import 'package:aepyornis_app/l10n/app_localizations.dart';
import 'package:aepyornis_app/routing/routes.dart';
import 'package:aepyornis_app/ui/core/utils/formatters.dart';
import 'package:aepyornis_app/ui/core/utils/workout_type_l10n.dart';
import 'package:aepyornis_app/ui/statistic/overview/view_models/statistic_overview_viewmodel.dart';

class StatisticOverviewScreen extends StatefulWidget {
  const StatisticOverviewScreen({super.key, required this.viewModel});

  final StatisticOverviewViewModel viewModel;

  @override
  State<StatisticOverviewScreen> createState() =>
      _StatisticOverviewScreenState();
}

class _StatisticOverviewScreenState extends State<StatisticOverviewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.viewModel.loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, _) {
            final vm = widget.viewModel;

            return Column(
              children: [
                // Top Nav bar (Overview / Records)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: SegmentedButton<int>(
                    segments: [
                      ButtonSegment<int>(
                        value: 0,
                        label: Text(l10n.overview),
                        icon: const Icon(Icons.bar_chart_rounded, size: 18),
                      ),
                      ButtonSegment<int>(
                        value: 1,
                        label: Text(l10n.records),
                        icon: const Icon(Icons.emoji_events_outlined, size: 18),
                      ),
                    ],
                    selected: {vm.selectedTabIndex},
                    onSelectionChanged: (Set<int> newSelection) {
                      if (newSelection.isNotEmpty) {
                        vm.setSelectedTab(newSelection.first);
                      }
                    },
                  ),
                ),

                // Filters bar
                _buildFilterBar(context, vm, l10n),

                // Body content
                Expanded(
                  child: vm.isLoading && vm.statistics == null
                      ? const Center(child: CircularProgressIndicator())
                      : vm.errorMessage != null && vm.statistics == null
                          ? _buildErrorView(context, vm, l10n)
                          : vm.selectedTabIndex == 0
                              ? _buildOverviewTab(
                                  context, vm, l10n, colorScheme)
                              : _buildRecordsTab(
                                  context, vm, l10n, colorScheme),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterBar(
    BuildContext context,
    StatisticOverviewViewModel vm,
    AppLocalizations l10n,
  ) {
    final sinceOptions = [
      {'key': '7 days', 'label': l10n.days7},
      {'key': '1 month', 'label': l10n.month1},
      {'key': '3 months', 'label': l10n.months3},
      {'key': '6 months', 'label': l10n.months6},
      {'key': '1 year', 'label': l10n.year1},
      {'key': '2 years', 'label': l10n.years2},
      {'key': '5 years', 'label': l10n.years5},
      {'key': '10 years', 'label': l10n.years10},
      {'key': 'forever', 'label': l10n.forever},
    ];

    final perOptions = [
      {'key': 'day', 'label': l10n.day},
      {'key': 'week', 'label': l10n.week},
      {'key': 'month', 'label': l10n.month},
      {'key': 'year', 'label': l10n.year},
    ];

    // Available Workout Types from Statistics response & records
    final typesSet = <String>{'all'};
    if (vm.statistics?.buckets != null) {
      typesSet.addAll(vm.statistics!.buckets!.keys);
    }
    for (final r in vm.records) {
      if (r.workoutType != null && r.workoutType!.isNotEmpty) {
        typesSet.add(r.workoutType!);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Column(
        children: [
          if (vm.selectedTabIndex == 0) ...[
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: vm.since,
                    decoration: InputDecoration(
                      labelText: l10n.since,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: sinceOptions.map((opt) {
                      return DropdownMenuItem<String>(
                        value: opt['key'],
                        child: Text(opt['label']!,
                            style: const TextStyle(fontSize: 13)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) vm.setFilter(since: val);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: vm.per,
                    decoration: InputDecoration(
                      labelText: l10n.per,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: perOptions.map((opt) {
                      return DropdownMenuItem<String>(
                        value: opt['key'],
                        child: Text(opt['label']!,
                            style: const TextStyle(fontSize: 13)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) vm.setFilter(per: val);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          DropdownButtonFormField<String>(
            initialValue:
                typesSet.contains(vm.workoutType) ? vm.workoutType : 'all',
            decoration: InputDecoration(
              labelText: l10n.source == 'Source' ? 'Sport' : 'Sport',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: typesSet.map((t) {
              final formattedLabel = getLocalizedWorkoutTypeName(context, t);
              return DropdownMenuItem<String>(
                value: t,
                child: Text(
                  formattedLabel,
                  style: const TextStyle(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) vm.setWorkoutType(val);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(
    BuildContext context,
    StatisticOverviewViewModel vm,
    AppLocalizations l10n,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 12),
            Text(
              vm.errorMessage ?? 'Failed to load statistics',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: vm.loadData,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.tryAgain),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab(
    BuildContext context,
    StatisticOverviewViewModel vm,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    final stats = vm.statistics;
    if (stats == null || stats.buckets == null || stats.buckets!.isEmpty) {
      return Center(
        child: Text(
          l10n.noStatisticsAvailable,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
      );
    }

    final aggregated =
        _aggregateBuckets(stats.buckets!, vm.workoutType, vm.per);

    if (aggregated.bucketKeys.isEmpty) {
      return Center(
        child: Text(
          l10n.noStatisticsAvailable,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: vm.loadData,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Stat Summary Header Cards
          _buildSummaryCards(context, aggregated, l10n, colorScheme),
          const SizedBox(height: 20),

          // Chart 1: Workouts Count
          _buildChartCard(
            context,
            title: l10n.workoutsCount,
            icon: Icons.fitness_center_rounded,
            chartWidget: _StatisticChart(
              bucketKeys: aggregated.bucketKeys,
              seriesData: aggregated.workoutsSeries,
              per: vm.per,
              tooltipFormatter: (val) => '${val.toInt()}',
              yAxisFormatter: (val) => val.toInt().toString(),
              chartColor: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),

          // Chart 2: Total Duration
          _buildChartCard(
            context,
            title: l10n.total_duration,
            icon: Icons.timer_outlined,
            chartWidget: _StatisticChart(
              bucketKeys: aggregated.bucketKeys,
              seriesData: aggregated.durationSeries,
              per: vm.per,
              tooltipFormatter: (val) => formatWorkoutDuration(val.toInt()),
              yAxisFormatter: (val) => '${(val / 3600).toStringAsFixed(1)}h',
              chartColor: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),

          // Chart 3: Total Distance
          _buildChartCard(
            context,
            title: l10n.total_distance,
            icon: Icons.straighten,
            chartWidget: _StatisticChart(
              bucketKeys: aggregated.bucketKeys,
              seriesData: aggregated.distanceSeries,
              per: vm.per,
              tooltipFormatter: (val) =>
                  '${(val / 1000).toStringAsFixed(2)} km',
              yAxisFormatter: (val) => '${(val / 1000).toStringAsFixed(0)} km',
              chartColor: Colors.green,
            ),
          ),
          const SizedBox(height: 16),

          // Chart 4: Average Speed
          _buildChartCard(
            context,
            title: l10n.average_speed,
            icon: Icons.speed,
            chartWidget: _StatisticChart(
              bucketKeys: aggregated.bucketKeys,
              seriesData: aggregated.speedSeries,
              per: vm.per,
              tooltipFormatter: (val) =>
                  '${(val * 3.6).toStringAsFixed(1)} km/h',
              yAxisFormatter: (val) => '${(val * 3.6).toStringAsFixed(0)} km/h',
              chartColor: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          // Chart 5: Max Speed
          _buildChartCard(
            context,
            title: l10n.max_speed,
            icon: Icons.flash_on,
            chartWidget: _StatisticChart(
              bucketKeys: aggregated.bucketKeys,
              seriesData: aggregated.maxSpeedSeries,
              per: vm.per,
              tooltipFormatter: (val) =>
                  '${(val * 3.6).toStringAsFixed(1)} km/h',
              yAxisFormatter: (val) => '${(val * 3.6).toStringAsFixed(0)} km/h',
              chartColor: Colors.purple,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(
    BuildContext context,
    _AggregatedStats aggregated,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return Row(
      children: [
        Expanded(
          child: _SummaryTile(
            label: l10n.workoutsCount,
            value: '${aggregated.totalWorkouts}',
            icon: Icons.fitness_center,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _SummaryTile(
            label: l10n.total_duration,
            value: formatWorkoutDuration(aggregated.totalDuration.toInt()),
            icon: Icons.timer,
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _SummaryTile(
            label: l10n.total_distance,
            value: '${(aggregated.totalDistance / 1000).toStringAsFixed(1)} km',
            icon: Icons.straighten,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildChartCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget chartWidget,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: chartWidget,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordsTab(
    BuildContext context,
    StatisticOverviewViewModel vm,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    final activeRecords = vm.records.where((r) {
      if (vm.workoutType != 'all' && r.workoutType != vm.workoutType) {
        return false;
      }
      final hasDist = r.distance != null &&
          r.distance!.value != null &&
          r.distance!.value! > 0;
      final hasDur = r.duration != null &&
          r.duration!.value != null &&
          r.duration!.value! > 0;
      final hasMaxSpd = r.maxSpeed != null &&
          r.maxSpeed!.value != null &&
          r.maxSpeed!.value! > 0;
      final hasAvgSpd = r.averageSpeed != null &&
          r.averageSpeed!.value != null &&
          r.averageSpeed!.value! > 0;
      final hasUp = r.totalUp != null &&
          r.totalUp!.value != null &&
          r.totalUp!.value! > 0;
      final hasMilestones =
          r.distanceRecords != null && r.distanceRecords!.isNotEmpty;
      return hasDist ||
          hasDur ||
          hasMaxSpd ||
          hasAvgSpd ||
          hasUp ||
          hasMilestones;
    }).toList();

    if (activeRecords.isEmpty) {
      return Center(
        child: Text(
          l10n.noRecordsAvailable,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: vm.loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: activeRecords.length,
        itemBuilder: (context, index) {
          final record = activeRecords[index];
          return _buildRecordCard(context, record, l10n, colorScheme);
        },
      ),
    );
  }

  Widget _buildRecordCard(
    BuildContext context,
    WorkoutRecord record,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    final theme = Theme.of(context);
    final workoutTypeStr =
        getLocalizedWorkoutTypeName(context, record.workoutType);

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Activity Type
            Row(
              children: [
                Icon(Icons.emoji_events,
                    color: Colors.amber.shade700, size: 24),
                const SizedBox(width: 8),
                Text(
                  workoutTypeStr.isNotEmpty ? workoutTypeStr : 'Activity',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            if (record.distance != null && record.distance!.value != null)
              _RecordRow(
                icon: Icons.straighten,
                label: l10n.total_distance,
                value:
                    '${((record.distance!.value!) / 1000).toStringAsFixed(2)} km',
                date: record.distance!.date,
                workoutId: record.distance!.workoutId,
              ),

            if (record.duration != null && record.duration!.value != null)
              _RecordRow(
                icon: Icons.timer_outlined,
                label: l10n.total_duration,
                value: formatWorkoutDuration(record.duration!.value!.toInt()),
                date: record.duration!.date,
                workoutId: record.duration!.workoutId,
              ),

            if (record.maxSpeed != null && record.maxSpeed!.value != null)
              _RecordRow(
                icon: Icons.flash_on,
                label: l10n.max_speed,
                value:
                    '${(record.maxSpeed!.value! * 3.6).toStringAsFixed(1)} km/h',
                date: record.maxSpeed!.date,
                workoutId: record.maxSpeed!.workoutId,
              ),

            if (record.averageSpeed != null &&
                record.averageSpeed!.value != null)
              _RecordRow(
                icon: Icons.speed,
                label: l10n.average_speed,
                value:
                    '${(record.averageSpeed!.value! * 3.6).toStringAsFixed(1)} km/h',
                date: record.averageSpeed!.date,
                workoutId: record.averageSpeed!.workoutId,
              ),

            if (record.totalUp != null && record.totalUp!.value != null)
              _RecordRow(
                icon: Icons.arrow_upward,
                label: l10n.total_up,
                value: '${record.totalUp!.value!.toStringAsFixed(0)} m',
                date: record.totalUp!.date,
                workoutId: record.totalUp!.workoutId,
              ),

            // Distance milestone records
            if (record.distanceRecords != null &&
                record.distanceRecords!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Milestones',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              ...record.distanceRecords!.map((dr) {
                final drLabel = dr.label ??
                    '${((dr.targetDistance ?? 0) / 1000).toStringAsFixed(0)}k';
                return _RecordRow(
                  icon: Icons.flag_outlined,
                  label: drLabel,
                  value: dr.durationSeconds != null
                      ? formatWorkoutDuration(dr.durationSeconds!.toInt())
                      : '-',
                  date: dr.date,
                  onTap: (record.workoutType != null && drLabel.isNotEmpty)
                      ? () => context.push(
                            Routes.statisticRecordRanking(
                              record.workoutType!,
                              drLabel,
                            ),
                          )
                      : null,
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  _AggregatedStats _aggregateBuckets(
    Map<String, StatisticBuckets> bucketsMap,
    String selectedType,
    String per,
  ) {
    final Map<String, double> workoutsMap = {};
    final Map<String, double> durationMap = {};
    final Map<String, double> distanceMap = {};
    final Map<String, double> speedMap = {};
    final Map<String, double> maxSpeedMap = {};

    double totalWorkouts = 0;
    double totalDuration = 0;
    double totalDistance = 0;

    final Set<String> rawBucketKeys = {};

    for (final entry in bucketsMap.entries) {
      final sportKey = entry.key;
      final sportBucket = entry.value;

      if (selectedType != 'all' && sportKey != selectedType) {
        continue;
      }

      if (sportBucket.buckets == null) continue;

      for (final bEntry in sportBucket.buckets!.entries) {
        final rawKey = bEntry.key;
        final normKey = _normalizeBucketKey(rawKey, per);
        final data = bEntry.value;
        rawBucketKeys.add(normKey);

        final workouts = (data.workouts ?? 0).toDouble();
        final duration = data.durationSeconds ?? (data.duration ?? 0);
        final distance = data.distance ?? 0;
        final speed = data.averageSpeed ?? 0;
        final maxSpeed = data.maxSpeed ?? 0;

        workoutsMap[normKey] = (workoutsMap[normKey] ?? 0) + workouts;
        durationMap[normKey] = (durationMap[normKey] ?? 0) + duration;
        distanceMap[normKey] = (distanceMap[normKey] ?? 0) + distance;
        speedMap[normKey] =
            (speedMap[normKey] ?? 0) < speed ? speed : (speedMap[normKey] ?? 0);
        maxSpeedMap[normKey] = (maxSpeedMap[normKey] ?? 0) < maxSpeed
            ? maxSpeed
            : (maxSpeedMap[normKey] ?? 0);

        totalWorkouts += workouts;
        totalDuration += duration;
        totalDistance += distance;
      }
    }

    final sortedKeys = rawBucketKeys.toList()..sort();

    final workoutsSeries = sortedKeys.map((k) => workoutsMap[k] ?? 0).toList();
    final durationSeries = sortedKeys.map((k) => durationMap[k] ?? 0).toList();
    final distanceSeries = sortedKeys.map((k) => distanceMap[k] ?? 0).toList();
    final speedSeries = sortedKeys.map((k) => speedMap[k] ?? 0).toList();
    final maxSpeedSeries = sortedKeys.map((k) => maxSpeedMap[k] ?? 0).toList();

    return _AggregatedStats(
      bucketKeys: sortedKeys,
      workoutsSeries: workoutsSeries,
      durationSeries: durationSeries,
      distanceSeries: distanceSeries,
      speedSeries: speedSeries,
      maxSpeedSeries: maxSpeedSeries,
      totalWorkouts: totalWorkouts.toInt(),
      totalDuration: totalDuration,
      totalDistance: totalDistance,
    );
  }

  String _normalizeBucketKey(String key, String per) {
    if (key.isEmpty) return key;

    final parsedDate = DateTime.tryParse(key) ??
        (RegExp(r'^\d{4}-\d{2}$').hasMatch(key)
            ? DateTime.tryParse('$key-01')
            : null);

    if (per == 'year') {
      if (parsedDate != null) return parsedDate.year.toString();
      if (key.length >= 4) return key.substring(0, 4);
      return key;
    }

    if (per == 'month') {
      if (parsedDate != null) {
        return '${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}';
      }
      if (RegExp(r'^\d{4}-\d{2}$').hasMatch(key)) return key;
      return key;
    }

    if (per == 'week') {
      if (parsedDate != null) {
        final year = parsedDate.year;
        final week = _isoWeekNumber(parsedDate);
        return '$year-KW${week.toString().padLeft(2, '0')}';
      }
      return key;
    }

    return key;
  }

  int _isoWeekNumber(DateTime date) {
    final dayOfWeek = date.weekday;
    final thursday = date.add(Duration(days: 4 - dayOfWeek));
    final firstDayOfYear = DateTime(thursday.year, 1, 1);
    final dayDiff = thursday.difference(firstDayOfYear).inDays;
    return (dayDiff / 7).floor() + 1;
  }
}

class _AggregatedStats {
  _AggregatedStats({
    required this.bucketKeys,
    required this.workoutsSeries,
    required this.durationSeries,
    required this.distanceSeries,
    required this.speedSeries,
    required this.maxSpeedSeries,
    required this.totalWorkouts,
    required this.totalDuration,
    required this.totalDistance,
  });

  final List<String> bucketKeys;
  final List<double> workoutsSeries;
  final List<double> durationSeries;
  final List<double> distanceSeries;
  final List<double> speedSeries;
  final List<double> maxSpeedSeries;

  final int totalWorkouts;
  final double totalDuration;
  final double totalDistance;
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecordRow extends StatelessWidget {
  const _RecordRow({
    required this.icon,
    required this.label,
    required this.value,
    this.date,
    this.workoutId,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? date;
  final int? workoutId;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    String dateStr = '';
    if (date != null && date!.isNotEmpty) {
      final parsed = DateTime.tryParse(date!);
      if (parsed != null) {
        dateStr = DateFormat.yMMMd().format(parsed.toLocal());
      }
    }

    final handleTap = onTap ??
        (workoutId != null
            ? () => context.push(Routes.workoutWithId(workoutId!))
            : null);
    final isClickable = handleTap != null;

    Widget content = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (dateStr.isNotEmpty)
                Text(
                  dateStr,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
          if (isClickable) ...[
            const SizedBox(width: 4),
            Icon(Icons.chevron_right,
                size: 18, color: colorScheme.onSurfaceVariant),
          ],
        ],
      ),
    );

    if (isClickable) {
      return InkWell(
        onTap: handleTap,
        borderRadius: BorderRadius.circular(8),
        child: content,
      );
    }

    return content;
  }
}

class _StatisticChart extends StatelessWidget {
  const _StatisticChart({
    required this.bucketKeys,
    required this.seriesData,
    required this.per,
    required this.tooltipFormatter,
    required this.yAxisFormatter,
    required this.chartColor,
  });

  final List<String> bucketKeys;
  final List<double> seriesData;
  final String per;
  final String Function(double) tooltipFormatter;
  final String Function(double) yAxisFormatter;
  final Color chartColor;

  @override
  Widget build(BuildContext context) {
    if (seriesData.isEmpty || bucketKeys.isEmpty) {
      return const Center(child: Text('No data'));
    }

    final maxVal = seriesData.reduce((a, b) => a > b ? a : b);
    if (maxVal == 0) {
      return const Center(child: Text('No data'));
    }

    final useLineChart = seriesData.length > 31;
    final labelInterval = _calculateLabelInterval(seriesData.length);
    final labelAngle = bucketKeys.length > 10 ? 0.8 : 0.0;

    if (useLineChart) {
      final spots = <FlSpot>[];
      for (var i = 0; i < seriesData.length; i++) {
        spots.add(FlSpot(i.toDouble(), seriesData[i]));
      }

      return LineChart(
        LineChartData(
          maxY: maxVal * 1.15,
          minY: 0,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 48,
                getTitlesWidget: (val, meta) {
                  if (val == 0) return const SizedBox.shrink();
                  return Text(
                    yAxisFormatter(val),
                    style: const TextStyle(fontSize: 9, color: Colors.grey),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: bucketKeys.length > 10 ? 36 : 24,
                interval: labelInterval.toDouble(),
                getTitlesWidget: (val, meta) {
                  final idx = val.toInt();
                  if (idx >= 0 &&
                      idx < bucketKeys.length &&
                      idx % labelInterval == 0) {
                    final key = bucketKeys[idx];
                    return SideTitleWidget(
                      meta: meta,
                      angle: labelAngle,
                      child: Text(
                        _formatBucketLabel(key, per),
                        style: const TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final idx = spot.x.toInt();
                  final key = idx >= 0 && idx < bucketKeys.length
                      ? bucketKeys[idx]
                      : '';
                  return LineTooltipItem(
                    '${_formatBucketLabel(key, per)}\n${tooltipFormatter(spot.y)}',
                    const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: 2,
              color: chartColor,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: chartColor.withValues(alpha: 0.15),
              ),
            ),
          ],
        ),
      );
    }

    final barGroups = <BarChartGroupData>[];
    for (var i = 0; i < seriesData.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: seriesData[i],
              color: chartColor,
              width: seriesData.length > 20 ? 8 : 14,
              borderRadius: BorderRadius.circular(3),
            ),
          ],
        ),
      );
    }

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxVal * 1.15,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 48,
              getTitlesWidget: (val, meta) {
                if (val == 0) return const SizedBox.shrink();
                return Text(
                  yAxisFormatter(val),
                  style: const TextStyle(fontSize: 9, color: Colors.grey),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: bucketKeys.length > 10 ? 36 : 24,
              interval: labelInterval.toDouble(),
              getTitlesWidget: (val, meta) {
                final idx = val.toInt();
                if (idx >= 0 &&
                    idx < bucketKeys.length &&
                    idx % labelInterval == 0) {
                  final key = bucketKeys[idx];
                  return SideTitleWidget(
                    meta: meta,
                    angle: labelAngle,
                    child: Text(
                      _formatBucketLabel(key, per),
                      style: const TextStyle(fontSize: 9, color: Colors.grey),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final key = bucketKeys[group.x];
              return BarTooltipItem(
                '${_formatBucketLabel(key, per)}\n${tooltipFormatter(rod.toY)}',
                const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        barGroups: barGroups,
      ),
    );
  }

  int _calculateLabelInterval(int totalCount) {
    if (totalCount <= 12) return 1;
    if (totalCount <= 24) return 2;
    if (totalCount <= 60) return 5;
    if (totalCount <= 120) return 10;
    return 30;
  }

  String _formatBucketLabel(String key, String per) {
    if (key.isEmpty) return '';

    if (per == 'week') {
      if (key.contains('-KW')) {
        final parts = key.split('-KW');
        return 'KW${parts.last}';
      }
      if (key.contains('W')) {
        final parts = key.split(RegExp(r'-?W'));
        final weekNum = int.tryParse(parts.last);
        return weekNum != null ? 'KW$weekNum' : 'KW${parts.last}';
      }
      return 'KW$key';
    }

    if (per == 'month') {
      if (RegExp(r'^\d{4}-\d{2}$').hasMatch(key)) {
        final parsed = DateTime.tryParse('$key-01');
        if (parsed != null) {
          return DateFormat('MMM').format(parsed);
        }
      }
      return key;
    }

    if (per == 'year') {
      return key;
    }

    if (per == 'day') {
      final parsedDate = DateTime.tryParse(key);
      if (parsedDate != null) {
        return DateFormat('d.M.').format(parsedDate);
      }
    }

    return key;
  }
}
