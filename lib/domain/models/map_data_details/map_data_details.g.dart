// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_data_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MapDataDetails _$MapDataDetailsFromJson(Map<String, dynamic> json) =>
    _MapDataDetails(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      mapDataID: (json['mapDataID'] as num).toInt(),
      points: (json['points'] as List<dynamic>?)
              ?.map((e) => MapPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      zoneRanges: json['zone_ranges'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MapDataDetailsToJson(_MapDataDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'mapDataID': instance.mapDataID,
      'points': instance.points,
      'zone_ranges': instance.zoneRanges,
    };
