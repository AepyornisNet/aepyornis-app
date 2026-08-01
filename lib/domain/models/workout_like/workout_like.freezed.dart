// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_like.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutLike {
  int get id;
  @JsonKey(name: 'user_id')
  int? get userId;
  UserSummary? get user;
  @JsonKey(name: 'actor_iri')
  String? get actorIri;
  @JsonKey(name: 'actor_name')
  String? get actorName;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of WorkoutLike
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutLikeCopyWith<WorkoutLike> get copyWith =>
      _$WorkoutLikeCopyWithImpl<WorkoutLike>(this as WorkoutLike, _$identity);

  /// Serializes this WorkoutLike to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutLike &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.actorIri, actorIri) ||
                other.actorIri == actorIri) &&
            (identical(other.actorName, actorName) ||
                other.actorName == actorName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, user, actorIri, actorName, avatarUrl, createdAt);

  @override
  String toString() {
    return 'WorkoutLike(id: $id, userId: $userId, user: $user, actorIri: $actorIri, actorName: $actorName, avatarUrl: $avatarUrl, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $WorkoutLikeCopyWith<$Res> {
  factory $WorkoutLikeCopyWith(
          WorkoutLike value, $Res Function(WorkoutLike) _then) =
      _$WorkoutLikeCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int? userId,
      UserSummary? user,
      @JsonKey(name: 'actor_iri') String? actorIri,
      @JsonKey(name: 'actor_name') String? actorName,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'created_at') String? createdAt});

  $UserSummaryCopyWith<$Res>? get user;
}

/// @nodoc
class _$WorkoutLikeCopyWithImpl<$Res> implements $WorkoutLikeCopyWith<$Res> {
  _$WorkoutLikeCopyWithImpl(this._self, this._then);

  final WorkoutLike _self;
  final $Res Function(WorkoutLike) _then;

  /// Create a copy of WorkoutLike
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? user = freezed,
    Object? actorIri = freezed,
    Object? actorName = freezed,
    Object? avatarUrl = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserSummary?,
      actorIri: freezed == actorIri
          ? _self.actorIri
          : actorIri // ignore: cast_nullable_to_non_nullable
              as String?,
      actorName: freezed == actorName
          ? _self.actorName
          : actorName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of WorkoutLike
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<$Res>? get user {
    if (_self.user == null) {
      return null;
    }

    return $UserSummaryCopyWith<$Res>(_self.user!, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// Adds pattern-matching-related methods to [WorkoutLike].
extension WorkoutLikePatterns on WorkoutLike {
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
    TResult Function(_WorkoutLike value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutLike() when $default != null:
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
    TResult Function(_WorkoutLike value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutLike():
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
    TResult? Function(_WorkoutLike value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutLike() when $default != null:
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
            int id,
            @JsonKey(name: 'user_id') int? userId,
            UserSummary? user,
            @JsonKey(name: 'actor_iri') String? actorIri,
            @JsonKey(name: 'actor_name') String? actorName,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            @JsonKey(name: 'created_at') String? createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutLike() when $default != null:
        return $default(_that.id, _that.userId, _that.user, _that.actorIri,
            _that.actorName, _that.avatarUrl, _that.createdAt);
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
            int id,
            @JsonKey(name: 'user_id') int? userId,
            UserSummary? user,
            @JsonKey(name: 'actor_iri') String? actorIri,
            @JsonKey(name: 'actor_name') String? actorName,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            @JsonKey(name: 'created_at') String? createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutLike():
        return $default(_that.id, _that.userId, _that.user, _that.actorIri,
            _that.actorName, _that.avatarUrl, _that.createdAt);
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
            int id,
            @JsonKey(name: 'user_id') int? userId,
            UserSummary? user,
            @JsonKey(name: 'actor_iri') String? actorIri,
            @JsonKey(name: 'actor_name') String? actorName,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            @JsonKey(name: 'created_at') String? createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutLike() when $default != null:
        return $default(_that.id, _that.userId, _that.user, _that.actorIri,
            _that.actorName, _that.avatarUrl, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkoutLike implements WorkoutLike {
  const _WorkoutLike(
      {required this.id,
      @JsonKey(name: 'user_id') this.userId,
      this.user,
      @JsonKey(name: 'actor_iri') this.actorIri,
      @JsonKey(name: 'actor_name') this.actorName,
      @JsonKey(name: 'avatar_url') this.avatarUrl,
      @JsonKey(name: 'created_at') this.createdAt});
  factory _WorkoutLike.fromJson(Map<String, dynamic> json) =>
      _$WorkoutLikeFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  final UserSummary? user;
  @override
  @JsonKey(name: 'actor_iri')
  final String? actorIri;
  @override
  @JsonKey(name: 'actor_name')
  final String? actorName;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// Create a copy of WorkoutLike
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutLikeCopyWith<_WorkoutLike> get copyWith =>
      __$WorkoutLikeCopyWithImpl<_WorkoutLike>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkoutLikeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutLike &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.actorIri, actorIri) ||
                other.actorIri == actorIri) &&
            (identical(other.actorName, actorName) ||
                other.actorName == actorName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, user, actorIri, actorName, avatarUrl, createdAt);

  @override
  String toString() {
    return 'WorkoutLike(id: $id, userId: $userId, user: $user, actorIri: $actorIri, actorName: $actorName, avatarUrl: $avatarUrl, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutLikeCopyWith<$Res>
    implements $WorkoutLikeCopyWith<$Res> {
  factory _$WorkoutLikeCopyWith(
          _WorkoutLike value, $Res Function(_WorkoutLike) _then) =
      __$WorkoutLikeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int? userId,
      UserSummary? user,
      @JsonKey(name: 'actor_iri') String? actorIri,
      @JsonKey(name: 'actor_name') String? actorName,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'created_at') String? createdAt});

  @override
  $UserSummaryCopyWith<$Res>? get user;
}

/// @nodoc
class __$WorkoutLikeCopyWithImpl<$Res> implements _$WorkoutLikeCopyWith<$Res> {
  __$WorkoutLikeCopyWithImpl(this._self, this._then);

  final _WorkoutLike _self;
  final $Res Function(_WorkoutLike) _then;

  /// Create a copy of WorkoutLike
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? user = freezed,
    Object? actorIri = freezed,
    Object? actorName = freezed,
    Object? avatarUrl = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_WorkoutLike(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserSummary?,
      actorIri: freezed == actorIri
          ? _self.actorIri
          : actorIri // ignore: cast_nullable_to_non_nullable
              as String?,
      actorName: freezed == actorName
          ? _self.actorName
          : actorName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of WorkoutLike
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<$Res>? get user {
    if (_self.user == null) {
      return null;
    }

    return $UserSummaryCopyWith<$Res>(_self.user!, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

// dart format on
