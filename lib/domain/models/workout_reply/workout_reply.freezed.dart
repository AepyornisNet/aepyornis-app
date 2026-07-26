// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_reply.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutReply {
  int get id;
  @JsonKey(name: 'object_iri')
  String? get objectIri;
  @JsonKey(name: 'user_id')
  int? get userId;
  User? get user;
  @JsonKey(name: 'actor_iri')
  String? get actorIri;
  @JsonKey(name: 'actor_name')
  String? get actorName;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  String get content;
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @JsonKey(name: 'published_at')
  String? get publishedAt;

  /// Create a copy of WorkoutReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutReplyCopyWith<WorkoutReply> get copyWith =>
      _$WorkoutReplyCopyWithImpl<WorkoutReply>(
          this as WorkoutReply, _$identity);

  /// Serializes this WorkoutReply to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutReply &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.objectIri, objectIri) ||
                other.objectIri == objectIri) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.actorIri, actorIri) ||
                other.actorIri == actorIri) &&
            (identical(other.actorName, actorName) ||
                other.actorName == actorName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, objectIri, userId, user,
      actorIri, actorName, avatarUrl, content, createdAt, publishedAt);

  @override
  String toString() {
    return 'WorkoutReply(id: $id, objectIri: $objectIri, userId: $userId, user: $user, actorIri: $actorIri, actorName: $actorName, avatarUrl: $avatarUrl, content: $content, createdAt: $createdAt, publishedAt: $publishedAt)';
  }
}

/// @nodoc
abstract mixin class $WorkoutReplyCopyWith<$Res> {
  factory $WorkoutReplyCopyWith(
          WorkoutReply value, $Res Function(WorkoutReply) _then) =
      _$WorkoutReplyCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'object_iri') String? objectIri,
      @JsonKey(name: 'user_id') int? userId,
      User? user,
      @JsonKey(name: 'actor_iri') String? actorIri,
      @JsonKey(name: 'actor_name') String? actorName,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      String content,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'published_at') String? publishedAt});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$WorkoutReplyCopyWithImpl<$Res> implements $WorkoutReplyCopyWith<$Res> {
  _$WorkoutReplyCopyWithImpl(this._self, this._then);

  final WorkoutReply _self;
  final $Res Function(WorkoutReply) _then;

  /// Create a copy of WorkoutReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? objectIri = freezed,
    Object? userId = freezed,
    Object? user = freezed,
    Object? actorIri = freezed,
    Object? actorName = freezed,
    Object? avatarUrl = freezed,
    Object? content = null,
    Object? createdAt = freezed,
    Object? publishedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      objectIri: freezed == objectIri
          ? _self.objectIri
          : objectIri // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
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
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedAt: freezed == publishedAt
          ? _self.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of WorkoutReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_self.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_self.user!, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// Adds pattern-matching-related methods to [WorkoutReply].
extension WorkoutReplyPatterns on WorkoutReply {
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
    TResult Function(_WorkoutReply value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutReply() when $default != null:
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
    TResult Function(_WorkoutReply value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutReply():
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
    TResult? Function(_WorkoutReply value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutReply() when $default != null:
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
            @JsonKey(name: 'object_iri') String? objectIri,
            @JsonKey(name: 'user_id') int? userId,
            User? user,
            @JsonKey(name: 'actor_iri') String? actorIri,
            @JsonKey(name: 'actor_name') String? actorName,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            String content,
            @JsonKey(name: 'created_at') String? createdAt,
            @JsonKey(name: 'published_at') String? publishedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutReply() when $default != null:
        return $default(
            _that.id,
            _that.objectIri,
            _that.userId,
            _that.user,
            _that.actorIri,
            _that.actorName,
            _that.avatarUrl,
            _that.content,
            _that.createdAt,
            _that.publishedAt);
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
            @JsonKey(name: 'object_iri') String? objectIri,
            @JsonKey(name: 'user_id') int? userId,
            User? user,
            @JsonKey(name: 'actor_iri') String? actorIri,
            @JsonKey(name: 'actor_name') String? actorName,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            String content,
            @JsonKey(name: 'created_at') String? createdAt,
            @JsonKey(name: 'published_at') String? publishedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutReply():
        return $default(
            _that.id,
            _that.objectIri,
            _that.userId,
            _that.user,
            _that.actorIri,
            _that.actorName,
            _that.avatarUrl,
            _that.content,
            _that.createdAt,
            _that.publishedAt);
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
            @JsonKey(name: 'object_iri') String? objectIri,
            @JsonKey(name: 'user_id') int? userId,
            User? user,
            @JsonKey(name: 'actor_iri') String? actorIri,
            @JsonKey(name: 'actor_name') String? actorName,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            String content,
            @JsonKey(name: 'created_at') String? createdAt,
            @JsonKey(name: 'published_at') String? publishedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutReply() when $default != null:
        return $default(
            _that.id,
            _that.objectIri,
            _that.userId,
            _that.user,
            _that.actorIri,
            _that.actorName,
            _that.avatarUrl,
            _that.content,
            _that.createdAt,
            _that.publishedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkoutReply implements WorkoutReply {
  const _WorkoutReply(
      {required this.id,
      @JsonKey(name: 'object_iri') this.objectIri,
      @JsonKey(name: 'user_id') this.userId,
      this.user,
      @JsonKey(name: 'actor_iri') this.actorIri,
      @JsonKey(name: 'actor_name') this.actorName,
      @JsonKey(name: 'avatar_url') this.avatarUrl,
      required this.content,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'published_at') this.publishedAt});
  factory _WorkoutReply.fromJson(Map<String, dynamic> json) =>
      _$WorkoutReplyFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'object_iri')
  final String? objectIri;
  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  final User? user;
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
  final String content;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'published_at')
  final String? publishedAt;

  /// Create a copy of WorkoutReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutReplyCopyWith<_WorkoutReply> get copyWith =>
      __$WorkoutReplyCopyWithImpl<_WorkoutReply>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkoutReplyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutReply &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.objectIri, objectIri) ||
                other.objectIri == objectIri) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.actorIri, actorIri) ||
                other.actorIri == actorIri) &&
            (identical(other.actorName, actorName) ||
                other.actorName == actorName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, objectIri, userId, user,
      actorIri, actorName, avatarUrl, content, createdAt, publishedAt);

  @override
  String toString() {
    return 'WorkoutReply(id: $id, objectIri: $objectIri, userId: $userId, user: $user, actorIri: $actorIri, actorName: $actorName, avatarUrl: $avatarUrl, content: $content, createdAt: $createdAt, publishedAt: $publishedAt)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutReplyCopyWith<$Res>
    implements $WorkoutReplyCopyWith<$Res> {
  factory _$WorkoutReplyCopyWith(
          _WorkoutReply value, $Res Function(_WorkoutReply) _then) =
      __$WorkoutReplyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'object_iri') String? objectIri,
      @JsonKey(name: 'user_id') int? userId,
      User? user,
      @JsonKey(name: 'actor_iri') String? actorIri,
      @JsonKey(name: 'actor_name') String? actorName,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      String content,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'published_at') String? publishedAt});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$WorkoutReplyCopyWithImpl<$Res>
    implements _$WorkoutReplyCopyWith<$Res> {
  __$WorkoutReplyCopyWithImpl(this._self, this._then);

  final _WorkoutReply _self;
  final $Res Function(_WorkoutReply) _then;

  /// Create a copy of WorkoutReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? objectIri = freezed,
    Object? userId = freezed,
    Object? user = freezed,
    Object? actorIri = freezed,
    Object? actorName = freezed,
    Object? avatarUrl = freezed,
    Object? content = null,
    Object? createdAt = freezed,
    Object? publishedAt = freezed,
  }) {
    return _then(_WorkoutReply(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      objectIri: freezed == objectIri
          ? _self.objectIri
          : objectIri // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
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
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedAt: freezed == publishedAt
          ? _self.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of WorkoutReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_self.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_self.user!, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

// dart format on
