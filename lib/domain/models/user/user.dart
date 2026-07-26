import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:aepyornis_app/domain/models/profile/profile.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    int? id,
    String? createdAt,
    String? updatedAt,

    /* Whether the user is active */
    @Default(false) bool active,

    /* Whether the user is an admin */
    @Default(false) bool admin,

    /* Which version of the app the user has last seen and acknowledged */
    @Default("") String lastVersion,

    /* The user's name */
    @Default("") String name,

    /* The user's profile settings */
    Profile? profile,

    /* The user's username */
    @Default("") String username,

    /* Optional user avatar URL */
    @JsonKey(name: 'icon_url') String? iconUrl,

    /* Optional ActivityPub domain */
    String? domain,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(_normalizeUserJson(json));
}

Map<String, dynamic> _normalizeUserJson(Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);
  if (normalized['profile'] == null ||
      normalized['profile'] is! Map<String, dynamic>) {
    normalized.remove('profile');
  }
  return normalized;
}
