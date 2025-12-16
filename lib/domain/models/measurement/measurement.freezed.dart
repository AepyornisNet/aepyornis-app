// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'measurement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Measurement {
  int? get id;
  String? get createdAt;
  String? get updatedAt; /* The number of steps taken */
  double get steps; /* The ID of the user who owns the workout */
  int? get userID; /* The weight of the user, in kilograms */
  double? get weight; /* Resting heart rate (beats per minute) */
  @JsonKey(name: 'resting_heart_rate')
  double? get restingHeartRate; /* The date of the measurement (yyyy-mm-dd) */
  String get date; /* The height of the user, in centimeter */
  double? get height;

  /// Create a copy of Measurement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MeasurementCopyWith<Measurement> get copyWith =>
      _$MeasurementCopyWithImpl<Measurement>(this as Measurement, _$identity);

  /// Serializes this Measurement to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Measurement &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.restingHeartRate, restingHeartRate) ||
                other.restingHeartRate == restingHeartRate) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt, steps,
      userID, weight, restingHeartRate, date, height);

  @override
  String toString() {
    return 'Measurement(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, steps: $steps, userID: $userID, weight: $weight, restingHeartRate: $restingHeartRate, date: $date, height: $height)';
  }
}

/// @nodoc
abstract mixin class $MeasurementCopyWith<$Res> {
  factory $MeasurementCopyWith(
          Measurement value, $Res Function(Measurement) _then) =
      _$MeasurementCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String? createdAt,
      String? updatedAt,
      double steps,
      int? userID,
      double? weight,
      @JsonKey(name: 'resting_heart_rate') double? restingHeartRate,
      String date,
      double? height});
}

/// @nodoc
class _$MeasurementCopyWithImpl<$Res> implements $MeasurementCopyWith<$Res> {
  _$MeasurementCopyWithImpl(this._self, this._then);

  final Measurement _self;
  final $Res Function(Measurement) _then;

  /// Create a copy of Measurement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? steps = null,
    Object? userID = freezed,
    Object? weight = freezed,
    Object? restingHeartRate = freezed,
    Object? date = null,
    Object? height = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      steps: null == steps
          ? _self.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as double,
      userID: freezed == userID
          ? _self.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as int?,
      weight: freezed == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      restingHeartRate: freezed == restingHeartRate
          ? _self.restingHeartRate
          : restingHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Measurement].
extension MeasurementPatterns on Measurement {
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
    TResult Function(_Measurement value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Measurement() when $default != null:
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
    TResult Function(_Measurement value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Measurement():
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
    TResult? Function(_Measurement value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Measurement() when $default != null:
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
    TResult Function(
            int? id,
            String? createdAt,
            String? updatedAt,
            double steps,
            int? userID,
            double? weight,
            @JsonKey(name: 'resting_heart_rate') double? restingHeartRate,
            String date,
            double? height)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Measurement() when $default != null:
        return $default(
            _that.id,
            _that.createdAt,
            _that.updatedAt,
            _that.steps,
            _that.userID,
            _that.weight,
            _that.restingHeartRate,
            _that.date,
            _that.height);
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
    TResult Function(
            int? id,
            String? createdAt,
            String? updatedAt,
            double steps,
            int? userID,
            double? weight,
            @JsonKey(name: 'resting_heart_rate') double? restingHeartRate,
            String date,
            double? height)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Measurement():
        return $default(
            _that.id,
            _that.createdAt,
            _that.updatedAt,
            _that.steps,
            _that.userID,
            _that.weight,
            _that.restingHeartRate,
            _that.date,
            _that.height);
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
    TResult? Function(
            int? id,
            String? createdAt,
            String? updatedAt,
            double steps,
            int? userID,
            double? weight,
            @JsonKey(name: 'resting_heart_rate') double? restingHeartRate,
            String date,
            double? height)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Measurement() when $default != null:
        return $default(
            _that.id,
            _that.createdAt,
            _that.updatedAt,
            _that.steps,
            _that.userID,
            _that.weight,
            _that.restingHeartRate,
            _that.date,
            _that.height);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Measurement implements Measurement {
  const _Measurement(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.steps = 0,
      this.userID,
      required this.weight,
      @JsonKey(name: 'resting_heart_rate') this.restingHeartRate,
      required this.date,
      required this.height});
  factory _Measurement.fromJson(Map<String, dynamic> json) =>
      _$MeasurementFromJson(json);

  @override
  final int? id;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;
/* The number of steps taken */
  @override
  @JsonKey()
  final double steps;
/* The ID of the user who owns the workout */
  @override
  final int? userID;
/* The weight of the user, in kilograms */
  @override
  final double? weight;
/* Resting heart rate (beats per minute) */
  @override
  @JsonKey(name: 'resting_heart_rate')
  final double? restingHeartRate;
/* The date of the measurement (yyyy-mm-dd) */
  @override
  final String date;
/* The height of the user, in centimeter */
  @override
  final double? height;

  /// Create a copy of Measurement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MeasurementCopyWith<_Measurement> get copyWith =>
      __$MeasurementCopyWithImpl<_Measurement>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MeasurementToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Measurement &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.restingHeartRate, restingHeartRate) ||
                other.restingHeartRate == restingHeartRate) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt, steps,
      userID, weight, restingHeartRate, date, height);

  @override
  String toString() {
    return 'Measurement(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, steps: $steps, userID: $userID, weight: $weight, restingHeartRate: $restingHeartRate, date: $date, height: $height)';
  }
}

/// @nodoc
abstract mixin class _$MeasurementCopyWith<$Res>
    implements $MeasurementCopyWith<$Res> {
  factory _$MeasurementCopyWith(
          _Measurement value, $Res Function(_Measurement) _then) =
      __$MeasurementCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String? createdAt,
      String? updatedAt,
      double steps,
      int? userID,
      double? weight,
      @JsonKey(name: 'resting_heart_rate') double? restingHeartRate,
      String date,
      double? height});
}

/// @nodoc
class __$MeasurementCopyWithImpl<$Res> implements _$MeasurementCopyWith<$Res> {
  __$MeasurementCopyWithImpl(this._self, this._then);

  final _Measurement _self;
  final $Res Function(_Measurement) _then;

  /// Create a copy of Measurement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? steps = null,
    Object? userID = freezed,
    Object? weight = freezed,
    Object? restingHeartRate = freezed,
    Object? date = null,
    Object? height = freezed,
  }) {
    return _then(_Measurement(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      steps: null == steps
          ? _self.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as double,
      userID: freezed == userID
          ? _self.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as int?,
      weight: freezed == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      restingHeartRate: freezed == restingHeartRate
          ? _self.restingHeartRate
          : restingHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

// dart format on
