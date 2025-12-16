// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapData {
  MapCenter? get center;
  String? get creator;
  @JsonKey(name: 'extra_metrics')
  List<String> get extraMetrics;
  MapDataDetails? get details;

  /// Create a copy of MapData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MapDataCopyWith<MapData> get copyWith =>
      _$MapDataCopyWithImpl<MapData>(this as MapData, _$identity);

  /// Serializes this MapData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MapData &&
            (identical(other.center, center) || other.center == center) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            const DeepCollectionEquality()
                .equals(other.extraMetrics, extraMetrics) &&
            (identical(other.details, details) || other.details == details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, center, creator,
      const DeepCollectionEquality().hash(extraMetrics), details);

  @override
  String toString() {
    return 'MapData(center: $center, creator: $creator, extraMetrics: $extraMetrics, details: $details)';
  }
}

/// @nodoc
abstract mixin class $MapDataCopyWith<$Res> {
  factory $MapDataCopyWith(MapData value, $Res Function(MapData) _then) =
      _$MapDataCopyWithImpl;
  @useResult
  $Res call(
      {MapCenter? center,
      String? creator,
      @JsonKey(name: 'extra_metrics') List<String> extraMetrics,
      MapDataDetails? details});

  $MapCenterCopyWith<$Res>? get center;
  $MapDataDetailsCopyWith<$Res>? get details;
}

/// @nodoc
class _$MapDataCopyWithImpl<$Res> implements $MapDataCopyWith<$Res> {
  _$MapDataCopyWithImpl(this._self, this._then);

  final MapData _self;
  final $Res Function(MapData) _then;

  /// Create a copy of MapData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? center = freezed,
    Object? creator = freezed,
    Object? extraMetrics = null,
    Object? details = freezed,
  }) {
    return _then(_self.copyWith(
      center: freezed == center
          ? _self.center
          : center // ignore: cast_nullable_to_non_nullable
              as MapCenter?,
      creator: freezed == creator
          ? _self.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String?,
      extraMetrics: null == extraMetrics
          ? _self.extraMetrics
          : extraMetrics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      details: freezed == details
          ? _self.details
          : details // ignore: cast_nullable_to_non_nullable
              as MapDataDetails?,
    ));
  }

  /// Create a copy of MapData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapCenterCopyWith<$Res>? get center {
    if (_self.center == null) {
      return null;
    }

    return $MapCenterCopyWith<$Res>(_self.center!, (value) {
      return _then(_self.copyWith(center: value));
    });
  }

  /// Create a copy of MapData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapDataDetailsCopyWith<$Res>? get details {
    if (_self.details == null) {
      return null;
    }

    return $MapDataDetailsCopyWith<$Res>(_self.details!, (value) {
      return _then(_self.copyWith(details: value));
    });
  }
}

/// Adds pattern-matching-related methods to [MapData].
extension MapDataPatterns on MapData {
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
    TResult Function(_MapData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MapData() when $default != null:
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
    TResult Function(_MapData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapData():
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
    TResult? Function(_MapData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapData() when $default != null:
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
            MapCenter? center,
            String? creator,
            @JsonKey(name: 'extra_metrics') List<String> extraMetrics,
            MapDataDetails? details)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MapData() when $default != null:
        return $default(
            _that.center, _that.creator, _that.extraMetrics, _that.details);
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
            MapCenter? center,
            String? creator,
            @JsonKey(name: 'extra_metrics') List<String> extraMetrics,
            MapDataDetails? details)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapData():
        return $default(
            _that.center, _that.creator, _that.extraMetrics, _that.details);
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
            MapCenter? center,
            String? creator,
            @JsonKey(name: 'extra_metrics') List<String> extraMetrics,
            MapDataDetails? details)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapData() when $default != null:
        return $default(
            _that.center, _that.creator, _that.extraMetrics, _that.details);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MapData implements MapData {
  const _MapData(
      {this.center,
      this.creator,
      @JsonKey(name: 'extra_metrics')
      final List<String> extraMetrics = const [],
      this.details})
      : _extraMetrics = extraMetrics;
  factory _MapData.fromJson(Map<String, dynamic> json) =>
      _$MapDataFromJson(json);

  @override
  final MapCenter? center;
  @override
  final String? creator;
  final List<String> _extraMetrics;
  @override
  @JsonKey(name: 'extra_metrics')
  List<String> get extraMetrics {
    if (_extraMetrics is EqualUnmodifiableListView) return _extraMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_extraMetrics);
  }

  @override
  final MapDataDetails? details;

  /// Create a copy of MapData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MapDataCopyWith<_MapData> get copyWith =>
      __$MapDataCopyWithImpl<_MapData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MapDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MapData &&
            (identical(other.center, center) || other.center == center) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            const DeepCollectionEquality()
                .equals(other._extraMetrics, _extraMetrics) &&
            (identical(other.details, details) || other.details == details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, center, creator,
      const DeepCollectionEquality().hash(_extraMetrics), details);

  @override
  String toString() {
    return 'MapData(center: $center, creator: $creator, extraMetrics: $extraMetrics, details: $details)';
  }
}

/// @nodoc
abstract mixin class _$MapDataCopyWith<$Res> implements $MapDataCopyWith<$Res> {
  factory _$MapDataCopyWith(_MapData value, $Res Function(_MapData) _then) =
      __$MapDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {MapCenter? center,
      String? creator,
      @JsonKey(name: 'extra_metrics') List<String> extraMetrics,
      MapDataDetails? details});

  @override
  $MapCenterCopyWith<$Res>? get center;
  @override
  $MapDataDetailsCopyWith<$Res>? get details;
}

/// @nodoc
class __$MapDataCopyWithImpl<$Res> implements _$MapDataCopyWith<$Res> {
  __$MapDataCopyWithImpl(this._self, this._then);

  final _MapData _self;
  final $Res Function(_MapData) _then;

  /// Create a copy of MapData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? center = freezed,
    Object? creator = freezed,
    Object? extraMetrics = null,
    Object? details = freezed,
  }) {
    return _then(_MapData(
      center: freezed == center
          ? _self.center
          : center // ignore: cast_nullable_to_non_nullable
              as MapCenter?,
      creator: freezed == creator
          ? _self.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String?,
      extraMetrics: null == extraMetrics
          ? _self._extraMetrics
          : extraMetrics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      details: freezed == details
          ? _self.details
          : details // ignore: cast_nullable_to_non_nullable
              as MapDataDetails?,
    ));
  }

  /// Create a copy of MapData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapCenterCopyWith<$Res>? get center {
    if (_self.center == null) {
      return null;
    }

    return $MapCenterCopyWith<$Res>(_self.center!, (value) {
      return _then(_self.copyWith(center: value));
    });
  }

  /// Create a copy of MapData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapDataDetailsCopyWith<$Res>? get details {
    if (_self.details == null) {
      return null;
    }

    return $MapDataDetailsCopyWith<$Res>(_self.details!, (value) {
      return _then(_self.copyWith(details: value));
    });
  }
}

// dart format on
