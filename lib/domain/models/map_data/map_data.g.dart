// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MapData _$MapDataFromJson(Map<String, dynamic> json) => _MapData(
      center: json['center'] == null
          ? null
          : MapCenter.fromJson(json['center'] as Map<String, dynamic>),
      creator: json['creator'] as String?,
      extraMetrics: (json['extra_metrics'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      details: json['details'] == null
          ? null
          : MapDataDetails.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MapDataToJson(_MapData instance) => <String, dynamic>{
      'center': instance.center,
      'creator': instance.creator,
      'extra_metrics': instance.extraMetrics,
      'details': instance.details,
    };
