// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StatisticsResponse _$StatisticsResponseFromJson(Map<String, dynamic> json) =>
    _StatisticsResponse(
      userId: (json['user_id'] as num?)?.toInt(),
      bucketFormat: json['bucket_format'] as String?,
      buckets: (json['buckets'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, StatisticBuckets.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$StatisticsResponseToJson(_StatisticsResponse instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'bucket_format': instance.bucketFormat,
      'buckets': instance.buckets,
    };

_StatisticBuckets _$StatisticBucketsFromJson(Map<String, dynamic> json) =>
    _StatisticBuckets(
      workoutType: json['workout_type'] as String?,
      localWorkoutType: json['local_workout_type'] as String?,
      buckets: (json['buckets'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, StatisticData.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$StatisticBucketsToJson(_StatisticBuckets instance) =>
    <String, dynamic>{
      'workout_type': instance.workoutType,
      'local_workout_type': instance.localWorkoutType,
      'buckets': instance.buckets,
    };

_StatisticData _$StatisticDataFromJson(Map<String, dynamic> json) =>
    _StatisticData(
      bucket: json['bucket'] as String?,
      workouts: (json['workouts'] as num?)?.toInt(),
      durationSeconds: (json['duration_seconds'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      averageSpeed: (json['average_speed'] as num?)?.toDouble(),
      averageSpeedNoPause: (json['average_speed_no_pause'] as num?)?.toDouble(),
      maxSpeed: (json['max_speed'] as num?)?.toDouble(),
      duration: (json['duration'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StatisticDataToJson(_StatisticData instance) =>
    <String, dynamic>{
      'bucket': instance.bucket,
      'workouts': instance.workouts,
      'duration_seconds': instance.durationSeconds,
      'distance': instance.distance,
      'average_speed': instance.averageSpeed,
      'average_speed_no_pause': instance.averageSpeedNoPause,
      'max_speed': instance.maxSpeed,
      'duration': instance.duration,
    };

_WorkoutRecord _$WorkoutRecordFromJson(Map<String, dynamic> json) =>
    _WorkoutRecord(
      workoutType: json['workout_type'] as String?,
      active: json['active'] as bool?,
      distance: json['distance'] == null
          ? null
          : RecordEntry.fromJson(json['distance'] as Map<String, dynamic>),
      averageSpeed: json['average_speed'] == null
          ? null
          : RecordEntry.fromJson(json['average_speed'] as Map<String, dynamic>),
      averageSpeedNoPause: json['average_speed_no_pause'] == null
          ? null
          : RecordEntry.fromJson(
              json['average_speed_no_pause'] as Map<String, dynamic>),
      maxSpeed: json['max_speed'] == null
          ? null
          : RecordEntry.fromJson(json['max_speed'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : RecordEntry.fromJson(json['duration'] as Map<String, dynamic>),
      totalUp: json['total_up'] == null
          ? null
          : RecordEntry.fromJson(json['total_up'] as Map<String, dynamic>),
      distanceRecords: (json['distance_records'] as List<dynamic>?)
          ?.map((e) => DistanceRecordEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutRecordToJson(_WorkoutRecord instance) =>
    <String, dynamic>{
      'workout_type': instance.workoutType,
      'active': instance.active,
      'distance': instance.distance,
      'average_speed': instance.averageSpeed,
      'average_speed_no_pause': instance.averageSpeedNoPause,
      'max_speed': instance.maxSpeed,
      'duration': instance.duration,
      'total_up': instance.totalUp,
      'distance_records': instance.distanceRecords,
    };

_RecordEntry _$RecordEntryFromJson(Map<String, dynamic> json) => _RecordEntry(
      value: (json['value'] as num?)?.toDouble(),
      workoutId: (json['workout_id'] as num?)?.toInt(),
      date: json['date'] as String?,
    );

Map<String, dynamic> _$RecordEntryToJson(_RecordEntry instance) =>
    <String, dynamic>{
      'value': instance.value,
      'workout_id': instance.workoutId,
      'date': instance.date,
    };

_DistanceRecordEntry _$DistanceRecordEntryFromJson(Map<String, dynamic> json) =>
    _DistanceRecordEntry(
      label: json['label'] as String?,
      targetDistance: (json['target_distance'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      durationSeconds: (json['duration_seconds'] as num?)?.toDouble(),
      averageSpeed: (json['average_speed'] as num?)?.toDouble(),
      workoutId: (json['workout_id'] as num?)?.toInt(),
      date: json['date'] as String?,
    );

Map<String, dynamic> _$DistanceRecordEntryToJson(
        _DistanceRecordEntry instance) =>
    <String, dynamic>{
      'label': instance.label,
      'target_distance': instance.targetDistance,
      'distance': instance.distance,
      'duration_seconds': instance.durationSeconds,
      'average_speed': instance.averageSpeed,
      'workout_id': instance.workoutId,
      'date': instance.date,
    };
