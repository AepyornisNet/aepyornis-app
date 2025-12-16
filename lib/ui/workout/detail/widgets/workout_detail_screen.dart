import 'package:flutter/material.dart';
import 'package:workout_tracker_app/ui/workout/detail/view_models/workout_detail_viewmodel.dart';
import 'package:workout_tracker_app/ui/workout/detail/widgets/workout_detail_chart.dart';
import 'package:workout_tracker_app/ui/workout/detail/widgets/workout_detail_data.dart';
import 'package:workout_tracker_app/ui/workout/detail/widgets/workout_detail_map.dart';

class WorkoutDetailScreen extends StatefulWidget {
  const WorkoutDetailScreen({super.key, required this.viewModel});

  final WorkoutDetailViewModel viewModel;

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Detail'),
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
      body: SingleChildScrollView(
        child: Center(
          child: ListenableBuilder(
            listenable: widget.viewModel.loadWorkout,
            builder: (context, child) {
              if (widget.viewModel.workout == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<Widget> widgets = [];
              final workout = widget.viewModel.workout!;
              final hasDetails =
                  workout.data?.details != null &&
                      workout.data!.details!.points.isNotEmpty;
              if (hasDetails) {
                widgets.add(SizedBox(
                  height: 300,
                  child: WorkoutDetailMap(workout: widget.viewModel.workout!),
                ));
                widgets.add(SizedBox(height: 16));
              }

              widgets.add(WorkoutDetailData(workout));
              widgets.add(SizedBox(height: 16));

              if (hasDetails) {
                widgets.add(SizedBox(
                  height: 300,
                  child: WorkoutDetailChart(
                      workoutDetails: workout.data!.details!),
                ));
                widgets.add(SizedBox(height: 16));
              }

              return Column(children: widgets);
            },
          ),
        ),
      ),
    );
  }
}
