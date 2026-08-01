import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_summary.freezed.dart';
part 'user_summary.g.dart';

/// Compact public user profile info attached to workouts, likes, replies, etc.
@freezed
abstract class UserSummary with _$UserSummary {
  const factory UserSummary({
    int? id,
    @Default('') String username,
    @Default('') String name,
    @Default('') String handle,
    @JsonKey(name: 'actor_url') String? actorUrl,
    @JsonKey(name: 'icon_url') String? iconUrl,
    @JsonKey(name: 'is_external') @Default(false) bool isExternal,
    @JsonKey(name: 'is_own') @Default(false) bool isOwn,
    @JsonKey(name: 'is_following') @Default(false) bool isFollowing,
  }) = _UserSummary;

  factory UserSummary.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryFromJson(json);
}
