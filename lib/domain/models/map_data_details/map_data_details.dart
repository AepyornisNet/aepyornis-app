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

Map<String, dynamic> _normalizeMapDataDetailsJson(Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);

  void copyKey(String target, String source) {
    if (!normalized.containsKey(target) && json.containsKey(source)) {
      normalized[target] = json[source];
    }
  }

  copyKey('createdAt', 'created_at');
  copyKey('updatedAt', 'updated_at');
  copyKey('mapDataID', 'map_data_id');
  normalized['mapDataID'] ??= 0;

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
  final positions = json['position'] as List<dynamic>?;
  final times = (json['time'] as List<dynamic>?) ?? const [];
  final distances = (json['distance'] as List<dynamic>?) ?? const [];
  final durations = (json['duration'] as List<dynamic>?) ?? const [];
  final elevations = (json['elevation'] as List<dynamic>?) ?? const [];
  final speeds = (json['speed'] as List<dynamic>?) ?? const [];
  final extraMetrics = json['extra_metrics'] as Map<String, dynamic>?;

  int maxLen = 0;
  if (positions != null) maxLen = math.max(maxLen, positions.length);
  if (times.isNotEmpty) maxLen = math.max(maxLen, times.length);
  if (durations.isNotEmpty) maxLen = math.max(maxLen, durations.length);
  if (distances.isNotEmpty) maxLen = math.max(maxLen, distances.length);
  if (elevations.isNotEmpty) maxLen = math.max(maxLen, elevations.length);
  if (speeds.isNotEmpty) maxLen = math.max(maxLen, speeds.length);
  if (extraMetrics != null) {
    for (final v in extraMetrics.values) {
      if (v is List) maxLen = math.max(maxLen, v.length);
    }
  }

  if (maxLen == 0) {
    return const [];
  }

  double previousDistanceMeters = 0;
  double previousDurationSeconds = 0;
  double? prevLat;
  double? prevLng;

  final points = <Map<String, dynamic>>[];
  for (var i = 0; i < maxLen; i++) {
    double lat = 0.0;
    double lng = 0.0;
    if (positions != null && i < positions.length) {
      final pos = positions[i];
      if (pos is List && pos.length >= 2) {
        lat = (pos[0] as num?)?.toDouble() ?? 0.0;
        lng = (pos[1] as num?)?.toDouble() ?? 0.0;
      }
    }

    final distanceValueKm = _valueAtNum(distances, i)?.toDouble();
    double totalDistanceMeters = 0.0;

    if (distanceValueKm != null && distanceValueKm > 0) {
      totalDistanceMeters = distanceValueKm * 1000;
    } else if (lat != 0.0 && lng != 0.0) {
      if (prevLat != null &&
          prevLng != null &&
          (prevLat != 0.0 || prevLng != 0.0)) {
        final delta = _haversineMeters(prevLat, prevLng, lat, lng);
        if (delta < 5000) {
          totalDistanceMeters = previousDistanceMeters + delta;
        } else {
          totalDistanceMeters = previousDistanceMeters;
        }
      } else {
        totalDistanceMeters = previousDistanceMeters;
      }
      prevLat = lat;
      prevLng = lng;
    } else {
      totalDistanceMeters = previousDistanceMeters;
    }

    final deltaDistance =
        math.max(totalDistanceMeters - previousDistanceMeters, 0.0);
    previousDistanceMeters = totalDistanceMeters;

    final totalDurationSeconds =
        _valueAtNum(durations, i)?.toDouble() ?? previousDurationSeconds;
    final deltaDurationSeconds =
        math.max(totalDurationSeconds - previousDurationSeconds, 0.0);
    previousDurationSeconds = totalDurationSeconds;

    final timeValue = _valueAt<String>(times, i);
    final timestamp = timeValue != null ? DateTime.tryParse(timeValue) : null;

    final elevationValue = _valueAtNum(elevations, i)?.toDouble() ?? 0.0;

    final speedValueMps = _valueAtNum(speeds, i)?.toDouble();

    final metricsForPoint = <String, dynamic>{};
    if (speedValueMps != null) {
      metricsForPoint['speed'] = speedValueMps;
    }
    extraMetrics?.forEach((key, value) {
      if (value is List && i < value.length && value[i] != null) {
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
      'time': (timestamp ?? DateTime.fromMillisecondsSinceEpoch(0))
          .toIso8601String(),
      'totalDistance': totalDistanceMeters,
      'totalDuration': (totalDurationSeconds * 1000000000).round(),
    });
  }

  return points;
}

double _haversineMeters(double lat1, double lon1, double lat2, double lon2) {
  const r = 6371000.0;
  final dLat = (lat2 - lat1) * (math.pi / 180.0);
  final dLon = (lon2 - lon1) * (math.pi / 180.0);
  final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(lat1 * (math.pi / 180.0)) *
          math.cos(lat2 * (math.pi / 180.0)) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2);
  final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  return r * c;
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
