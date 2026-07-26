import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistics_response.freezed.dart';
part 'statistics_response.g.dart';

@freezed
abstract class StatisticsResponse with _$StatisticsResponse {
  const factory StatisticsResponse({
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'bucket_format') String? bucketFormat,
    Map<String, StatisticBuckets>? buckets,
  }) = _StatisticsResponse;

  factory StatisticsResponse.fromJson(Map<String, dynamic> json) =>
      _$StatisticsResponseFromJson(json);
}

@freezed
abstract class StatisticBuckets with _$StatisticBuckets {
  const factory StatisticBuckets({
    @JsonKey(name: 'workout_type') String? workoutType,
    @JsonKey(name: 'local_workout_type') String? localWorkoutType,
    Map<String, StatisticData>? buckets,
  }) = _StatisticBuckets;

  factory StatisticBuckets.fromJson(Map<String, dynamic> json) =>
      _$StatisticBucketsFromJson(json);
}

@freezed
abstract class StatisticData with _$StatisticData {
  const factory StatisticData({
    String? bucket,
    int? workouts,
    @JsonKey(name: 'duration_seconds') double? durationSeconds,
    double? distance,
    @JsonKey(name: 'average_speed') double? averageSpeed,
    @JsonKey(name: 'average_speed_no_pause') double? averageSpeedNoPause,
    @JsonKey(name: 'max_speed') double? maxSpeed,
    double? duration,
  }) = _StatisticData;

  factory StatisticData.fromJson(Map<String, dynamic> json) =>
      _$StatisticDataFromJson(json);
}

@freezed
abstract class WorkoutRecord with _$WorkoutRecord {
  const factory WorkoutRecord({
    @JsonKey(name: 'workout_type') String? workoutType,
    bool? active,
    RecordEntry? distance,
    @JsonKey(name: 'average_speed') RecordEntry? averageSpeed,
    @JsonKey(name: 'average_speed_no_pause') RecordEntry? averageSpeedNoPause,
    @JsonKey(name: 'max_speed') RecordEntry? maxSpeed,
    RecordEntry? duration,
    @JsonKey(name: 'total_up') RecordEntry? totalUp,
    @JsonKey(name: 'distance_records')
    List<DistanceRecordEntry>? distanceRecords,
  }) = _WorkoutRecord;

  factory WorkoutRecord.fromJson(Map<String, dynamic> json) =>
      _$WorkoutRecordFromJson(json);
}

@freezed
abstract class RecordEntry with _$RecordEntry {
  const factory RecordEntry({
    double? value,
    @JsonKey(name: 'workout_id') int? workoutId,
    String? date,
  }) = _RecordEntry;

  factory RecordEntry.fromJson(Map<String, dynamic> json) =>
      _$RecordEntryFromJson(json);
}

@freezed
abstract class DistanceRecordEntry with _$DistanceRecordEntry {
  const factory DistanceRecordEntry({
    String? label,
    @JsonKey(name: 'target_distance') double? targetDistance,
    double? distance,
    @JsonKey(name: 'duration_seconds') double? durationSeconds,
    @JsonKey(name: 'average_speed') double? averageSpeed,
    @JsonKey(name: 'workout_id') int? workoutId,
    String? date,
  }) = _DistanceRecordEntry;

  factory DistanceRecordEntry.fromJson(Map<String, dynamic> json) =>
      _$DistanceRecordEntryFromJson(json);
}
