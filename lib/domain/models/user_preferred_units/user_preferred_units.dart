import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_preferred_units.freezed.dart';
part 'user_preferred_units.g.dart';

@freezed
abstract class UserPreferredUnits with _$UserPreferredUnits {
  const factory UserPreferredUnits({
    /* The user's preferred distance unit */
    @Default("km") String distance,

    /* The user's preferred elevation unit */
    @Default("m") String elevation,

    /* The user's preferred height unit */
    @Default("cm") String height,

    /* The user's preferred speed unit */
    @Default("kmh") String speed,

    /* The user's preferred weight unit */
    @Default("kg") String weight,
  }) = _UserPreferredUnits;

  factory UserPreferredUnits.fromJson(Map<String, dynamic> json) =>
      _$UserPreferredUnitsFromJson(json);
}
