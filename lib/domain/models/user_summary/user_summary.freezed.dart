// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSummary {
  int? get id;
  String get username;
  String get name;
  String get handle;
  @JsonKey(name: 'actor_url')
  String? get actorUrl;
  @JsonKey(name: 'icon_url')
  String? get iconUrl;
  @JsonKey(name: 'is_external')
  bool get isExternal;
  @JsonKey(name: 'is_own')
  bool get isOwn;
  @JsonKey(name: 'is_following')
  bool get isFollowing;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<UserSummary> get copyWith =>
      _$UserSummaryCopyWithImpl<UserSummary>(this as UserSummary, _$identity);

  /// Serializes this UserSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.actorUrl, actorUrl) ||
                other.actorUrl == actorUrl) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.isExternal, isExternal) ||
                other.isExternal == isExternal) &&
            (identical(other.isOwn, isOwn) || other.isOwn == isOwn) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, name, handle,
      actorUrl, iconUrl, isExternal, isOwn, isFollowing);

  @override
  String toString() {
    return 'UserSummary(id: $id, username: $username, name: $name, handle: $handle, actorUrl: $actorUrl, iconUrl: $iconUrl, isExternal: $isExternal, isOwn: $isOwn, isFollowing: $isFollowing)';
  }
}

/// @nodoc
abstract mixin class $UserSummaryCopyWith<$Res> {
  factory $UserSummaryCopyWith(
          UserSummary value, $Res Function(UserSummary) _then) =
      _$UserSummaryCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String username,
      String name,
      String handle,
      @JsonKey(name: 'actor_url') String? actorUrl,
      @JsonKey(name: 'icon_url') String? iconUrl,
      @JsonKey(name: 'is_external') bool isExternal,
      @JsonKey(name: 'is_own') bool isOwn,
      @JsonKey(name: 'is_following') bool isFollowing});
}

/// @nodoc
class _$UserSummaryCopyWithImpl<$Res> implements $UserSummaryCopyWith<$Res> {
  _$UserSummaryCopyWithImpl(this._self, this._then);

  final UserSummary _self;
  final $Res Function(UserSummary) _then;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? username = null,
    Object? name = null,
    Object? handle = null,
    Object? actorUrl = freezed,
    Object? iconUrl = freezed,
    Object? isExternal = null,
    Object? isOwn = null,
    Object? isFollowing = null,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      handle: null == handle
          ? _self.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as String,
      actorUrl: freezed == actorUrl
          ? _self.actorUrl
          : actorUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      iconUrl: freezed == iconUrl
          ? _self.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isExternal: null == isExternal
          ? _self.isExternal
          : isExternal // ignore: cast_nullable_to_non_nullable
              as bool,
      isOwn: null == isOwn
          ? _self.isOwn
          : isOwn // ignore: cast_nullable_to_non_nullable
              as bool,
      isFollowing: null == isFollowing
          ? _self.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserSummary].
extension UserSummaryPatterns on UserSummary {
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
    TResult Function(_UserSummary value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserSummary() when $default != null:
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
    TResult Function(_UserSummary value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSummary():
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
    TResult? Function(_UserSummary value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSummary() when $default != null:
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
            String username,
            String name,
            String handle,
            @JsonKey(name: 'actor_url') String? actorUrl,
            @JsonKey(name: 'icon_url') String? iconUrl,
            @JsonKey(name: 'is_external') bool isExternal,
            @JsonKey(name: 'is_own') bool isOwn,
            @JsonKey(name: 'is_following') bool isFollowing)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserSummary() when $default != null:
        return $default(
            _that.id,
            _that.username,
            _that.name,
            _that.handle,
            _that.actorUrl,
            _that.iconUrl,
            _that.isExternal,
            _that.isOwn,
            _that.isFollowing);
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
            String username,
            String name,
            String handle,
            @JsonKey(name: 'actor_url') String? actorUrl,
            @JsonKey(name: 'icon_url') String? iconUrl,
            @JsonKey(name: 'is_external') bool isExternal,
            @JsonKey(name: 'is_own') bool isOwn,
            @JsonKey(name: 'is_following') bool isFollowing)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSummary():
        return $default(
            _that.id,
            _that.username,
            _that.name,
            _that.handle,
            _that.actorUrl,
            _that.iconUrl,
            _that.isExternal,
            _that.isOwn,
            _that.isFollowing);
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
            String username,
            String name,
            String handle,
            @JsonKey(name: 'actor_url') String? actorUrl,
            @JsonKey(name: 'icon_url') String? iconUrl,
            @JsonKey(name: 'is_external') bool isExternal,
            @JsonKey(name: 'is_own') bool isOwn,
            @JsonKey(name: 'is_following') bool isFollowing)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSummary() when $default != null:
        return $default(
            _that.id,
            _that.username,
            _that.name,
            _that.handle,
            _that.actorUrl,
            _that.iconUrl,
            _that.isExternal,
            _that.isOwn,
            _that.isFollowing);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserSummary implements UserSummary {
  const _UserSummary(
      {this.id,
      this.username = '',
      this.name = '',
      this.handle = '',
      @JsonKey(name: 'actor_url') this.actorUrl,
      @JsonKey(name: 'icon_url') this.iconUrl,
      @JsonKey(name: 'is_external') this.isExternal = false,
      @JsonKey(name: 'is_own') this.isOwn = false,
      @JsonKey(name: 'is_following') this.isFollowing = false});
  factory _UserSummary.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String handle;
  @override
  @JsonKey(name: 'actor_url')
  final String? actorUrl;
  @override
  @JsonKey(name: 'icon_url')
  final String? iconUrl;
  @override
  @JsonKey(name: 'is_external')
  final bool isExternal;
  @override
  @JsonKey(name: 'is_own')
  final bool isOwn;
  @override
  @JsonKey(name: 'is_following')
  final bool isFollowing;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserSummaryCopyWith<_UserSummary> get copyWith =>
      __$UserSummaryCopyWithImpl<_UserSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.actorUrl, actorUrl) ||
                other.actorUrl == actorUrl) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.isExternal, isExternal) ||
                other.isExternal == isExternal) &&
            (identical(other.isOwn, isOwn) || other.isOwn == isOwn) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, name, handle,
      actorUrl, iconUrl, isExternal, isOwn, isFollowing);

  @override
  String toString() {
    return 'UserSummary(id: $id, username: $username, name: $name, handle: $handle, actorUrl: $actorUrl, iconUrl: $iconUrl, isExternal: $isExternal, isOwn: $isOwn, isFollowing: $isFollowing)';
  }
}

/// @nodoc
abstract mixin class _$UserSummaryCopyWith<$Res>
    implements $UserSummaryCopyWith<$Res> {
  factory _$UserSummaryCopyWith(
          _UserSummary value, $Res Function(_UserSummary) _then) =
      __$UserSummaryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String username,
      String name,
      String handle,
      @JsonKey(name: 'actor_url') String? actorUrl,
      @JsonKey(name: 'icon_url') String? iconUrl,
      @JsonKey(name: 'is_external') bool isExternal,
      @JsonKey(name: 'is_own') bool isOwn,
      @JsonKey(name: 'is_following') bool isFollowing});
}

/// @nodoc
class __$UserSummaryCopyWithImpl<$Res> implements _$UserSummaryCopyWith<$Res> {
  __$UserSummaryCopyWithImpl(this._self, this._then);

  final _UserSummary _self;
  final $Res Function(_UserSummary) _then;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? username = null,
    Object? name = null,
    Object? handle = null,
    Object? actorUrl = freezed,
    Object? iconUrl = freezed,
    Object? isExternal = null,
    Object? isOwn = null,
    Object? isFollowing = null,
  }) {
    return _then(_UserSummary(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      handle: null == handle
          ? _self.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as String,
      actorUrl: freezed == actorUrl
          ? _self.actorUrl
          : actorUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      iconUrl: freezed == iconUrl
          ? _self.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isExternal: null == isExternal
          ? _self.isExternal
          : isExternal // ignore: cast_nullable_to_non_nullable
              as bool,
      isOwn: null == isOwn
          ? _self.isOwn
          : isOwn // ignore: cast_nullable_to_non_nullable
              as bool,
      isFollowing: null == isFollowing
          ? _self.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
