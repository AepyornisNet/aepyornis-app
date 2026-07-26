// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_attachment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutAttachment {
  int? get id;
  String? get kind;
  String? get filename;
  @JsonKey(name: 'content_type')
  String? get contentType;
  int? get order;
  String? get url;

  /// Create a copy of WorkoutAttachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutAttachmentCopyWith<WorkoutAttachment> get copyWith =>
      _$WorkoutAttachmentCopyWithImpl<WorkoutAttachment>(
          this as WorkoutAttachment, _$identity);

  /// Serializes this WorkoutAttachment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutAttachment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, kind, filename, contentType, order, url);

  @override
  String toString() {
    return 'WorkoutAttachment(id: $id, kind: $kind, filename: $filename, contentType: $contentType, order: $order, url: $url)';
  }
}

/// @nodoc
abstract mixin class $WorkoutAttachmentCopyWith<$Res> {
  factory $WorkoutAttachmentCopyWith(
          WorkoutAttachment value, $Res Function(WorkoutAttachment) _then) =
      _$WorkoutAttachmentCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String? kind,
      String? filename,
      @JsonKey(name: 'content_type') String? contentType,
      int? order,
      String? url});
}

/// @nodoc
class _$WorkoutAttachmentCopyWithImpl<$Res>
    implements $WorkoutAttachmentCopyWith<$Res> {
  _$WorkoutAttachmentCopyWithImpl(this._self, this._then);

  final WorkoutAttachment _self;
  final $Res Function(WorkoutAttachment) _then;

  /// Create a copy of WorkoutAttachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? kind = freezed,
    Object? filename = freezed,
    Object? contentType = freezed,
    Object? order = freezed,
    Object? url = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      kind: freezed == kind
          ? _self.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String?,
      filename: freezed == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      contentType: freezed == contentType
          ? _self.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [WorkoutAttachment].
extension WorkoutAttachmentPatterns on WorkoutAttachment {
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
    TResult Function(_WorkoutAttachment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutAttachment() when $default != null:
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
    TResult Function(_WorkoutAttachment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutAttachment():
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
    TResult? Function(_WorkoutAttachment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutAttachment() when $default != null:
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
            String? kind,
            String? filename,
            @JsonKey(name: 'content_type') String? contentType,
            int? order,
            String? url)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutAttachment() when $default != null:
        return $default(_that.id, _that.kind, _that.filename, _that.contentType,
            _that.order, _that.url);
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
            String? kind,
            String? filename,
            @JsonKey(name: 'content_type') String? contentType,
            int? order,
            String? url)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutAttachment():
        return $default(_that.id, _that.kind, _that.filename, _that.contentType,
            _that.order, _that.url);
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
            String? kind,
            String? filename,
            @JsonKey(name: 'content_type') String? contentType,
            int? order,
            String? url)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutAttachment() when $default != null:
        return $default(_that.id, _that.kind, _that.filename, _that.contentType,
            _that.order, _that.url);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkoutAttachment implements WorkoutAttachment {
  const _WorkoutAttachment(
      {this.id,
      this.kind,
      this.filename,
      @JsonKey(name: 'content_type') this.contentType,
      this.order,
      this.url});
  factory _WorkoutAttachment.fromJson(Map<String, dynamic> json) =>
      _$WorkoutAttachmentFromJson(json);

  @override
  final int? id;
  @override
  final String? kind;
  @override
  final String? filename;
  @override
  @JsonKey(name: 'content_type')
  final String? contentType;
  @override
  final int? order;
  @override
  final String? url;

  /// Create a copy of WorkoutAttachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutAttachmentCopyWith<_WorkoutAttachment> get copyWith =>
      __$WorkoutAttachmentCopyWithImpl<_WorkoutAttachment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkoutAttachmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutAttachment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, kind, filename, contentType, order, url);

  @override
  String toString() {
    return 'WorkoutAttachment(id: $id, kind: $kind, filename: $filename, contentType: $contentType, order: $order, url: $url)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutAttachmentCopyWith<$Res>
    implements $WorkoutAttachmentCopyWith<$Res> {
  factory _$WorkoutAttachmentCopyWith(
          _WorkoutAttachment value, $Res Function(_WorkoutAttachment) _then) =
      __$WorkoutAttachmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String? kind,
      String? filename,
      @JsonKey(name: 'content_type') String? contentType,
      int? order,
      String? url});
}

/// @nodoc
class __$WorkoutAttachmentCopyWithImpl<$Res>
    implements _$WorkoutAttachmentCopyWith<$Res> {
  __$WorkoutAttachmentCopyWithImpl(this._self, this._then);

  final _WorkoutAttachment _self;
  final $Res Function(_WorkoutAttachment) _then;

  /// Create a copy of WorkoutAttachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? kind = freezed,
    Object? filename = freezed,
    Object? contentType = freezed,
    Object? order = freezed,
    Object? url = freezed,
  }) {
    return _then(_WorkoutAttachment(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      kind: freezed == kind
          ? _self.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String?,
      filename: freezed == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      contentType: freezed == contentType
          ? _self.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
