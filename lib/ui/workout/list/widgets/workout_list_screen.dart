import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';
import 'package:aepyornis_app/routing/routes.dart';
import 'package:aepyornis_app/ui/workout/list/view_models/workout_list_viewmodel.dart';
import 'package:aepyornis_app/ui/workout/list/widgets/workout_list_tile.dart';

class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({super.key, required this.viewModel});

  final WorkoutListViewModel viewModel;

  @override
  State<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    if (widget.viewModel.workouts.isEmpty) {
      widget.viewModel.loadWorkouts.execute();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      widget.viewModel.loadMoreWorkouts();
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
          listenable: widget.viewModel,
          builder: (context, child) {
            final workouts = widget.viewModel.workouts;
            final isLoadingInitial = widget.viewModel.loadWorkouts.isExecuting.value;

            if (isLoadingInitial && workouts.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (workouts.isEmpty) {
              return const Center(child: Text('No workouts found'));
            }

            final itemCount =
                workouts.length + (widget.viewModel.hasMorePages ? 1 : 0);

            return ListView.builder(
              controller: _scrollController,
              key: const PageStorageKey('workout_list_view'),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index >= workouts.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      ),
                    ),
                  );
                }

                final workout = workouts[index];
                final isOwned = widget.viewModel.isWorkoutOwned(workout);
                return WorkoutListTile(
                  workout,
                  onEdit: isOwned
                      ? () {
                          if (workout.id != null) {
                            context.push(Routes.workoutEdit(workout.id!));
                          }
                        }
                      : null,
                  onToggleLock: isOwned
                      ? () async {
                          final res =
                              await widget.viewModel.toggleLock(workout);
                          if (res.isSuccess() && context.mounted) {
                            final isLocked = res.getOrThrow().locked;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isLocked
                                      ? 'Workout locked'
                                      : 'Workout unlocked',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        }
                      : null,
                  onDelete: isOwned
                      ? () => _confirmAndDelete(context, workout)
                      : null,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _confirmAndDelete(BuildContext context, Workout workout) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Workout'),
        content: Text(
          'Are you sure you want to delete "${workout.name}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final res = await widget.viewModel.deleteWorkout(workout);
      if (res.isSuccess() && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Workout deleted')),
        );
      } else if (res.isError() && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete: ${res.exceptionOrNull()}'),
          ),
        );
      }
    }
  }
}
