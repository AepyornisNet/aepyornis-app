import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:workout_tracker_app/ui/home/view_models/home_viewmodel.dart';
import 'package:workout_tracker_app/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    widget.viewModel.requestPermissions();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            Map<String, int> measurements = widget.viewModel.measurements;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      barGroups: [
                        for (var entry in measurements.entries)
                          BarChartGroupData(
                            x: measurements.keys.toList().indexOf(entry.key),
                            barRods: [
                              BarChartRodData(
                                toY: entry.value.toDouble(),
                                color: Colors.blue,
                              ),
                            ],
                          ),
                      ],
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return Text(
                                measurements.keys.toList()[value.toInt()],
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          axisNameWidget:
                              Text(AppLocalizations.of(context)!.steps),
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 45,
                          ),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      alignment: BarChartAlignment.spaceAround,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
