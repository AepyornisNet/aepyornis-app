// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_preferred_units.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPreferredUnits {
/* The user's preferred distance unit */
  String get distance; /* The user's preferred elevation unit */
  String get elevation; /* The user's preferred height unit */
  String get height; /* The user's preferred speed unit */
  String get speed; /* The user's preferred weight unit */
  String get weight;

  /// Create a copy of UserPreferredUnits
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserPreferredUnitsCopyWith<UserPreferredUnits> get copyWith =>
      _$UserPreferredUnitsCopyWithImpl<UserPreferredUnits>(
          this as UserPreferredUnits, _$identity);

  /// Serializes this UserPreferredUnits to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserPreferredUnits &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.elevation, elevation) ||
                other.elevation == elevation) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, distance, elevation, height, speed, weight);

  @override
  String toString() {
    return 'UserPreferredUnits(distance: $distance, elevation: $elevation, height: $height, speed: $speed, weight: $weight)';
  }
}

/// @nodoc
abstract mixin class $UserPreferredUnitsCopyWith<$Res> {
  factory $UserPreferredUnitsCopyWith(
          UserPreferredUnits value, $Res Function(UserPreferredUnits) _then) =
      _$UserPreferredUnitsCopyWithImpl;
  @useResult
  $Res call(
      {String distance,
      String elevation,
      String height,
      String speed,
      String weight});
}

/// @nodoc
class _$UserPreferredUnitsCopyWithImpl<$Res>
    implements $UserPreferredUnitsCopyWith<$Res> {
  _$UserPreferredUnitsCopyWithImpl(this._self, this._then);

  final UserPreferredUnits _self;
  final $Res Function(UserPreferredUnits) _then;

  /// Create a copy of UserPreferredUnits
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distance = null,
    Object? elevation = null,
    Object? height = null,
    Object? speed = null,
    Object? weight = null,
  }) {
    return _then(_self.copyWith(
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      elevation: null == elevation
          ? _self.elevation
          : elevation // ignore: cast_nullable_to_non_nullable
              as String,
      height: null == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as String,
      speed: null == speed
          ? _self.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserPreferredUnits].
extension UserPreferredUnitsPatterns on UserPreferredUnits {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserPreferredUnits value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserPreferredUnits() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserPreferredUnits value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserPreferredUnits():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserPreferredUnits value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserPreferredUnits() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String distance, String elevation, String height,
            String speed, String weight)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserPreferredUnits() when $default != null:
        return $default(_that.distance, _that.elevation, _that.height,
            _that.speed, _that.weight);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String distance, String elevation, String height,
            String speed, String weight)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserPreferredUnits():
        return $default(_that.distance, _that.elevation, _that.height,
            _that.speed, _that.weight);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String distance, String elevation, String height,
            String speed, String weight)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserPreferredUnits() when $default != null:
        return $default(_that.distance, _that.elevation, _that.height,
            _that.speed, _that.weight);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserPreferredUnits implements UserPreferredUnits {
  const _UserPreferredUnits(
      {required this.distance,
      required this.elevation,
      required this.height,
      required this.speed,
      required this.weight});
  factory _UserPreferredUnits.fromJson(Map<String, dynamic> json) =>
      _$UserPreferredUnitsFromJson(json);

/* The user's preferred distance unit */
  @override
  final String distance;
/* The user's preferred elevation unit */
  @override
  final String elevation;
/* The user's preferred height unit */
  @override
  final String height;
/* The user's preferred speed unit */
  @override
  final String speed;
/* The user's preferred weight unit */
  @override
  final String weight;

  /// Create a copy of UserPreferredUnits
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserPreferredUnitsCopyWith<_UserPreferredUnits> get copyWith =>
      __$UserPreferredUnitsCopyWithImpl<_UserPreferredUnits>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserPreferredUnitsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserPreferredUnits &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.elevation, elevation) ||
                other.elevation == elevation) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, distance, elevation, height, speed, weight);

  @override
  String toString() {
    return 'UserPreferredUnits(distance: $distance, elevation: $elevation, height: $height, speed: $speed, weight: $weight)';
  }
}

/// @nodoc
abstract mixin class _$UserPreferredUnitsCopyWith<$Res>
    implements $UserPreferredUnitsCopyWith<$Res> {
  factory _$UserPreferredUnitsCopyWith(
          _UserPreferredUnits value, $Res Function(_UserPreferredUnits) _then) =
      __$UserPreferredUnitsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String distance,
      String elevation,
      String height,
      String speed,
      String weight});
}

/// @nodoc
class __$UserPreferredUnitsCopyWithImpl<$Res>
    implements _$UserPreferredUnitsCopyWith<$Res> {
  __$UserPreferredUnitsCopyWithImpl(this._self, this._then);

  final _UserPreferredUnits _self;
  final $Res Function(_UserPreferredUnits) _then;

  /// Create a copy of UserPreferredUnits
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? distance = null,
    Object? elevation = null,
    Object? height = null,
    Object? speed = null,
    Object? weight = null,
  }) {
    return _then(_UserPreferredUnits(
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      elevation: null == elevation
          ? _self.elevation
          : elevation // ignore: cast_nullable_to_non_nullable
              as String,
      height: null == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as String,
      speed: null == speed
          ? _self.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
