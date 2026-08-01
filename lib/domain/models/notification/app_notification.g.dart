// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String?,
      meta: json['meta'] as Map<String, dynamic>?,
      readAt: json['read_at'] as String?,
      subject: json['subject'] as String?,
      msg: json['msg'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'meta': instance.meta,
      'read_at': instance.readAt,
      'subject': instance.subject,
      'msg': instance.msg,
      'created_at': instance.createdAt,
    };
