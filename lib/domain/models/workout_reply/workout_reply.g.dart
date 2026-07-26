// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutReply _$WorkoutReplyFromJson(Map<String, dynamic> json) =>
    _WorkoutReply(
      id: (json['id'] as num).toInt(),
      objectIri: json['object_iri'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      actorIri: json['actor_iri'] as String?,
      actorName: json['actor_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      content: json['content'] as String,
      createdAt: json['created_at'] as String?,
      publishedAt: json['published_at'] as String?,
    );

Map<String, dynamic> _$WorkoutReplyToJson(_WorkoutReply instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object_iri': instance.objectIri,
      'user_id': instance.userId,
      'user': instance.user,
      'actor_iri': instance.actorIri,
      'actor_name': instance.actorName,
      'avatar_url': instance.avatarUrl,
      'content': instance.content,
      'created_at': instance.createdAt,
      'published_at': instance.publishedAt,
    };
