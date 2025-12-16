// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_data_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapDataDetails {
  int? get id;
  String? get createdAt;
  String? get updatedAt; /* The ID of the map data these details belong to */
  int get mapDataID; /* The GPS points of the workout */
  List<MapPoint> get points;

  /// Create a copy of MapDataDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MapDataDetailsCopyWith<MapDataDetails> get copyWith =>
      _$MapDataDetailsCopyWithImpl<MapDataDetails>(
          this as MapDataDetails, _$identity);

  /// Serializes this MapDataDetails to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MapDataDetails &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.mapDataID, mapDataID) ||
                other.mapDataID == mapDataID) &&
            const DeepCollectionEquality().equals(other.points, points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt,
      mapDataID, const DeepCollectionEquality().hash(points));

  @override
  String toString() {
    return 'MapDataDetails(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, mapDataID: $mapDataID, points: $points)';
  }
}

/// @nodoc
abstract mixin class $MapDataDetailsCopyWith<$Res> {
  factory $MapDataDetailsCopyWith(
          MapDataDetails value, $Res Function(MapDataDetails) _then) =
      _$MapDataDetailsCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String? createdAt,
      String? updatedAt,
      int mapDataID,
      List<MapPoint> points});
}

/// @nodoc
class _$MapDataDetailsCopyWithImpl<$Res>
    implements $MapDataDetailsCopyWith<$Res> {
  _$MapDataDetailsCopyWithImpl(this._self, this._then);

  final MapDataDetails _self;
  final $Res Function(MapDataDetails) _then;

  /// Create a copy of MapDataDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? mapDataID = null,
    Object? points = null,
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
      mapDataID: null == mapDataID
          ? _self.mapDataID
          : mapDataID // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _self.points
          : points // ignore: cast_nullable_to_non_nullable
              as List<MapPoint>,
    ));
  }
}

/// Adds pattern-matching-related methods to [MapDataDetails].
extension MapDataDetailsPatterns on MapDataDetails {
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
    TResult Function(_MapDataDetails value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MapDataDetails() when $default != null:
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
    TResult Function(_MapDataDetails value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapDataDetails():
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
    TResult? Function(_MapDataDetails value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapDataDetails() when $default != null:
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
    TResult Function(int? id, String? createdAt, String? updatedAt,
            int mapDataID, List<MapPoint> points)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MapDataDetails() when $default != null:
        return $default(_that.id, _that.createdAt, _that.updatedAt,
            _that.mapDataID, _that.points);
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
    TResult Function(int? id, String? createdAt, String? updatedAt,
            int mapDataID, List<MapPoint> points)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapDataDetails():
        return $default(_that.id, _that.createdAt, _that.updatedAt,
            _that.mapDataID, _that.points);
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
    TResult? Function(int? id, String? createdAt, String? updatedAt,
            int mapDataID, List<MapPoint> points)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapDataDetails() when $default != null:
        return $default(_that.id, _that.createdAt, _that.updatedAt,
            _that.mapDataID, _that.points);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MapDataDetails implements MapDataDetails {
  const _MapDataDetails(
      {this.id,
      this.createdAt,
      this.updatedAt,
      required this.mapDataID,
      final List<MapPoint> points = const []})
      : _points = points;
  factory _MapDataDetails.fromJson(Map<String, dynamic> json) =>
      _$MapDataDetailsFromJson(json);

  @override
  final int? id;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;
/* The ID of the map data these details belong to */
  @override
  final int mapDataID;
/* The GPS points of the workout */
  final List<MapPoint> _points;
/* The GPS points of the workout */
  @override
  @JsonKey()
  List<MapPoint> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  /// Create a copy of MapDataDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MapDataDetailsCopyWith<_MapDataDetails> get copyWith =>
      __$MapDataDetailsCopyWithImpl<_MapDataDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MapDataDetailsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MapDataDetails &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.mapDataID, mapDataID) ||
                other.mapDataID == mapDataID) &&
            const DeepCollectionEquality().equals(other._points, _points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt,
      mapDataID, const DeepCollectionEquality().hash(_points));

  @override
  String toString() {
    return 'MapDataDetails(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, mapDataID: $mapDataID, points: $points)';
  }
}

/// @nodoc
abstract mixin class _$MapDataDetailsCopyWith<$Res>
    implements $MapDataDetailsCopyWith<$Res> {
  factory _$MapDataDetailsCopyWith(
          _MapDataDetails value, $Res Function(_MapDataDetails) _then) =
      __$MapDataDetailsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String? createdAt,
      String? updatedAt,
      int mapDataID,
      List<MapPoint> points});
}

/// @nodoc
class __$MapDataDetailsCopyWithImpl<$Res>
    implements _$MapDataDetailsCopyWith<$Res> {
  __$MapDataDetailsCopyWithImpl(this._self, this._then);

  final _MapDataDetails _self;
  final $Res Function(_MapDataDetails) _then;

  /// Create a copy of MapDataDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? mapDataID = null,
    Object? points = null,
  }) {
    return _then(_MapDataDetails(
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
      mapDataID: null == mapDataID
          ? _self.mapDataID
          : mapDataID // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _self._points
          : points // ignore: cast_nullable_to_non_nullable
              as List<MapPoint>,
    ));
  }
}

// dart format on
