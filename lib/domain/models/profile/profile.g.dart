// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      apiActive: json['api_active'] as bool? ?? false,
      autoImportDirectory: json['auto_import_directory'] as String? ?? "",
      language: json['language'] as String? ?? "en",
      preferFullDate: json['prefer_full_date'] as bool? ?? false,
      preferredUnits: json['preferredUnits'] == null
          ? null
          : UserPreferredUnits.fromJson(
              json['preferredUnits'] as Map<String, dynamic>),
      socialsDisabled: json['socials_disabled'] as bool? ?? false,
      theme: json['theme'] as String? ?? "system",
      timezone: json['timezone'] as String? ?? "UTC",
      totalsShow: json['totals_show'] == null
          ? null
          : WorkoutType.fromJson(json['totals_show']),
      userID: (json['userID'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'api_active': instance.apiActive,
      'auto_import_directory': instance.autoImportDirectory,
      'language': instance.language,
      'prefer_full_date': instance.preferFullDate,
      'preferredUnits': instance.preferredUnits,
      'socials_disabled': instance.socialsDisabled,
      'theme': instance.theme,
      'timezone': instance.timezone,
      'totals_show': instance.totalsShow,
      'userID': instance.userID,
    };
