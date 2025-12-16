import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracker_app/domain/models/workout/workout.dart';
import 'package:workout_tracker_app/l10n/app_localizations.dart';

class WorkoutDetailData extends StatelessWidget {
  const WorkoutDetailData(this.workout, {super.key});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    List<_WorkoutDetailListItem> items = [];

    final address = workout.addressString ?? '';
    if (address.isNotEmpty) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.location_on),
        label: AppLocalizations.of(context)!.location,
        text: address,
      ));
    }

    final source = workout.data?.creator ?? '';
    if (source.isNotEmpty) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.bookmark),
        label: AppLocalizations.of(context)!.source,
        text: source,
      ));
    }

    if (workout.totalRepetitions > 0) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.sync),
        label: AppLocalizations.of(context)!.total_repetitions,
        text: '${workout.totalRepetitions}',
      ));
    }

    if (workout.totalWeight > 0) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.fitness_center),
        label: AppLocalizations.of(context)!.total_weight,
        text: '${NumberFormat("#.##").format(workout.totalWeight)} kg',
      ));
    }

    if (workout.totalDuration > 0) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.timer),
        label: AppLocalizations.of(context)!.total_duration,
        text: _formatDuration(workout.totalDuration),
      ));
    }

    if (workout.pauseDuration > 0) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.hourglass_empty),
        label: AppLocalizations.of(context)!.time_paused,
        text: _formatDuration(workout.pauseDuration),
      ));
    }

    if (workout.totalDistance > 0) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.arrow_right_alt),
        label: AppLocalizations.of(context)!.total_distance,
        text:
            '${NumberFormat("#.##").format(workout.totalDistance / 1000)} km',
      ));
    }

    if (workout.averageSpeed > 0) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.speed),
        label: AppLocalizations.of(context)!.average_speed,
        text:
            '${NumberFormat("#.##").format(workout.averageSpeed * 3.6)} km/h',
      ));
    }

    if (workout.averageSpeedNoPause > 0) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.speed),
        label: AppLocalizations.of(context)!.average_speed_no_pause,
        text: '${NumberFormat("#.##").format(workout.averageSpeedNoPause * 3.6)} km/h',
      ));
    }

    if (workout.maxSpeed > 0) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.speed),
        label: AppLocalizations.of(context)!.max_speed,
        text: '${NumberFormat("#.##").format(workout.maxSpeed * 3.6)} km/h',
      ));
    }

    if (workout.minElevation != 0) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.terrain),
        label: AppLocalizations.of(context)!.min_elevation,
        text: '${NumberFormat("#.##").format(workout.minElevation)} m',
      ));
    }

    if (workout.maxElevation != 0) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.terrain),
        label: AppLocalizations.of(context)!.max_elevation,
        text: '${NumberFormat("#.##").format(workout.maxElevation)} m',
      ));
    }

    if (workout.totalUp != 0) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.arrow_upward),
        label: AppLocalizations.of(context)!.total_up,
        text: '${NumberFormat("#.##").format(workout.totalUp)} m',
      ));
    }

    if (workout.totalDown != 0) {
      items.add(_WorkoutDetailListItem(
        icon: const Icon(Icons.arrow_downward),
        label: AppLocalizations.of(context)!.total_down,
        text: '${NumberFormat("#.##").format(workout.totalDown)} m',
      ));
    }

    for (var item in items) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            item.icon,
            SizedBox(width: 8),
            Text(item.label),
            SizedBox(width: 8),
          ]),
          Spacer(),
          Text(item.text),
        ],
      ));
      widgets.add(SizedBox(height: 8));
    }

    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(workout.name,
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(workout.type.icon),
                SizedBox(width: 8),
                Text(DateFormat.yMMMMd().format(workout.date.toLocal())),
                Text(' - '),
                Text(DateFormat.jm().format(workout.date.toLocal())),
              ],
            ),
            SizedBox(height: 24),
            ...widgets,
          ],
        ));
  }
}

String _formatDuration(int seconds) {
  final duration = Duration(seconds: seconds);
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  if (hours > 0) {
    return '${hours}h ${minutes}m';
  }
  return '${duration.inMinutes} min';
}

class _WorkoutDetailListItem {
  const _WorkoutDetailListItem({
    required this.icon,
    required this.label,
    required this.text,
  });

  final Icon icon;
  final String label;
  final String text;
}
