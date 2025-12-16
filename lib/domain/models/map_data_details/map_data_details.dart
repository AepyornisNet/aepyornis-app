import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:workout_tracker_app/domain/models/map_point/map_point.dart';

part 'map_data_details.freezed.dart';
part 'map_data_details.g.dart';

@freezed
abstract class MapDataDetails with _$MapDataDetails {
  const factory MapDataDetails({
    int? id,
    String? createdAt,
    String? updatedAt,

    /* The ID of the map data these details belong to */
    required int mapDataID,

    /* The GPS points of the workout */
    @Default([]) List<MapPoint> points,
  }) = _MapDataDetails;

  factory MapDataDetails.fromJson(Map<String, dynamic> json) =>
      _$MapDataDetailsFromJson(_normalizeMapDataDetailsJson(json));
}

Map<String, dynamic> _normalizeMapDataDetailsJson(
    Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);

  void copyKey(String target, String source) {
    if (!normalized.containsKey(target) && json.containsKey(source)) {
      normalized[target] = json[source];
    }
  }

  copyKey('createdAt', 'created_at');
  copyKey('updatedAt', 'updated_at');
  copyKey('mapDataID', 'map_data_id');

  if (!normalized.containsKey('points')) {
    final generatedPoints = _convertStructuredDetailsToPoints(json);
    if (generatedPoints.isNotEmpty) {
      normalized['points'] = generatedPoints;
    }
  }

  return normalized;
}

List<Map<String, dynamic>> _convertStructuredDetailsToPoints(
    Map<String, dynamic> json) {
  final positions = json['position'];
  if (positions is! List) {
    return const [];
  }

  final times = (json['time'] as List<dynamic>?) ?? const [];
  final distances = (json['distance'] as List<dynamic>?) ?? const [];
  final durations = (json['duration'] as List<dynamic>?) ?? const [];
  final elevations = (json['elevation'] as List<dynamic>?) ?? const [];
  final extraMetrics = json['extra_metrics'] as Map<String, dynamic>?;

  double previousDistanceMeters = 0;
  double previousDurationSeconds = 0;

  final points = <Map<String, dynamic>>[];
  for (var i = 0; i < positions.length; i++) {
    final position = positions[i];
    if (position is! List || position.length < 2) {
      continue;
    }

    final lat = (position[0] as num?)?.toDouble();
    final lng = (position[1] as num?)?.toDouble();
    if (lat == null || lng == null) {
      continue;
    }

    final distanceValueKm = _valueAtNum(distances, i)?.toDouble();
    final totalDistanceMeters =
      (distanceValueKm ?? (previousDistanceMeters / 1000)) * 1000;
    final deltaDistance =
        math.max(totalDistanceMeters - previousDistanceMeters, 0);
    previousDistanceMeters = totalDistanceMeters;

    final totalDurationSeconds =
        _valueAtNum(durations, i)?.toDouble() ?? previousDurationSeconds;
    final deltaDurationSeconds =
        math.max(totalDurationSeconds - previousDurationSeconds, 0);
    previousDurationSeconds = totalDurationSeconds;

    final timeValue = _valueAt<String>(times, i);
    final timestamp =
        timeValue != null ? DateTime.tryParse(timeValue) : null;

    final elevationValue =
        _valueAtNum(elevations, i)?.toDouble() ?? 0;

    final metricsForPoint = <String, dynamic>{};
    extraMetrics?.forEach((key, value) {
      if (value is List && i < value.length) {
        metricsForPoint[key] = value[i];
      }
    });

    points.add({
      'distance': deltaDistance,
      'duration': (deltaDurationSeconds * 1000000000).round(),
      'elevation': elevationValue,
      'extraMetrics': metricsForPoint,
      'lat': lat,
      'lng': lng,
      'time':
          (timestamp ?? DateTime.fromMillisecondsSinceEpoch(0)).toIso8601String(),
      'totalDistance': totalDistanceMeters,
      'totalDuration': (totalDurationSeconds * 1000000000).round(),
    });
  }

  return points;
}

T? _valueAt<T>(List<dynamic> source, int index) {
  if (index < 0 || index >= source.length) {
    return null;
  }
  final value = source[index];
  if (value is T) {
    return value;
  }
  return null;
}

num? _valueAtNum(List<dynamic> source, int index) {
  final value = _valueAt<dynamic>(source, index);
  if (value is num) {
    return value;
  }
  return null;
}
