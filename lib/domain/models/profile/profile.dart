import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:aepyornis_app/domain/models/user_preferred_units/user_preferred_units.dart';
import 'package:aepyornis_app/domain/models/workout_type/workout_type.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    int? id,
    String? createdAt,
    String? updatedAt,

    /* Whether the user's API key is active */
    @JsonKey(name: "api_active") @Default(false) bool apiActive,

    /* The user's preferred directory for auto-import */
    @JsonKey(name: "auto_import_directory")
    @Default("")
    String? autoImportDirectory,

    /* The user's preferred language */
    @Default("en") String language,

    /* Whether to show full dates in the workout details */
    @JsonKey(name: "prefer_full_date") @Default(false) bool preferFullDate,

    /* The user's preferred units */
    UserPreferredUnits? preferredUnits,

    /* Whether social sharing buttons are disabled when viewing a workout */
    @JsonKey(name: "socials_disabled") @Default(false) bool socialsDisabled,

    /* The user's preferred color scheme */
    @Default("system") String theme,

    /* The user's preferred timezone */
    @Default("UTC") String timezone,

    /* What workout type of totals to show */
    @JsonKey(name: "totals_show") WorkoutType? totalsShow,

    /* The ID of the user who owns this profile */
    @JsonKey(name: "userID") int? userID,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(_normalizeProfileJson(json));
}

Map<String, dynamic> _normalizeProfileJson(Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);
  if (!normalized.containsKey('userID') && json.containsKey('user_id')) {
    normalized['userID'] = json['user_id'];
  }
  if (normalized['preferredUnits'] == null ||
      normalized['preferredUnits'] is! Map<String, dynamic>) {
    normalized.remove('preferredUnits');
  }
  return normalized;
}
