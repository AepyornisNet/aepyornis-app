import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';
import 'package:aepyornis_app/routing/routes.dart';
import 'package:aepyornis_app/ui/core/utils/formatters.dart';

class WorkoutListTile extends StatelessWidget {
  final Workout workout;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleLock;

  const WorkoutListTile(
    this.workout, {
    super.key,
    this.onEdit,
    this.onDelete,
    this.onToggleLock,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasDistance = workout.totalDistance > 0;
    final hasDuration = workout.totalDuration > 0;
    final hasAddress = workout.addressString != null &&
        workout.addressString!.trim().isNotEmpty;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withValues(alpha: 0.7),
          shape: BoxShape.circle,
        ),
        child: Icon(
          workout.type.icon,
          color: colorScheme.primary,
        ),
      ),
      title: Text(
        workout.name,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.event, size: 14, color: colorScheme.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(
                DateFormat.yMMMd().format(workout.date.toLocal()),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              if (hasDuration)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.timer_outlined,
                        size: 14, color: colorScheme.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      formatWorkoutDuration(workout.totalDuration),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              if (hasDistance)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.straighten,
                        size: 14, color: colorScheme.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      '${(workout.totalDistance / 1000).toStringAsFixed(2)} km',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              if (hasAddress)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 14, color: colorScheme.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      workout.addressString!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
      trailing: (onEdit == null && onToggleLock == null && onDelete == null)
          ? null
          : PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'edit') {
                  onEdit?.call();
                } else if (value == 'toggleLock') {
                  onToggleLock?.call();
                } else if (value == 'delete') {
                  onDelete?.call();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_rounded, size: 20),
                      SizedBox(width: 12),
                      Text('Edit'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'toggleLock',
                  child: Row(
                    children: [
                      Icon(
                        workout.locked
                            ? Icons.lock_open_rounded
                            : Icons.lock_rounded,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(workout.locked ? 'Unlock' : 'Lock'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline_rounded,
                          size: 20, color: Colors.red),
                      SizedBox(width: 12),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
      onTap: () {
        context.push(Routes.workoutWithId(workout.id!));
      },
    );
  }
}
