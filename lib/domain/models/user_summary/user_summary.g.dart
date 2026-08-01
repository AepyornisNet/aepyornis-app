// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSummary _$UserSummaryFromJson(Map<String, dynamic> json) => _UserSummary(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String? ?? '',
      name: json['name'] as String? ?? '',
      handle: json['handle'] as String? ?? '',
      actorUrl: json['actor_url'] as String?,
      iconUrl: json['icon_url'] as String?,
      isExternal: json['is_external'] as bool? ?? false,
      isOwn: json['is_own'] as bool? ?? false,
      isFollowing: json['is_following'] as bool? ?? false,
    );

Map<String, dynamic> _$UserSummaryToJson(_UserSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'handle': instance.handle,
      'actor_url': instance.actorUrl,
      'icon_url': instance.iconUrl,
      'is_external': instance.isExternal,
      'is_own': instance.isOwn,
      'is_following': instance.isFollowing,
    };
