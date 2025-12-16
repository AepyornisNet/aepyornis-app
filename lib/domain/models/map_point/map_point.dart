import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_point.freezed.dart';
part 'map_point.g.dart';

@freezed
abstract class MapPoint with _$MapPoint {
  const MapPoint._();
  const factory MapPoint({
    /* The distance from the previous point */
    required double distance,

    /* The duration from the previous point */
    required int duration,

    /* The elevation of the point */
    required double elevation,

    /* Extra metrics at this point */
    @Default({}) Map<String, dynamic> extraMetrics,

    /* The latitude of the point */
    required double lat,

    /* The longitude of the point */
    required double lng,

    /* The time the point was recorded */
    required DateTime time,

    /* The total distance of the workout up to this point */
    required double totalDistance,

    /* The total duration of the workout up to this point */
    required int totalDuration,
  }) = _MapPoint;

  // Speed in km/h
  double get speedInKmH {
    if (duration == 0) {
      return 0;
    }
    return distance / (duration / 1000000000) * 3.6;
  }

  factory MapPoint.fromJson(Map<String, dynamic> json) =>
      _$MapPointFromJson(_normalizeMapPointJson(json));
}

Map<String, dynamic> _normalizeMapPointJson(Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);

  void copyKey(String target, String source) {
    if (!normalized.containsKey(target) && json.containsKey(source)) {
      normalized[target] = json[source];
    }
  }

  copyKey('extraMetrics', 'extra_metrics');
  copyKey('totalDistance', 'total_distance');
  copyKey('totalDuration', 'total_duration');

  double coerceDouble(dynamic value, double defaultValue) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value) ?? defaultValue;
    }
    return defaultValue;
  }

  int coerceInt(dynamic value, int defaultValue) {
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value) ?? defaultValue;
    }
    return defaultValue;
  }

  void ensureDouble(String key, double defaultValue) {
    normalized[key] = coerceDouble(normalized[key], defaultValue);
  }

  void ensureInt(String key, int defaultValue) {
    normalized[key] = coerceInt(normalized[key], defaultValue);
  }

  ensureDouble('distance', 0);
  ensureDouble('elevation', 0);
  ensureDouble('lat', 0);
  ensureDouble('lng', 0);
  ensureDouble('totalDistance', 0);

  ensureInt('duration', 0);
  ensureInt('totalDuration', 0);

  normalized['time'] = (normalized['time'] as String?) ??
      DateTime.fromMillisecondsSinceEpoch(0).toIso8601String();

  return normalized;
}
