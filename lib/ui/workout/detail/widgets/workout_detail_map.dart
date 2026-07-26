import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:workout_tracker_app/domain/models/workout/workout.dart';

class WorkoutDetailMap extends StatefulWidget {
  const WorkoutDetailMap({super.key, required this.workout});

  final Workout workout;

  @override
  State<WorkoutDetailMap> createState() => _WorkoutDetailMapState();
}

class _WorkoutDetailMapState extends State<WorkoutDetailMap>
    with OSMMixinObserver {
  List<GeoPoint> workoutPath = [];
  MapController? mapController;
  bool mapReady = false;

  @override
  void initState() {
    super.initState();

    final workout = widget.workout;
    final mapData = workout.data;
    final hasPoints = mapData?.details?.points.isNotEmpty ?? false;
    final center = mapData?.center;
    if (mapData != null && hasPoints && center != null) {
      workoutPath = mapData.details!.points
          .map((e) => GeoPoint(
                latitude: e.lat,
                longitude: e.lng,
              ))
          .toList();

      mapController = MapController.withPosition(
        initPosition: GeoPoint(
          latitude: center.lat,
          longitude: center.lng,
        ),
      );
      mapController!.addObserver(this);
    }
  }

  @override
  void dispose() {
    mapController?.removeObserver(this);
    mapController?.dispose();
    super.dispose();
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (!isReady || mapController == null) {
      return;
    }

    await _updatePath();
    setState(() {
      mapReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mapController == null) {
      return const Center(child: Text('No map data'));
    }
    return OSMFlutter(controller: mapController!, osmOption: OSMOption());
  }

  Future<void> _updatePath() async {
    if (mapController == null || workoutPath.isEmpty) {
      return;
    }

    await mapController!.drawRoadManually(
        workoutPath,
        RoadOption(
          roadColor: Colors.red,
          isDotted: true,
        ));
  }
}
