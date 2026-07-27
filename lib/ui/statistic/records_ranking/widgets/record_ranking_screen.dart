import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:aepyornis_app/routing/routes.dart';
import 'package:aepyornis_app/ui/core/utils/workout_type_l10n.dart';
import 'package:aepyornis_app/ui/statistic/records_ranking/view_models/record_ranking_viewmodel.dart';

class RecordRankingScreen extends StatefulWidget {
  const RecordRankingScreen({super.key, required this.viewModel});

  final RecordRankingViewModel viewModel;

  @override
  State<RecordRankingScreen> createState() => _RecordRankingScreenState();
}

class _RecordRankingScreenState extends State<RecordRankingScreen> {
  @override
  void initState() {
    super.initState();
    if (!widget.viewModel.hasLoaded && !widget.viewModel.isLoading) {
      widget.viewModel.loadRanking();
    }
  }

  @override
  void didUpdateWidget(covariant RecordRankingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewModel != widget.viewModel &&
        !widget.viewModel.hasLoaded &&
        !widget.viewModel.isLoading) {
      widget.viewModel.loadRanking();
    }
  }

  String _formatDuration(double? seconds) {
    if (seconds == null || seconds <= 0) return '-';
    final rounded = seconds.round();
    final hrs = rounded ~/ 3600;
    final mins = (rounded % 3600) ~/ 60;
    final secs = rounded % 60;

    if (hrs > 0) {
      return '$hrs:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '$mins:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final vm = widget.viewModel;

    final sportName = getLocalizedWorkoutTypeName(context, vm.workoutType);
    final titleText = '$sportName - ${vm.label} Records';

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
      ),
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, _) {
          if (vm.isLoading || !vm.hasLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 48, color: colorScheme.error),
                    const SizedBox(height: 12),
                    Text(
                      vm.errorMessage!,
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: vm.loadRanking,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (vm.entries.isEmpty) {
            return const Center(
              child: Text('No record instances found for this target distance.'),
            );
          }

          return RefreshIndicator(
            onRefresh: vm.loadRanking,
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: vm.entries.length,
              itemBuilder: (context, index) {
                final entry = vm.entries[index];
                final rank = index + 1;
                String dateStr = '';
                if (entry.date != null && entry.date!.isNotEmpty) {
                  final parsed = DateTime.tryParse(entry.date!);
                  if (parsed != null) {
                    dateStr = DateFormat.yMMMd().format(parsed.toLocal());
                  }
                }
                var speedKmh = entry.averageSpeed ?? 0.0;
                if (speedKmh > 0 && speedKmh < 30) {
                  speedKmh = speedKmh * 3.6;
                }
                final distMeters = entry.distance ?? entry.targetDistance ?? 0.0;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: entry.workoutId != null
                        ? () => context
                            .push(Routes.workoutWithId(entry.workoutId!))
                        : null,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          // Rank Badge
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: rank == 1
                                  ? Colors.amber.shade100
                                  : rank == 2
                                      ? Colors.grey.shade200
                                      : rank == 3
                                          ? Colors.brown.shade100
                                          : colorScheme.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '#$rank',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: rank == 1
                                      ? Colors.amber.shade900
                                      : rank == 2
                                          ? Colors.grey.shade800
                                          : rank == 3
                                              ? Colors.brown.shade900
                                              : colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dateStr,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${(distMeters / 1000.0).toStringAsFixed(2)} km  ·  ${speedKmh.toStringAsFixed(1)} km/h',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Duration
                          Text(
                            _formatDuration(entry.durationSeconds),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.chevron_right,
                            color: colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
