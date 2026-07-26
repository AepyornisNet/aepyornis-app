import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';

class WorkoutDetailMap extends StatefulWidget {
  const WorkoutDetailMap({
    super.key,
    required this.workout,
    this.mapPadding = const EdgeInsets.all(40),
    this.onRecenter,
  });

  final Workout workout;
  final EdgeInsets mapPadding;
  final VoidCallback? onRecenter;

  @override
  State<WorkoutDetailMap> createState() => _WorkoutDetailMapState();
}

class _WorkoutDetailMapState extends State<WorkoutDetailMap> {
  final MapController _mapController = MapController();
  List<LatLng> _points = [];
  LatLngBounds? _bounds;
  LatLng? _center;

  @override
  void initState() {
    super.initState();
    _initPoints();
  }

  @override
  void didUpdateWidget(covariant WorkoutDetailMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.workout != widget.workout ||
        oldWidget.mapPadding != widget.mapPadding) {
      _initPoints();
    }
  }

  void _initPoints() {
    final pointsData = widget.workout.data?.details?.points ?? [];
    final validPoints = pointsData
        .where((p) => p.lat != 0.0 || p.lng != 0.0)
        .map((p) => LatLng(p.lat, p.lng))
        .toList();

    _points = validPoints;

    if (_points.isNotEmpty) {
      _bounds = LatLngBounds.fromPoints(_points);
      _center = _bounds!.center;
    } else if (widget.workout.data?.center != null) {
      _center = LatLng(
        widget.workout.data!.center!.lat,
        widget.workout.data!.center!.lng,
      );
    }
  }

  void _recenterMap() {
    if (_bounds != null) {
      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: _bounds!,
          padding: widget.mapPadding,
        ),
      );
    } else if (_center != null) {
      _mapController.move(_center!, 14.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_center == null && _points.isEmpty) {
      return const Center(
        child: Text('No location data available'),
      );
    }

    final initialCenter = _center ?? const LatLng(0, 0);

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: initialCenter,
            initialCameraFit: _bounds != null
                ? CameraFit.bounds(
                    bounds: _bounds!,
                    padding: widget.mapPadding,
                  )
                : null,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'net.aepyornis.app',
            ),
            if (_points.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _points,
                    strokeWidth: 4.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            if (_points.isNotEmpty)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _points.first,
                    width: 32,
                    height: 32,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 4)
                        ],
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  Marker(
                    point: _points.last,
                    width: 32,
                    height: 32,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 4)
                        ],
                      ),
                      child: const Icon(
                        Icons.flag,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
        Positioned(
          top: 16,
          right: 16,
          child: FloatingActionButton.small(
            heroTag: 'recenter_map_btn',
            onPressed: _recenterMap,
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }
}
