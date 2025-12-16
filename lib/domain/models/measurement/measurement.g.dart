// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Measurement _$MeasurementFromJson(Map<String, dynamic> json) => _Measurement(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      steps: (json['steps'] as num?)?.toDouble() ?? 0,
      userID: (json['userID'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toDouble(),
      restingHeartRate: (json['resting_heart_rate'] as num?)?.toDouble(),
      date: json['date'] as String,
      height: (json['height'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MeasurementToJson(_Measurement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'steps': instance.steps,
      'userID': instance.userID,
      'weight': instance.weight,
      'resting_heart_rate': instance.restingHeartRate,
      'date': instance.date,
      'height': instance.height,
    };
