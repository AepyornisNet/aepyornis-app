// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      active: json['active'] as bool? ?? false,
      admin: json['admin'] as bool? ?? false,
      lastVersion: json['lastVersion'] as String? ?? "",
      name: json['name'] as String? ?? "",
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      username: json['username'] as String? ?? "",
      iconUrl: json['icon_url'] as String?,
      domain: json['domain'] as String?,
    );

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'active': instance.active,
      'admin': instance.admin,
      'lastVersion': instance.lastVersion,
      'name': instance.name,
      'profile': instance.profile,
      'username': instance.username,
      'icon_url': instance.iconUrl,
      'domain': instance.domain,
    };
