// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutLike _$WorkoutLikeFromJson(Map<String, dynamic> json) => _WorkoutLike(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : UserSummary.fromJson(json['user'] as Map<String, dynamic>),
      actorIri: json['actor_iri'] as String?,
      actorName: json['actor_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$WorkoutLikeToJson(_WorkoutLike instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user': instance.user,
      'actor_iri': instance.actorIri,
      'actor_name': instance.actorName,
      'avatar_url': instance.avatarUrl,
      'created_at': instance.createdAt,
    };
