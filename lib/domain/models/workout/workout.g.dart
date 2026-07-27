// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Workout _$WorkoutFromJson(Map<String, dynamic> json) => _Workout(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      userID: (json['user_id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      dirty: json['dirty'] as bool?,
      equipment: (json['equipment'] as List<dynamic>?)
              ?.map((e) => Equipment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      data: json['map_data'] == null
          ? null
          : MapData.fromJson(json['map_data'] as Map<String, dynamic>),
      name: json['name'] as String,
      notes: json['notes'] as String? ?? '',
      publicUUID: json['public_uuid'] as String?,
      customType: json['custom_type'] as String?,
      subType: json['sub_type'] as String?,
      type: WorkoutType.fromJson(json['type']),
      visibility: json['visibility'] as String?,
      locked: json['locked'] as bool? ?? false,
      hasFile: json['has_file'] as bool? ?? false,
      hasTracks: json['has_tracks'] as bool? ?? false,
      addressString: json['address_string'] as String?,
      totalDistance: (json['total_distance'] as num?)?.toDouble() ?? 0.0,
      totalDuration: (json['total_duration'] as num?)?.toInt() ?? 0,
      pauseDuration: (json['pause_duration'] as num?)?.toInt() ?? 0,
      totalWeight: (json['total_weight'] as num?)?.toDouble() ?? 0.0,
      totalRepetitions: (json['total_repetitions'] as num?)?.toInt() ?? 0,
      totalUp: (json['total_up'] as num?)?.toDouble() ?? 0.0,
      totalDown: (json['total_down'] as num?)?.toDouble() ?? 0.0,
      averageSpeed: (json['average_speed'] as num?)?.toDouble() ?? 0.0,
      averageSpeedNoPause:
          (json['average_speed_no_pause'] as num?)?.toDouble() ?? 0.0,
      maxSpeed: (json['max_speed'] as num?)?.toDouble() ?? 0.0,
      minElevation: (json['min_elevation'] as num?)?.toDouble() ?? 0.0,
      maxElevation: (json['max_elevation'] as num?)?.toDouble() ?? 0.0,
      averageCadence: (json['average_cadence'] as num?)?.toDouble(),
      maxCadence: (json['max_cadence'] as num?)?.toDouble(),
      averageHeartRate: (json['average_heart_rate'] as num?)?.toDouble(),
      maxHeartRate: (json['max_heart_rate'] as num?)?.toDouble(),
      averagePower: (json['average_power'] as num?)?.toDouble(),
      maxPower: (json['max_power'] as num?)?.toDouble(),
      likedByMe: json['liked_by_me'] as bool? ?? false,
      likesCount: (json['likes_count'] as num?)?.toInt() ?? 0,
      repliesCount: (json['replies_count'] as num?)?.toInt() ?? 0,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map(
                  (e) => WorkoutAttachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$WorkoutToJson(_Workout instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'user_id': instance.userID,
      'user': instance.user,
      'date': instance.date.toIso8601String(),
      'dirty': instance.dirty,
      'equipment': instance.equipment,
      'map_data': instance.data,
      'name': instance.name,
      'notes': instance.notes,
      'public_uuid': instance.publicUUID,
      'custom_type': instance.customType,
      'sub_type': instance.subType,
      'type': instance.type,
      'visibility': instance.visibility,
      'locked': instance.locked,
      'has_file': instance.hasFile,
      'has_tracks': instance.hasTracks,
      'address_string': instance.addressString,
      'total_distance': instance.totalDistance,
      'total_duration': instance.totalDuration,
      'pause_duration': instance.pauseDuration,
      'total_weight': instance.totalWeight,
      'total_repetitions': instance.totalRepetitions,
      'total_up': instance.totalUp,
      'total_down': instance.totalDown,
      'average_speed': instance.averageSpeed,
      'average_speed_no_pause': instance.averageSpeedNoPause,
      'max_speed': instance.maxSpeed,
      'min_elevation': instance.minElevation,
      'max_elevation': instance.maxElevation,
      'average_cadence': instance.averageCadence,
      'max_cadence': instance.maxCadence,
      'average_heart_rate': instance.averageHeartRate,
      'max_heart_rate': instance.maxHeartRate,
      'average_power': instance.averagePower,
      'max_power': instance.maxPower,
      'liked_by_me': instance.likedByMe,
      'likes_count': instance.likesCount,
      'replies_count': instance.repliesCount,
      'attachments': instance.attachments,
    };
