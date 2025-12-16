import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:workout_tracker_app/domain/models/map_center/map_center.dart';
import 'package:workout_tracker_app/domain/models/map_data_details/map_data_details.dart';

part 'map_data.freezed.dart';
part 'map_data.g.dart';

@freezed
abstract class MapData with _$MapData {
  const factory MapData({
    MapCenter? center,
    String? creator,
    @JsonKey(name: 'extra_metrics') @Default([]) List<String> extraMetrics,
    MapDataDetails? details,
  }) = _MapData;

  factory MapData.fromJson(Map<String, dynamic> json) =>
      _$MapDataFromJson(_normalizeMapDataJson(json));
}

Map<String, dynamic> _normalizeMapDataJson(Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);

  void copyKey(String target, String source) {
    if (!normalized.containsKey(target) && json.containsKey(source)) {
      normalized[target] = json[source];
    }
  }

  copyKey('extra_metrics', 'extraMetrics');

  return normalized;
}
