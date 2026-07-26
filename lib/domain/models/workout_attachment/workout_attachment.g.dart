// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutAttachment _$WorkoutAttachmentFromJson(Map<String, dynamic> json) =>
    _WorkoutAttachment(
      id: (json['id'] as num?)?.toInt(),
      kind: json['kind'] as String?,
      filename: json['filename'] as String?,
      contentType: json['content_type'] as String?,
      order: (json['order'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$WorkoutAttachmentToJson(_WorkoutAttachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'filename': instance.filename,
      'content_type': instance.contentType,
      'order': instance.order,
      'url': instance.url,
    };
