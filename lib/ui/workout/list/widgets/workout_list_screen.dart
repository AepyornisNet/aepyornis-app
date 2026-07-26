import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker_app/routing/routes.dart';
import 'package:workout_tracker_app/ui/workout/list/view_models/workout_list_viewmodel.dart';
import 'package:workout_tracker_app/ui/workout/list/widgets/workout_list_tile.dart';

class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({super.key, required this.viewModel});

  final WorkoutListViewModel viewModel;

  @override
  State<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.viewModel.workouts.isEmpty) {
      widget.viewModel.loadWorkouts.execute();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push(Routes.workoutCreate);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await widget.viewModel.updateWorkouts();
        },
        child: ListenableBuilder(
          listenable: widget.viewModel.loadWorkouts,
          builder: (context, child) {
            return ListView.builder(
              key: const PageStorageKey('workout_list_view'),
              itemCount: widget.viewModel.workouts.length,
              itemBuilder: (context, index) {
                return WorkoutListTile(widget.viewModel.workouts[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
