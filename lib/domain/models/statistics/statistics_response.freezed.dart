// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatisticsResponse {
  @JsonKey(name: 'user_id')
  int? get userId;
  @JsonKey(name: 'bucket_format')
  String? get bucketFormat;
  Map<String, StatisticBuckets>? get buckets;

  /// Create a copy of StatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StatisticsResponseCopyWith<StatisticsResponse> get copyWith =>
      _$StatisticsResponseCopyWithImpl<StatisticsResponse>(
          this as StatisticsResponse, _$identity);

  /// Serializes this StatisticsResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StatisticsResponse &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bucketFormat, bucketFormat) ||
                other.bucketFormat == bucketFormat) &&
            const DeepCollectionEquality().equals(other.buckets, buckets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, bucketFormat,
      const DeepCollectionEquality().hash(buckets));

  @override
  String toString() {
    return 'StatisticsResponse(userId: $userId, bucketFormat: $bucketFormat, buckets: $buckets)';
  }
}

/// @nodoc
abstract mixin class $StatisticsResponseCopyWith<$Res> {
  factory $StatisticsResponseCopyWith(
          StatisticsResponse value, $Res Function(StatisticsResponse) _then) =
      _$StatisticsResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') int? userId,
      @JsonKey(name: 'bucket_format') String? bucketFormat,
      Map<String, StatisticBuckets>? buckets});
}

/// @nodoc
class _$StatisticsResponseCopyWithImpl<$Res>
    implements $StatisticsResponseCopyWith<$Res> {
  _$StatisticsResponseCopyWithImpl(this._self, this._then);

  final StatisticsResponse _self;
  final $Res Function(StatisticsResponse) _then;

  /// Create a copy of StatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? bucketFormat = freezed,
    Object? buckets = freezed,
  }) {
    return _then(_self.copyWith(
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      bucketFormat: freezed == bucketFormat
          ? _self.bucketFormat
          : bucketFormat // ignore: cast_nullable_to_non_nullable
              as String?,
      buckets: freezed == buckets
          ? _self.buckets
          : buckets // ignore: cast_nullable_to_non_nullable
              as Map<String, StatisticBuckets>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [StatisticsResponse].
extension StatisticsResponsePatterns on StatisticsResponse {
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
    TResult Function(_StatisticsResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StatisticsResponse() when $default != null:
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
    TResult Function(_StatisticsResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticsResponse():
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
    TResult? Function(_StatisticsResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticsResponse() when $default != null:
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
            @JsonKey(name: 'user_id') int? userId,
            @JsonKey(name: 'bucket_format') String? bucketFormat,
            Map<String, StatisticBuckets>? buckets)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StatisticsResponse() when $default != null:
        return $default(_that.userId, _that.bucketFormat, _that.buckets);
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
            @JsonKey(name: 'user_id') int? userId,
            @JsonKey(name: 'bucket_format') String? bucketFormat,
            Map<String, StatisticBuckets>? buckets)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticsResponse():
        return $default(_that.userId, _that.bucketFormat, _that.buckets);
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
            @JsonKey(name: 'user_id') int? userId,
            @JsonKey(name: 'bucket_format') String? bucketFormat,
            Map<String, StatisticBuckets>? buckets)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticsResponse() when $default != null:
        return $default(_that.userId, _that.bucketFormat, _that.buckets);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StatisticsResponse implements StatisticsResponse {
  const _StatisticsResponse(
      {@JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'bucket_format') this.bucketFormat,
      final Map<String, StatisticBuckets>? buckets})
      : _buckets = buckets;
  factory _StatisticsResponse.fromJson(Map<String, dynamic> json) =>
      _$StatisticsResponseFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  @JsonKey(name: 'bucket_format')
  final String? bucketFormat;
  final Map<String, StatisticBuckets>? _buckets;
  @override
  Map<String, StatisticBuckets>? get buckets {
    final value = _buckets;
    if (value == null) return null;
    if (_buckets is EqualUnmodifiableMapView) return _buckets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of StatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StatisticsResponseCopyWith<_StatisticsResponse> get copyWith =>
      __$StatisticsResponseCopyWithImpl<_StatisticsResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StatisticsResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StatisticsResponse &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bucketFormat, bucketFormat) ||
                other.bucketFormat == bucketFormat) &&
            const DeepCollectionEquality().equals(other._buckets, _buckets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, bucketFormat,
      const DeepCollectionEquality().hash(_buckets));

  @override
  String toString() {
    return 'StatisticsResponse(userId: $userId, bucketFormat: $bucketFormat, buckets: $buckets)';
  }
}

/// @nodoc
abstract mixin class _$StatisticsResponseCopyWith<$Res>
    implements $StatisticsResponseCopyWith<$Res> {
  factory _$StatisticsResponseCopyWith(
          _StatisticsResponse value, $Res Function(_StatisticsResponse) _then) =
      __$StatisticsResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') int? userId,
      @JsonKey(name: 'bucket_format') String? bucketFormat,
      Map<String, StatisticBuckets>? buckets});
}

/// @nodoc
class __$StatisticsResponseCopyWithImpl<$Res>
    implements _$StatisticsResponseCopyWith<$Res> {
  __$StatisticsResponseCopyWithImpl(this._self, this._then);

  final _StatisticsResponse _self;
  final $Res Function(_StatisticsResponse) _then;

  /// Create a copy of StatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = freezed,
    Object? bucketFormat = freezed,
    Object? buckets = freezed,
  }) {
    return _then(_StatisticsResponse(
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      bucketFormat: freezed == bucketFormat
          ? _self.bucketFormat
          : bucketFormat // ignore: cast_nullable_to_non_nullable
              as String?,
      buckets: freezed == buckets
          ? _self._buckets
          : buckets // ignore: cast_nullable_to_non_nullable
              as Map<String, StatisticBuckets>?,
    ));
  }
}

/// @nodoc
mixin _$StatisticBuckets {
  @JsonKey(name: 'workout_type')
  String? get workoutType;
  @JsonKey(name: 'local_workout_type')
  String? get localWorkoutType;
  Map<String, StatisticData>? get buckets;

  /// Create a copy of StatisticBuckets
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StatisticBucketsCopyWith<StatisticBuckets> get copyWith =>
      _$StatisticBucketsCopyWithImpl<StatisticBuckets>(
          this as StatisticBuckets, _$identity);

  /// Serializes this StatisticBuckets to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StatisticBuckets &&
            (identical(other.workoutType, workoutType) ||
                other.workoutType == workoutType) &&
            (identical(other.localWorkoutType, localWorkoutType) ||
                other.localWorkoutType == localWorkoutType) &&
            const DeepCollectionEquality().equals(other.buckets, buckets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, workoutType, localWorkoutType,
      const DeepCollectionEquality().hash(buckets));

  @override
  String toString() {
    return 'StatisticBuckets(workoutType: $workoutType, localWorkoutType: $localWorkoutType, buckets: $buckets)';
  }
}

/// @nodoc
abstract mixin class $StatisticBucketsCopyWith<$Res> {
  factory $StatisticBucketsCopyWith(
          StatisticBuckets value, $Res Function(StatisticBuckets) _then) =
      _$StatisticBucketsCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'workout_type') String? workoutType,
      @JsonKey(name: 'local_workout_type') String? localWorkoutType,
      Map<String, StatisticData>? buckets});
}

/// @nodoc
class _$StatisticBucketsCopyWithImpl<$Res>
    implements $StatisticBucketsCopyWith<$Res> {
  _$StatisticBucketsCopyWithImpl(this._self, this._then);

  final StatisticBuckets _self;
  final $Res Function(StatisticBuckets) _then;

  /// Create a copy of StatisticBuckets
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workoutType = freezed,
    Object? localWorkoutType = freezed,
    Object? buckets = freezed,
  }) {
    return _then(_self.copyWith(
      workoutType: freezed == workoutType
          ? _self.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as String?,
      localWorkoutType: freezed == localWorkoutType
          ? _self.localWorkoutType
          : localWorkoutType // ignore: cast_nullable_to_non_nullable
              as String?,
      buckets: freezed == buckets
          ? _self.buckets
          : buckets // ignore: cast_nullable_to_non_nullable
              as Map<String, StatisticData>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [StatisticBuckets].
extension StatisticBucketsPatterns on StatisticBuckets {
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
    TResult Function(_StatisticBuckets value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StatisticBuckets() when $default != null:
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
    TResult Function(_StatisticBuckets value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticBuckets():
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
    TResult? Function(_StatisticBuckets value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticBuckets() when $default != null:
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
            @JsonKey(name: 'workout_type') String? workoutType,
            @JsonKey(name: 'local_workout_type') String? localWorkoutType,
            Map<String, StatisticData>? buckets)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StatisticBuckets() when $default != null:
        return $default(
            _that.workoutType, _that.localWorkoutType, _that.buckets);
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
            @JsonKey(name: 'workout_type') String? workoutType,
            @JsonKey(name: 'local_workout_type') String? localWorkoutType,
            Map<String, StatisticData>? buckets)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticBuckets():
        return $default(
            _that.workoutType, _that.localWorkoutType, _that.buckets);
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
            @JsonKey(name: 'workout_type') String? workoutType,
            @JsonKey(name: 'local_workout_type') String? localWorkoutType,
            Map<String, StatisticData>? buckets)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticBuckets() when $default != null:
        return $default(
            _that.workoutType, _that.localWorkoutType, _that.buckets);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StatisticBuckets implements StatisticBuckets {
  const _StatisticBuckets(
      {@JsonKey(name: 'workout_type') this.workoutType,
      @JsonKey(name: 'local_workout_type') this.localWorkoutType,
      final Map<String, StatisticData>? buckets})
      : _buckets = buckets;
  factory _StatisticBuckets.fromJson(Map<String, dynamic> json) =>
      _$StatisticBucketsFromJson(json);

  @override
  @JsonKey(name: 'workout_type')
  final String? workoutType;
  @override
  @JsonKey(name: 'local_workout_type')
  final String? localWorkoutType;
  final Map<String, StatisticData>? _buckets;
  @override
  Map<String, StatisticData>? get buckets {
    final value = _buckets;
    if (value == null) return null;
    if (_buckets is EqualUnmodifiableMapView) return _buckets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of StatisticBuckets
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StatisticBucketsCopyWith<_StatisticBuckets> get copyWith =>
      __$StatisticBucketsCopyWithImpl<_StatisticBuckets>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StatisticBucketsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StatisticBuckets &&
            (identical(other.workoutType, workoutType) ||
                other.workoutType == workoutType) &&
            (identical(other.localWorkoutType, localWorkoutType) ||
                other.localWorkoutType == localWorkoutType) &&
            const DeepCollectionEquality().equals(other._buckets, _buckets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, workoutType, localWorkoutType,
      const DeepCollectionEquality().hash(_buckets));

  @override
  String toString() {
    return 'StatisticBuckets(workoutType: $workoutType, localWorkoutType: $localWorkoutType, buckets: $buckets)';
  }
}

/// @nodoc
abstract mixin class _$StatisticBucketsCopyWith<$Res>
    implements $StatisticBucketsCopyWith<$Res> {
  factory _$StatisticBucketsCopyWith(
          _StatisticBuckets value, $Res Function(_StatisticBuckets) _then) =
      __$StatisticBucketsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'workout_type') String? workoutType,
      @JsonKey(name: 'local_workout_type') String? localWorkoutType,
      Map<String, StatisticData>? buckets});
}

/// @nodoc
class __$StatisticBucketsCopyWithImpl<$Res>
    implements _$StatisticBucketsCopyWith<$Res> {
  __$StatisticBucketsCopyWithImpl(this._self, this._then);

  final _StatisticBuckets _self;
  final $Res Function(_StatisticBuckets) _then;

  /// Create a copy of StatisticBuckets
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? workoutType = freezed,
    Object? localWorkoutType = freezed,
    Object? buckets = freezed,
  }) {
    return _then(_StatisticBuckets(
      workoutType: freezed == workoutType
          ? _self.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as String?,
      localWorkoutType: freezed == localWorkoutType
          ? _self.localWorkoutType
          : localWorkoutType // ignore: cast_nullable_to_non_nullable
              as String?,
      buckets: freezed == buckets
          ? _self._buckets
          : buckets // ignore: cast_nullable_to_non_nullable
              as Map<String, StatisticData>?,
    ));
  }
}

/// @nodoc
mixin _$StatisticData {
  String? get bucket;
  int? get workouts;
  @JsonKey(name: 'duration_seconds')
  double? get durationSeconds;
  double? get distance;
  @JsonKey(name: 'average_speed')
  double? get averageSpeed;
  @JsonKey(name: 'average_speed_no_pause')
  double? get averageSpeedNoPause;
  @JsonKey(name: 'max_speed')
  double? get maxSpeed;
  double? get duration;

  /// Create a copy of StatisticData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StatisticDataCopyWith<StatisticData> get copyWith =>
      _$StatisticDataCopyWithImpl<StatisticData>(
          this as StatisticData, _$identity);

  /// Serializes this StatisticData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StatisticData &&
            (identical(other.bucket, bucket) || other.bucket == bucket) &&
            (identical(other.workouts, workouts) ||
                other.workouts == workouts) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.averageSpeed, averageSpeed) ||
                other.averageSpeed == averageSpeed) &&
            (identical(other.averageSpeedNoPause, averageSpeedNoPause) ||
                other.averageSpeedNoPause == averageSpeedNoPause) &&
            (identical(other.maxSpeed, maxSpeed) ||
                other.maxSpeed == maxSpeed) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      bucket,
      workouts,
      durationSeconds,
      distance,
      averageSpeed,
      averageSpeedNoPause,
      maxSpeed,
      duration);

  @override
  String toString() {
    return 'StatisticData(bucket: $bucket, workouts: $workouts, durationSeconds: $durationSeconds, distance: $distance, averageSpeed: $averageSpeed, averageSpeedNoPause: $averageSpeedNoPause, maxSpeed: $maxSpeed, duration: $duration)';
  }
}

/// @nodoc
abstract mixin class $StatisticDataCopyWith<$Res> {
  factory $StatisticDataCopyWith(
          StatisticData value, $Res Function(StatisticData) _then) =
      _$StatisticDataCopyWithImpl;
  @useResult
  $Res call(
      {String? bucket,
      int? workouts,
      @JsonKey(name: 'duration_seconds') double? durationSeconds,
      double? distance,
      @JsonKey(name: 'average_speed') double? averageSpeed,
      @JsonKey(name: 'average_speed_no_pause') double? averageSpeedNoPause,
      @JsonKey(name: 'max_speed') double? maxSpeed,
      double? duration});
}

/// @nodoc
class _$StatisticDataCopyWithImpl<$Res>
    implements $StatisticDataCopyWith<$Res> {
  _$StatisticDataCopyWithImpl(this._self, this._then);

  final StatisticData _self;
  final $Res Function(StatisticData) _then;

  /// Create a copy of StatisticData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bucket = freezed,
    Object? workouts = freezed,
    Object? durationSeconds = freezed,
    Object? distance = freezed,
    Object? averageSpeed = freezed,
    Object? averageSpeedNoPause = freezed,
    Object? maxSpeed = freezed,
    Object? duration = freezed,
  }) {
    return _then(_self.copyWith(
      bucket: freezed == bucket
          ? _self.bucket
          : bucket // ignore: cast_nullable_to_non_nullable
              as String?,
      workouts: freezed == workouts
          ? _self.workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as int?,
      durationSeconds: freezed == durationSeconds
          ? _self.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as double?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      averageSpeed: freezed == averageSpeed
          ? _self.averageSpeed
          : averageSpeed // ignore: cast_nullable_to_non_nullable
              as double?,
      averageSpeedNoPause: freezed == averageSpeedNoPause
          ? _self.averageSpeedNoPause
          : averageSpeedNoPause // ignore: cast_nullable_to_non_nullable
              as double?,
      maxSpeed: freezed == maxSpeed
          ? _self.maxSpeed
          : maxSpeed // ignore: cast_nullable_to_non_nullable
              as double?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// Adds pattern-matching-related methods to [StatisticData].
extension StatisticDataPatterns on StatisticData {
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
    TResult Function(_StatisticData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StatisticData() when $default != null:
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
    TResult Function(_StatisticData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticData():
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
    TResult? Function(_StatisticData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticData() when $default != null:
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
            String? bucket,
            int? workouts,
            @JsonKey(name: 'duration_seconds') double? durationSeconds,
            double? distance,
            @JsonKey(name: 'average_speed') double? averageSpeed,
            @JsonKey(name: 'average_speed_no_pause')
            double? averageSpeedNoPause,
            @JsonKey(name: 'max_speed') double? maxSpeed,
            double? duration)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StatisticData() when $default != null:
        return $default(
            _that.bucket,
            _that.workouts,
            _that.durationSeconds,
            _that.distance,
            _that.averageSpeed,
            _that.averageSpeedNoPause,
            _that.maxSpeed,
            _that.duration);
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
            String? bucket,
            int? workouts,
            @JsonKey(name: 'duration_seconds') double? durationSeconds,
            double? distance,
            @JsonKey(name: 'average_speed') double? averageSpeed,
            @JsonKey(name: 'average_speed_no_pause')
            double? averageSpeedNoPause,
            @JsonKey(name: 'max_speed') double? maxSpeed,
            double? duration)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticData():
        return $default(
            _that.bucket,
            _that.workouts,
            _that.durationSeconds,
            _that.distance,
            _that.averageSpeed,
            _that.averageSpeedNoPause,
            _that.maxSpeed,
            _that.duration);
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
            String? bucket,
            int? workouts,
            @JsonKey(name: 'duration_seconds') double? durationSeconds,
            double? distance,
            @JsonKey(name: 'average_speed') double? averageSpeed,
            @JsonKey(name: 'average_speed_no_pause')
            double? averageSpeedNoPause,
            @JsonKey(name: 'max_speed') double? maxSpeed,
            double? duration)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StatisticData() when $default != null:
        return $default(
            _that.bucket,
            _that.workouts,
            _that.durationSeconds,
            _that.distance,
            _that.averageSpeed,
            _that.averageSpeedNoPause,
            _that.maxSpeed,
            _that.duration);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StatisticData implements StatisticData {
  const _StatisticData(
      {this.bucket,
      this.workouts,
      @JsonKey(name: 'duration_seconds') this.durationSeconds,
      this.distance,
      @JsonKey(name: 'average_speed') this.averageSpeed,
      @JsonKey(name: 'average_speed_no_pause') this.averageSpeedNoPause,
      @JsonKey(name: 'max_speed') this.maxSpeed,
      this.duration});
  factory _StatisticData.fromJson(Map<String, dynamic> json) =>
      _$StatisticDataFromJson(json);

  @override
  final String? bucket;
  @override
  final int? workouts;
  @override
  @JsonKey(name: 'duration_seconds')
  final double? durationSeconds;
  @override
  final double? distance;
  @override
  @JsonKey(name: 'average_speed')
  final double? averageSpeed;
  @override
  @JsonKey(name: 'average_speed_no_pause')
  final double? averageSpeedNoPause;
  @override
  @JsonKey(name: 'max_speed')
  final double? maxSpeed;
  @override
  final double? duration;

  /// Create a copy of StatisticData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StatisticDataCopyWith<_StatisticData> get copyWith =>
      __$StatisticDataCopyWithImpl<_StatisticData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StatisticDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StatisticData &&
            (identical(other.bucket, bucket) || other.bucket == bucket) &&
            (identical(other.workouts, workouts) ||
                other.workouts == workouts) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.averageSpeed, averageSpeed) ||
                other.averageSpeed == averageSpeed) &&
            (identical(other.averageSpeedNoPause, averageSpeedNoPause) ||
                other.averageSpeedNoPause == averageSpeedNoPause) &&
            (identical(other.maxSpeed, maxSpeed) ||
                other.maxSpeed == maxSpeed) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      bucket,
      workouts,
      durationSeconds,
      distance,
      averageSpeed,
      averageSpeedNoPause,
      maxSpeed,
      duration);

  @override
  String toString() {
    return 'StatisticData(bucket: $bucket, workouts: $workouts, durationSeconds: $durationSeconds, distance: $distance, averageSpeed: $averageSpeed, averageSpeedNoPause: $averageSpeedNoPause, maxSpeed: $maxSpeed, duration: $duration)';
  }
}

/// @nodoc
abstract mixin class _$StatisticDataCopyWith<$Res>
    implements $StatisticDataCopyWith<$Res> {
  factory _$StatisticDataCopyWith(
          _StatisticData value, $Res Function(_StatisticData) _then) =
      __$StatisticDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? bucket,
      int? workouts,
      @JsonKey(name: 'duration_seconds') double? durationSeconds,
      double? distance,
      @JsonKey(name: 'average_speed') double? averageSpeed,
      @JsonKey(name: 'average_speed_no_pause') double? averageSpeedNoPause,
      @JsonKey(name: 'max_speed') double? maxSpeed,
      double? duration});
}

/// @nodoc
class __$StatisticDataCopyWithImpl<$Res>
    implements _$StatisticDataCopyWith<$Res> {
  __$StatisticDataCopyWithImpl(this._self, this._then);

  final _StatisticData _self;
  final $Res Function(_StatisticData) _then;

  /// Create a copy of StatisticData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? bucket = freezed,
    Object? workouts = freezed,
    Object? durationSeconds = freezed,
    Object? distance = freezed,
    Object? averageSpeed = freezed,
    Object? averageSpeedNoPause = freezed,
    Object? maxSpeed = freezed,
    Object? duration = freezed,
  }) {
    return _then(_StatisticData(
      bucket: freezed == bucket
          ? _self.bucket
          : bucket // ignore: cast_nullable_to_non_nullable
              as String?,
      workouts: freezed == workouts
          ? _self.workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as int?,
      durationSeconds: freezed == durationSeconds
          ? _self.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as double?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      averageSpeed: freezed == averageSpeed
          ? _self.averageSpeed
          : averageSpeed // ignore: cast_nullable_to_non_nullable
              as double?,
      averageSpeedNoPause: freezed == averageSpeedNoPause
          ? _self.averageSpeedNoPause
          : averageSpeedNoPause // ignore: cast_nullable_to_non_nullable
              as double?,
      maxSpeed: freezed == maxSpeed
          ? _self.maxSpeed
          : maxSpeed // ignore: cast_nullable_to_non_nullable
              as double?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
mixin _$WorkoutRecord {
  @JsonKey(name: 'workout_type')
  String? get workoutType;
  bool? get active;
  RecordEntry? get distance;
  @JsonKey(name: 'average_speed')
  RecordEntry? get averageSpeed;
  @JsonKey(name: 'average_speed_no_pause')
  RecordEntry? get averageSpeedNoPause;
  @JsonKey(name: 'max_speed')
  RecordEntry? get maxSpeed;
  RecordEntry? get duration;
  @JsonKey(name: 'total_up')
  RecordEntry? get totalUp;
  @JsonKey(name: 'distance_records')
  List<DistanceRecordEntry>? get distanceRecords;

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutRecordCopyWith<WorkoutRecord> get copyWith =>
      _$WorkoutRecordCopyWithImpl<WorkoutRecord>(
          this as WorkoutRecord, _$identity);

  /// Serializes this WorkoutRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutRecord &&
            (identical(other.workoutType, workoutType) ||
                other.workoutType == workoutType) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.averageSpeed, averageSpeed) ||
                other.averageSpeed == averageSpeed) &&
            (identical(other.averageSpeedNoPause, averageSpeedNoPause) ||
                other.averageSpeedNoPause == averageSpeedNoPause) &&
            (identical(other.maxSpeed, maxSpeed) ||
                other.maxSpeed == maxSpeed) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.totalUp, totalUp) || other.totalUp == totalUp) &&
            const DeepCollectionEquality()
                .equals(other.distanceRecords, distanceRecords));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workoutType,
      active,
      distance,
      averageSpeed,
      averageSpeedNoPause,
      maxSpeed,
      duration,
      totalUp,
      const DeepCollectionEquality().hash(distanceRecords));

  @override
  String toString() {
    return 'WorkoutRecord(workoutType: $workoutType, active: $active, distance: $distance, averageSpeed: $averageSpeed, averageSpeedNoPause: $averageSpeedNoPause, maxSpeed: $maxSpeed, duration: $duration, totalUp: $totalUp, distanceRecords: $distanceRecords)';
  }
}

/// @nodoc
abstract mixin class $WorkoutRecordCopyWith<$Res> {
  factory $WorkoutRecordCopyWith(
          WorkoutRecord value, $Res Function(WorkoutRecord) _then) =
      _$WorkoutRecordCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'workout_type') String? workoutType,
      bool? active,
      RecordEntry? distance,
      @JsonKey(name: 'average_speed') RecordEntry? averageSpeed,
      @JsonKey(name: 'average_speed_no_pause') RecordEntry? averageSpeedNoPause,
      @JsonKey(name: 'max_speed') RecordEntry? maxSpeed,
      RecordEntry? duration,
      @JsonKey(name: 'total_up') RecordEntry? totalUp,
      @JsonKey(name: 'distance_records')
      List<DistanceRecordEntry>? distanceRecords});

  $RecordEntryCopyWith<$Res>? get distance;
  $RecordEntryCopyWith<$Res>? get averageSpeed;
  $RecordEntryCopyWith<$Res>? get averageSpeedNoPause;
  $RecordEntryCopyWith<$Res>? get maxSpeed;
  $RecordEntryCopyWith<$Res>? get duration;
  $RecordEntryCopyWith<$Res>? get totalUp;
}

/// @nodoc
class _$WorkoutRecordCopyWithImpl<$Res>
    implements $WorkoutRecordCopyWith<$Res> {
  _$WorkoutRecordCopyWithImpl(this._self, this._then);

  final WorkoutRecord _self;
  final $Res Function(WorkoutRecord) _then;

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workoutType = freezed,
    Object? active = freezed,
    Object? distance = freezed,
    Object? averageSpeed = freezed,
    Object? averageSpeedNoPause = freezed,
    Object? maxSpeed = freezed,
    Object? duration = freezed,
    Object? totalUp = freezed,
    Object? distanceRecords = freezed,
  }) {
    return _then(_self.copyWith(
      workoutType: freezed == workoutType
          ? _self.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _self.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as RecordEntry?,
      averageSpeed: freezed == averageSpeed
          ? _self.averageSpeed
          : averageSpeed // ignore: cast_nullable_to_non_nullable
              as RecordEntry?,
      averageSpeedNoPause: freezed == averageSpeedNoPause
          ? _self.averageSpeedNoPause
          : averageSpeedNoPause // ignore: cast_nullable_to_non_nullable
              as RecordEntry?,
      maxSpeed: freezed == maxSpeed
          ? _self.maxSpeed
          : maxSpeed // ignore: cast_nullable_to_non_nullable
              as RecordEntry?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as RecordEntry?,
      totalUp: freezed == totalUp
          ? _self.totalUp
          : totalUp // ignore: cast_nullable_to_non_nullable
              as RecordEntry?,
      distanceRecords: freezed == distanceRecords
          ? _self.distanceRecords
          : distanceRecords // ignore: cast_nullable_to_non_nullable
              as List<DistanceRecordEntry>?,
    ));
  }

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEntryCopyWith<$Res>? get distance {
    if (_self.distance == null) {
      return null;
    }

    return $RecordEntryCopyWith<$Res>(_self.distance!, (value) {
      return _then(_self.copyWith(distance: value));
    });
  }

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEntryCopyWith<$Res>? get averageSpeed {
    if (_self.averageSpeed == null) {
      return null;
    }

    return $RecordEntryCopyWith<$Res>(_self.averageSpeed!, (value) {
      return _then(_self.copyWith(averageSpeed: value));
    });
  }

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEntryCopyWith<$Res>? get averageSpeedNoPause {
    if (_self.averageSpeedNoPause == null) {
      return null;
    }

    return $RecordEntryCopyWith<$Res>(_self.averageSpeedNoPause!, (value) {
      return _then(_self.copyWith(averageSpeedNoPause: value));
    });
  }

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEntryCopyWith<$Res>? get maxSpeed {
    if (_self.maxSpeed == null) {
      return null;
    }

    return $RecordEntryCopyWith<$Res>(_self.maxSpeed!, (value) {
      return _then(_self.copyWith(maxSpeed: value));
    });
  }

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEntryCopyWith<$Res>? get duration {
    if (_self.duration == null) {
      return null;
    }

    return $RecordEntryCopyWith<$Res>(_self.duration!, (value) {
      return _then(_self.copyWith(duration: value));
    });
  }

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEntryCopyWith<$Res>? get totalUp {
    if (_self.totalUp == null) {
      return null;
    }

    return $RecordEntryCopyWith<$Res>(_self.totalUp!, (value) {
      return _then(_self.copyWith(totalUp: value));
    });
  }
}

/// Adds pattern-matching-related methods to [WorkoutRecord].
extension WorkoutRecordPatterns on WorkoutRecord {
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
    TResult Function(_WorkoutRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutRecord() when $default != null:
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
    TResult Function(_WorkoutRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutRecord():
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
    TResult? Function(_WorkoutRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutRecord() when $default != null:
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
            @JsonKey(name: 'workout_type') String? workoutType,
            bool? active,
            RecordEntry? distance,
            @JsonKey(name: 'average_speed') RecordEntry? averageSpeed,
            @JsonKey(name: 'average_speed_no_pause')
            RecordEntry? averageSpeedNoPause,
            @JsonKey(name: 'max_speed') RecordEntry? maxSpeed,
            RecordEntry? duration,
            @JsonKey(name: 'total_up') RecordEntry? totalUp,
            @JsonKey(name: 'distance_records')
            List<DistanceRecordEntry>? distanceRecords)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutRecord() when $default != null:
        return $default(
            _that.workoutType,
            _that.active,
            _that.distance,
            _that.averageSpeed,
            _that.averageSpeedNoPause,
            _that.maxSpeed,
            _that.duration,
            _that.totalUp,
            _that.distanceRecords);
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
            @JsonKey(name: 'workout_type') String? workoutType,
            bool? active,
            RecordEntry? distance,
            @JsonKey(name: 'average_speed') RecordEntry? averageSpeed,
            @JsonKey(name: 'average_speed_no_pause')
            RecordEntry? averageSpeedNoPause,
            @JsonKey(name: 'max_speed') RecordEntry? maxSpeed,
            RecordEntry? duration,
            @JsonKey(name: 'total_up') RecordEntry? totalUp,
            @JsonKey(name: 'distance_records')
            List<DistanceRecordEntry>? distanceRecords)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutRecord():
        return $default(
            _that.workoutType,
            _that.active,
            _that.distance,
            _that.averageSpeed,
            _that.averageSpeedNoPause,
            _that.maxSpeed,
            _that.duration,
            _that.totalUp,
            _that.distanceRecords);
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
            @JsonKey(name: 'workout_type') String? workoutType,
            bool? active,
            RecordEntry? distance,
            @JsonKey(name: 'average_speed') RecordEntry? averageSpeed,
            @JsonKey(name: 'average_speed_no_pause')
            RecordEntry? averageSpeedNoPause,
            @JsonKey(name: 'max_speed') RecordEntry? maxSpeed,
            RecordEntry? duration,
            @JsonKey(name: 'total_up') RecordEntry? totalUp,
            @JsonKey(name: 'distance_records')
            List<DistanceRecordEntry>? distanceRecords)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutRecord() when $default != null:
        return $default(
            _that.workoutType,
            _that.active,
            _that.distance,
            _that.averageSpeed,
            _that.averageSpeedNoPause,
            _that.maxSpeed,
            _that.duration,
            _that.totalUp,
            _that.distanceRecords);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkoutRecord implements WorkoutRecord {
  const _WorkoutRecord(
      {@JsonKey(name: 'workout_type') this.workoutType,
      this.active,
      this.distance,
      @JsonKey(name: 'average_speed') this.averageSpeed,
      @JsonKey(name: 'average_speed_no_pause') this.averageSpeedNoPause,
      @JsonKey(name: 'max_speed') this.maxSpeed,
      this.duration,
      @JsonKey(name: 'total_up') this.totalUp,
      @JsonKey(name: 'distance_records')
      final List<DistanceRecordEntry>? distanceRecords})
      : _distanceRecords = distanceRecords;
  factory _WorkoutRecord.fromJson(Map<String, dynamic> json) =>
      _$WorkoutRecordFromJson(json);

  @override
  @JsonKey(name: 'workout_type')
  final String? workoutType;
  @override
  final bool? active;
  @override
  final RecordEntry? distance;
  @override
  @JsonKey(name: 'average_speed')
  final RecordEntry? averageSpeed;
  @override
  @JsonKey(name: 'average_speed_no_pause')
  final RecordEntry? averageSpeedNoPause;
  @override
  @JsonKey(name: 'max_speed')
  final RecordEntry? maxSpeed;
  @override
  final RecordEntry? duration;
  @override
  @JsonKey(name: 'total_up')
  final RecordEntry? totalUp;
  final List<DistanceRecordEntry>? _distanceRecords;
  @override
  @JsonKey(name: 'distance_records')
  List<DistanceRecordEntry>? get distanceRecords {
    final value = _distanceRecords;
    if (value == null) return null;
    if (_distanceRecords is EqualUnmodifiableListView) return _distanceRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutRecordCopyWith<_WorkoutRecord> get copyWith =>
      __$WorkoutRecordCopyWithImpl<_WorkoutRecord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkoutRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutRecord &&
            (identical(other.workoutType, workoutType) ||
                other.workoutType == workoutType) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.averageSpeed, averageSpeed) ||
                other.averageSpeed == averageSpeed) &&
            (identical(other.averageSpeedNoPause, averageSpeedNoPause) ||
                other.averageSpeedNoPause == averageSpeedNoPause) &&
            (identical(other.maxSpeed, maxSpeed) ||
                other.maxSpeed == maxSpeed) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.totalUp, totalUp) || other.totalUp == totalUp) &&
            const DeepCollectionEquality()
                .equals(other._distanceRecords, _distanceRecords));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workoutType,
      active,
      distance,
      averageSpeed,
      averageSpeedNoPause,
      maxSpeed,
      duration,
      totalUp,
      const DeepCollectionEquality().hash(_distanceRecords));

  @override
  String toString() {
    return 'WorkoutRecord(workoutType: $workoutType, active: $active, distance: $distance, averageSpeed: $averageSpeed, averageSpeedNoPause: $averageSpeedNoPause, maxSpeed: $maxSpeed, duration: $duration, totalUp: $totalUp, distanceRecords: $distanceRecords)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutRecordCopyWith<$Res>
    implements $WorkoutRecordCopyWith<$Res> {
  factory _$WorkoutRecordCopyWith(
          _WorkoutRecord value, $Res Function(_WorkoutRecord) _then) =
      __$WorkoutRecordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'workout_type') String? workoutType,
      bool? active,
      RecordEntry? distance,
      @JsonKey(name: 'average_speed') RecordEntry? averageSpeed,
      @JsonKey(name: 'average_speed_no_pause') RecordEntry? averageSpeedNoPause,
      @JsonKey(name: 'max_speed') RecordEntry? maxSpeed,
      RecordEntry? duration,
      @JsonKey(name: 'total_up') RecordEntry? totalUp,
      @JsonKey(name: 'distance_records')
      List<DistanceRecordEntry>? distanceRecords});

  @override
  $RecordEntryCopyWith<$Res>? get distance;
  @override
  $RecordEntryCopyWith<$Res>? get averageSpeed;
  @override
  $RecordEntryCopyWith<$Res>? get averageSpeedNoPause;
  @override
  $RecordEntryCopyWith<$Res>? get maxSpeed;
  @override
  $RecordEntryCopyWith<$Res>? get duration;
  @override
  $RecordEntryCopyWith<$Res>? get totalUp;
}

/// @nodoc
class __$WorkoutRecordCopyWithImpl<$Res>
    implements _$WorkoutRecordCopyWith<$Res> {
  __$WorkoutRecordCopyWithImpl(this._self, this._then);

  final _WorkoutRecord _self;
  final $Res Function(_WorkoutRecord) _then;

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? workoutType = freezed,
    Object? active = freezed,
    Object? distance = freezed,
    Object? averageSpeed = freezed,
    Object? averageSpeedNoPause = freezed,
    Object? maxSpeed = freezed,
    Object? duration = freezed,
    Object? totalUp = freezed,
    Object? distanceRecords = freezed,
  }) {
    return _then(_WorkoutRecord(
      workoutType: freezed == workoutType
          ? _self.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _self.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as RecordEntry?,
      averageSpeed: freezed == averageSpeed
          ? _self.averageSpeed
          : averageSpeed // ignore: cast_nullable_to_non_nullable
              as RecordEntry?,
      averageSpeedNoPause: freezed == averageSpeedNoPause
          ? _self.averageSpeedNoPause
          : averageSpeedNoPause // ignore: cast_nullable_to_non_nullable
              as RecordEntry?,
      maxSpeed: freezed == maxSpeed
          ? _self.maxSpeed
          : maxSpeed // ignore: cast_nullable_to_non_nullable
              as RecordEntry?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as RecordEntry?,
      totalUp: freezed == totalUp
          ? _self.totalUp
          : totalUp // ignore: cast_nullable_to_non_nullable
              as RecordEntry?,
      distanceRecords: freezed == distanceRecords
          ? _self._distanceRecords
          : distanceRecords // ignore: cast_nullable_to_non_nullable
              as List<DistanceRecordEntry>?,
    ));
  }

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEntryCopyWith<$Res>? get distance {
    if (_self.distance == null) {
      return null;
    }

    return $RecordEntryCopyWith<$Res>(_self.distance!, (value) {
      return _then(_self.copyWith(distance: value));
    });
  }

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEntryCopyWith<$Res>? get averageSpeed {
    if (_self.averageSpeed == null) {
      return null;
    }

    return $RecordEntryCopyWith<$Res>(_self.averageSpeed!, (value) {
      return _then(_self.copyWith(averageSpeed: value));
    });
  }

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEntryCopyWith<$Res>? get averageSpeedNoPause {
    if (_self.averageSpeedNoPause == null) {
      return null;
    }

    return $RecordEntryCopyWith<$Res>(_self.averageSpeedNoPause!, (value) {
      return _then(_self.copyWith(averageSpeedNoPause: value));
    });
  }

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEntryCopyWith<$Res>? get maxSpeed {
    if (_self.maxSpeed == null) {
      return null;
    }

    return $RecordEntryCopyWith<$Res>(_self.maxSpeed!, (value) {
      return _then(_self.copyWith(maxSpeed: value));
    });
  }

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEntryCopyWith<$Res>? get duration {
    if (_self.duration == null) {
      return null;
    }

    return $RecordEntryCopyWith<$Res>(_self.duration!, (value) {
      return _then(_self.copyWith(duration: value));
    });
  }

  /// Create a copy of WorkoutRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordEntryCopyWith<$Res>? get totalUp {
    if (_self.totalUp == null) {
      return null;
    }

    return $RecordEntryCopyWith<$Res>(_self.totalUp!, (value) {
      return _then(_self.copyWith(totalUp: value));
    });
  }
}

/// @nodoc
mixin _$RecordEntry {
  double? get value;
  @JsonKey(name: 'workout_id')
  int? get workoutId;
  String? get date;

  /// Create a copy of RecordEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecordEntryCopyWith<RecordEntry> get copyWith =>
      _$RecordEntryCopyWithImpl<RecordEntry>(this as RecordEntry, _$identity);

  /// Serializes this RecordEntry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecordEntry &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.workoutId, workoutId) ||
                other.workoutId == workoutId) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, workoutId, date);

  @override
  String toString() {
    return 'RecordEntry(value: $value, workoutId: $workoutId, date: $date)';
  }
}

/// @nodoc
abstract mixin class $RecordEntryCopyWith<$Res> {
  factory $RecordEntryCopyWith(
          RecordEntry value, $Res Function(RecordEntry) _then) =
      _$RecordEntryCopyWithImpl;
  @useResult
  $Res call(
      {double? value,
      @JsonKey(name: 'workout_id') int? workoutId,
      String? date});
}

/// @nodoc
class _$RecordEntryCopyWithImpl<$Res> implements $RecordEntryCopyWith<$Res> {
  _$RecordEntryCopyWithImpl(this._self, this._then);

  final RecordEntry _self;
  final $Res Function(RecordEntry) _then;

  /// Create a copy of RecordEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? workoutId = freezed,
    Object? date = freezed,
  }) {
    return _then(_self.copyWith(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      workoutId: freezed == workoutId
          ? _self.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [RecordEntry].
extension RecordEntryPatterns on RecordEntry {
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
    TResult Function(_RecordEntry value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecordEntry() when $default != null:
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
    TResult Function(_RecordEntry value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordEntry():
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
    TResult? Function(_RecordEntry value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordEntry() when $default != null:
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
    TResult Function(double? value, @JsonKey(name: 'workout_id') int? workoutId,
            String? date)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecordEntry() when $default != null:
        return $default(_that.value, _that.workoutId, _that.date);
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
    TResult Function(double? value, @JsonKey(name: 'workout_id') int? workoutId,
            String? date)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordEntry():
        return $default(_that.value, _that.workoutId, _that.date);
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
    TResult? Function(double? value,
            @JsonKey(name: 'workout_id') int? workoutId, String? date)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecordEntry() when $default != null:
        return $default(_that.value, _that.workoutId, _that.date);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RecordEntry implements RecordEntry {
  const _RecordEntry(
      {this.value, @JsonKey(name: 'workout_id') this.workoutId, this.date});
  factory _RecordEntry.fromJson(Map<String, dynamic> json) =>
      _$RecordEntryFromJson(json);

  @override
  final double? value;
  @override
  @JsonKey(name: 'workout_id')
  final int? workoutId;
  @override
  final String? date;

  /// Create a copy of RecordEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecordEntryCopyWith<_RecordEntry> get copyWith =>
      __$RecordEntryCopyWithImpl<_RecordEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecordEntryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecordEntry &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.workoutId, workoutId) ||
                other.workoutId == workoutId) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, workoutId, date);

  @override
  String toString() {
    return 'RecordEntry(value: $value, workoutId: $workoutId, date: $date)';
  }
}

/// @nodoc
abstract mixin class _$RecordEntryCopyWith<$Res>
    implements $RecordEntryCopyWith<$Res> {
  factory _$RecordEntryCopyWith(
          _RecordEntry value, $Res Function(_RecordEntry) _then) =
      __$RecordEntryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double? value,
      @JsonKey(name: 'workout_id') int? workoutId,
      String? date});
}

/// @nodoc
class __$RecordEntryCopyWithImpl<$Res> implements _$RecordEntryCopyWith<$Res> {
  __$RecordEntryCopyWithImpl(this._self, this._then);

  final _RecordEntry _self;
  final $Res Function(_RecordEntry) _then;

  /// Create a copy of RecordEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
    Object? workoutId = freezed,
    Object? date = freezed,
  }) {
    return _then(_RecordEntry(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      workoutId: freezed == workoutId
          ? _self.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$DistanceRecordEntry {
  String? get label;
  @JsonKey(name: 'target_distance')
  double? get targetDistance;
  double? get distance;
  @JsonKey(name: 'duration_seconds')
  double? get durationSeconds;
  @JsonKey(name: 'average_speed')
  double? get averageSpeed;
  @JsonKey(name: 'workout_id')
  int? get workoutId;
  String? get date;

  /// Create a copy of DistanceRecordEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DistanceRecordEntryCopyWith<DistanceRecordEntry> get copyWith =>
      _$DistanceRecordEntryCopyWithImpl<DistanceRecordEntry>(
          this as DistanceRecordEntry, _$identity);

  /// Serializes this DistanceRecordEntry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DistanceRecordEntry &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.targetDistance, targetDistance) ||
                other.targetDistance == targetDistance) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.averageSpeed, averageSpeed) ||
                other.averageSpeed == averageSpeed) &&
            (identical(other.workoutId, workoutId) ||
                other.workoutId == workoutId) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, targetDistance, distance,
      durationSeconds, averageSpeed, workoutId, date);

  @override
  String toString() {
    return 'DistanceRecordEntry(label: $label, targetDistance: $targetDistance, distance: $distance, durationSeconds: $durationSeconds, averageSpeed: $averageSpeed, workoutId: $workoutId, date: $date)';
  }
}

/// @nodoc
abstract mixin class $DistanceRecordEntryCopyWith<$Res> {
  factory $DistanceRecordEntryCopyWith(
          DistanceRecordEntry value, $Res Function(DistanceRecordEntry) _then) =
      _$DistanceRecordEntryCopyWithImpl;
  @useResult
  $Res call(
      {String? label,
      @JsonKey(name: 'target_distance') double? targetDistance,
      double? distance,
      @JsonKey(name: 'duration_seconds') double? durationSeconds,
      @JsonKey(name: 'average_speed') double? averageSpeed,
      @JsonKey(name: 'workout_id') int? workoutId,
      String? date});
}

/// @nodoc
class _$DistanceRecordEntryCopyWithImpl<$Res>
    implements $DistanceRecordEntryCopyWith<$Res> {
  _$DistanceRecordEntryCopyWithImpl(this._self, this._then);

  final DistanceRecordEntry _self;
  final $Res Function(DistanceRecordEntry) _then;

  /// Create a copy of DistanceRecordEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = freezed,
    Object? targetDistance = freezed,
    Object? distance = freezed,
    Object? durationSeconds = freezed,
    Object? averageSpeed = freezed,
    Object? workoutId = freezed,
    Object? date = freezed,
  }) {
    return _then(_self.copyWith(
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      targetDistance: freezed == targetDistance
          ? _self.targetDistance
          : targetDistance // ignore: cast_nullable_to_non_nullable
              as double?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      durationSeconds: freezed == durationSeconds
          ? _self.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as double?,
      averageSpeed: freezed == averageSpeed
          ? _self.averageSpeed
          : averageSpeed // ignore: cast_nullable_to_non_nullable
              as double?,
      workoutId: freezed == workoutId
          ? _self.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [DistanceRecordEntry].
extension DistanceRecordEntryPatterns on DistanceRecordEntry {
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
    TResult Function(_DistanceRecordEntry value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DistanceRecordEntry() when $default != null:
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
    TResult Function(_DistanceRecordEntry value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DistanceRecordEntry():
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
    TResult? Function(_DistanceRecordEntry value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DistanceRecordEntry() when $default != null:
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
            String? label,
            @JsonKey(name: 'target_distance') double? targetDistance,
            double? distance,
            @JsonKey(name: 'duration_seconds') double? durationSeconds,
            @JsonKey(name: 'average_speed') double? averageSpeed,
            @JsonKey(name: 'workout_id') int? workoutId,
            String? date)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DistanceRecordEntry() when $default != null:
        return $default(
            _that.label,
            _that.targetDistance,
            _that.distance,
            _that.durationSeconds,
            _that.averageSpeed,
            _that.workoutId,
            _that.date);
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
            String? label,
            @JsonKey(name: 'target_distance') double? targetDistance,
            double? distance,
            @JsonKey(name: 'duration_seconds') double? durationSeconds,
            @JsonKey(name: 'average_speed') double? averageSpeed,
            @JsonKey(name: 'workout_id') int? workoutId,
            String? date)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DistanceRecordEntry():
        return $default(
            _that.label,
            _that.targetDistance,
            _that.distance,
            _that.durationSeconds,
            _that.averageSpeed,
            _that.workoutId,
            _that.date);
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
            String? label,
            @JsonKey(name: 'target_distance') double? targetDistance,
            double? distance,
            @JsonKey(name: 'duration_seconds') double? durationSeconds,
            @JsonKey(name: 'average_speed') double? averageSpeed,
            @JsonKey(name: 'workout_id') int? workoutId,
            String? date)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DistanceRecordEntry() when $default != null:
        return $default(
            _that.label,
            _that.targetDistance,
            _that.distance,
            _that.durationSeconds,
            _that.averageSpeed,
            _that.workoutId,
            _that.date);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DistanceRecordEntry implements DistanceRecordEntry {
  const _DistanceRecordEntry(
      {this.label,
      @JsonKey(name: 'target_distance') this.targetDistance,
      this.distance,
      @JsonKey(name: 'duration_seconds') this.durationSeconds,
      @JsonKey(name: 'average_speed') this.averageSpeed,
      @JsonKey(name: 'workout_id') this.workoutId,
      this.date});
  factory _DistanceRecordEntry.fromJson(Map<String, dynamic> json) =>
      _$DistanceRecordEntryFromJson(json);

  @override
  final String? label;
  @override
  @JsonKey(name: 'target_distance')
  final double? targetDistance;
  @override
  final double? distance;
  @override
  @JsonKey(name: 'duration_seconds')
  final double? durationSeconds;
  @override
  @JsonKey(name: 'average_speed')
  final double? averageSpeed;
  @override
  @JsonKey(name: 'workout_id')
  final int? workoutId;
  @override
  final String? date;

  /// Create a copy of DistanceRecordEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DistanceRecordEntryCopyWith<_DistanceRecordEntry> get copyWith =>
      __$DistanceRecordEntryCopyWithImpl<_DistanceRecordEntry>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DistanceRecordEntryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DistanceRecordEntry &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.targetDistance, targetDistance) ||
                other.targetDistance == targetDistance) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.averageSpeed, averageSpeed) ||
                other.averageSpeed == averageSpeed) &&
            (identical(other.workoutId, workoutId) ||
                other.workoutId == workoutId) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, targetDistance, distance,
      durationSeconds, averageSpeed, workoutId, date);

  @override
  String toString() {
    return 'DistanceRecordEntry(label: $label, targetDistance: $targetDistance, distance: $distance, durationSeconds: $durationSeconds, averageSpeed: $averageSpeed, workoutId: $workoutId, date: $date)';
  }
}

/// @nodoc
abstract mixin class _$DistanceRecordEntryCopyWith<$Res>
    implements $DistanceRecordEntryCopyWith<$Res> {
  factory _$DistanceRecordEntryCopyWith(_DistanceRecordEntry value,
          $Res Function(_DistanceRecordEntry) _then) =
      __$DistanceRecordEntryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? label,
      @JsonKey(name: 'target_distance') double? targetDistance,
      double? distance,
      @JsonKey(name: 'duration_seconds') double? durationSeconds,
      @JsonKey(name: 'average_speed') double? averageSpeed,
      @JsonKey(name: 'workout_id') int? workoutId,
      String? date});
}

/// @nodoc
class __$DistanceRecordEntryCopyWithImpl<$Res>
    implements _$DistanceRecordEntryCopyWith<$Res> {
  __$DistanceRecordEntryCopyWithImpl(this._self, this._then);

  final _DistanceRecordEntry _self;
  final $Res Function(_DistanceRecordEntry) _then;

  /// Create a copy of DistanceRecordEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? label = freezed,
    Object? targetDistance = freezed,
    Object? distance = freezed,
    Object? durationSeconds = freezed,
    Object? averageSpeed = freezed,
    Object? workoutId = freezed,
    Object? date = freezed,
  }) {
    return _then(_DistanceRecordEntry(
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      targetDistance: freezed == targetDistance
          ? _self.targetDistance
          : targetDistance // ignore: cast_nullable_to_non_nullable
              as double?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      durationSeconds: freezed == durationSeconds
          ? _self.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as double?,
      averageSpeed: freezed == averageSpeed
          ? _self.averageSpeed
          : averageSpeed // ignore: cast_nullable_to_non_nullable
              as double?,
      workoutId: freezed == workoutId
          ? _self.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
