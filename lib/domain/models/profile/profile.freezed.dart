// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Profile {
  int? get id;
  String? get createdAt;
  String? get updatedAt; /* Whether the user's API key is active */
  @JsonKey(name: "api_active")
  bool get apiActive; /* The user's preferred directory for auto-import */
  @JsonKey(name: "auto_import_directory")
  String? get autoImportDirectory; /* The user's preferred language */
  String get language; /* Whether to show full dates in the workout details */
  @JsonKey(name: "prefer_full_date")
  bool get preferFullDate; /* The user's preferred units */
  UserPreferredUnits
      get preferredUnits; /* Whether social sharing buttons are disabled when viewing a workout */
  @JsonKey(name: "socials_disabled")
  bool get socialsDisabled; /* The user's preferred color scheme */
  String get theme; /* The user's preferred timezone */
  String get timezone; /* What workout type of totals to show */
  @JsonKey(name: "totals_show")
  WorkoutType get totalsShow; /* The ID of the user who owns this profile */
  int get userID;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<Profile> get copyWith =>
      _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Profile &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.apiActive, apiActive) ||
                other.apiActive == apiActive) &&
            (identical(other.autoImportDirectory, autoImportDirectory) ||
                other.autoImportDirectory == autoImportDirectory) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.preferFullDate, preferFullDate) ||
                other.preferFullDate == preferFullDate) &&
            (identical(other.preferredUnits, preferredUnits) ||
                other.preferredUnits == preferredUnits) &&
            (identical(other.socialsDisabled, socialsDisabled) ||
                other.socialsDisabled == socialsDisabled) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.totalsShow, totalsShow) ||
                other.totalsShow == totalsShow) &&
            (identical(other.userID, userID) || other.userID == userID));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      apiActive,
      autoImportDirectory,
      language,
      preferFullDate,
      preferredUnits,
      socialsDisabled,
      theme,
      timezone,
      totalsShow,
      userID);

  @override
  String toString() {
    return 'Profile(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, apiActive: $apiActive, autoImportDirectory: $autoImportDirectory, language: $language, preferFullDate: $preferFullDate, preferredUnits: $preferredUnits, socialsDisabled: $socialsDisabled, theme: $theme, timezone: $timezone, totalsShow: $totalsShow, userID: $userID)';
  }
}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) =
      _$ProfileCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String? createdAt,
      String? updatedAt,
      @JsonKey(name: "api_active") bool apiActive,
      @JsonKey(name: "auto_import_directory") String? autoImportDirectory,
      String language,
      @JsonKey(name: "prefer_full_date") bool preferFullDate,
      UserPreferredUnits preferredUnits,
      @JsonKey(name: "socials_disabled") bool socialsDisabled,
      String theme,
      String timezone,
      @JsonKey(name: "totals_show") WorkoutType totalsShow,
      int userID});

  $UserPreferredUnitsCopyWith<$Res> get preferredUnits;
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res> implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? apiActive = null,
    Object? autoImportDirectory = freezed,
    Object? language = null,
    Object? preferFullDate = null,
    Object? preferredUnits = null,
    Object? socialsDisabled = null,
    Object? theme = null,
    Object? timezone = null,
    Object? totalsShow = null,
    Object? userID = null,
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
      apiActive: null == apiActive
          ? _self.apiActive
          : apiActive // ignore: cast_nullable_to_non_nullable
              as bool,
      autoImportDirectory: freezed == autoImportDirectory
          ? _self.autoImportDirectory
          : autoImportDirectory // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      preferFullDate: null == preferFullDate
          ? _self.preferFullDate
          : preferFullDate // ignore: cast_nullable_to_non_nullable
              as bool,
      preferredUnits: null == preferredUnits
          ? _self.preferredUnits
          : preferredUnits // ignore: cast_nullable_to_non_nullable
              as UserPreferredUnits,
      socialsDisabled: null == socialsDisabled
          ? _self.socialsDisabled
          : socialsDisabled // ignore: cast_nullable_to_non_nullable
              as bool,
      theme: null == theme
          ? _self.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _self.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      totalsShow: null == totalsShow
          ? _self.totalsShow
          : totalsShow // ignore: cast_nullable_to_non_nullable
              as WorkoutType,
      userID: null == userID
          ? _self.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserPreferredUnitsCopyWith<$Res> get preferredUnits {
    return $UserPreferredUnitsCopyWith<$Res>(_self.preferredUnits, (value) {
      return _then(_self.copyWith(preferredUnits: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Profile].
extension ProfilePatterns on Profile {
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
    TResult Function(_Profile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Profile() when $default != null:
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
    TResult Function(_Profile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Profile():
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
    TResult? Function(_Profile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Profile() when $default != null:
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
            @JsonKey(name: "api_active") bool apiActive,
            @JsonKey(name: "auto_import_directory") String? autoImportDirectory,
            String language,
            @JsonKey(name: "prefer_full_date") bool preferFullDate,
            UserPreferredUnits preferredUnits,
            @JsonKey(name: "socials_disabled") bool socialsDisabled,
            String theme,
            String timezone,
            @JsonKey(name: "totals_show") WorkoutType totalsShow,
            int userID)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Profile() when $default != null:
        return $default(
            _that.id,
            _that.createdAt,
            _that.updatedAt,
            _that.apiActive,
            _that.autoImportDirectory,
            _that.language,
            _that.preferFullDate,
            _that.preferredUnits,
            _that.socialsDisabled,
            _that.theme,
            _that.timezone,
            _that.totalsShow,
            _that.userID);
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
            @JsonKey(name: "api_active") bool apiActive,
            @JsonKey(name: "auto_import_directory") String? autoImportDirectory,
            String language,
            @JsonKey(name: "prefer_full_date") bool preferFullDate,
            UserPreferredUnits preferredUnits,
            @JsonKey(name: "socials_disabled") bool socialsDisabled,
            String theme,
            String timezone,
            @JsonKey(name: "totals_show") WorkoutType totalsShow,
            int userID)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Profile():
        return $default(
            _that.id,
            _that.createdAt,
            _that.updatedAt,
            _that.apiActive,
            _that.autoImportDirectory,
            _that.language,
            _that.preferFullDate,
            _that.preferredUnits,
            _that.socialsDisabled,
            _that.theme,
            _that.timezone,
            _that.totalsShow,
            _that.userID);
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
            @JsonKey(name: "api_active") bool apiActive,
            @JsonKey(name: "auto_import_directory") String? autoImportDirectory,
            String language,
            @JsonKey(name: "prefer_full_date") bool preferFullDate,
            UserPreferredUnits preferredUnits,
            @JsonKey(name: "socials_disabled") bool socialsDisabled,
            String theme,
            String timezone,
            @JsonKey(name: "totals_show") WorkoutType totalsShow,
            int userID)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Profile() when $default != null:
        return $default(
            _that.id,
            _that.createdAt,
            _that.updatedAt,
            _that.apiActive,
            _that.autoImportDirectory,
            _that.language,
            _that.preferFullDate,
            _that.preferredUnits,
            _that.socialsDisabled,
            _that.theme,
            _that.timezone,
            _that.totalsShow,
            _that.userID);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Profile implements Profile {
  const _Profile(
      {this.id,
      this.createdAt,
      this.updatedAt,
      @JsonKey(name: "api_active") this.apiActive = false,
      @JsonKey(name: "auto_import_directory") this.autoImportDirectory = "",
      required this.language,
      @JsonKey(name: "prefer_full_date") this.preferFullDate = false,
      required this.preferredUnits,
      @JsonKey(name: "socials_disabled") this.socialsDisabled = false,
      required this.theme,
      required this.timezone,
      @JsonKey(name: "totals_show") required this.totalsShow,
      required this.userID});
  factory _Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  @override
  final int? id;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;
/* Whether the user's API key is active */
  @override
  @JsonKey(name: "api_active")
  final bool apiActive;
/* The user's preferred directory for auto-import */
  @override
  @JsonKey(name: "auto_import_directory")
  final String? autoImportDirectory;
/* The user's preferred language */
  @override
  final String language;
/* Whether to show full dates in the workout details */
  @override
  @JsonKey(name: "prefer_full_date")
  final bool preferFullDate;
/* The user's preferred units */
  @override
  final UserPreferredUnits preferredUnits;
/* Whether social sharing buttons are disabled when viewing a workout */
  @override
  @JsonKey(name: "socials_disabled")
  final bool socialsDisabled;
/* The user's preferred color scheme */
  @override
  final String theme;
/* The user's preferred timezone */
  @override
  final String timezone;
/* What workout type of totals to show */
  @override
  @JsonKey(name: "totals_show")
  final WorkoutType totalsShow;
/* The ID of the user who owns this profile */
  @override
  final int userID;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProfileCopyWith<_Profile> get copyWith =>
      __$ProfileCopyWithImpl<_Profile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProfileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Profile &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.apiActive, apiActive) ||
                other.apiActive == apiActive) &&
            (identical(other.autoImportDirectory, autoImportDirectory) ||
                other.autoImportDirectory == autoImportDirectory) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.preferFullDate, preferFullDate) ||
                other.preferFullDate == preferFullDate) &&
            (identical(other.preferredUnits, preferredUnits) ||
                other.preferredUnits == preferredUnits) &&
            (identical(other.socialsDisabled, socialsDisabled) ||
                other.socialsDisabled == socialsDisabled) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.totalsShow, totalsShow) ||
                other.totalsShow == totalsShow) &&
            (identical(other.userID, userID) || other.userID == userID));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      apiActive,
      autoImportDirectory,
      language,
      preferFullDate,
      preferredUnits,
      socialsDisabled,
      theme,
      timezone,
      totalsShow,
      userID);

  @override
  String toString() {
    return 'Profile(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, apiActive: $apiActive, autoImportDirectory: $autoImportDirectory, language: $language, preferFullDate: $preferFullDate, preferredUnits: $preferredUnits, socialsDisabled: $socialsDisabled, theme: $theme, timezone: $timezone, totalsShow: $totalsShow, userID: $userID)';
  }
}

/// @nodoc
abstract mixin class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) _then) =
      __$ProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String? createdAt,
      String? updatedAt,
      @JsonKey(name: "api_active") bool apiActive,
      @JsonKey(name: "auto_import_directory") String? autoImportDirectory,
      String language,
      @JsonKey(name: "prefer_full_date") bool preferFullDate,
      UserPreferredUnits preferredUnits,
      @JsonKey(name: "socials_disabled") bool socialsDisabled,
      String theme,
      String timezone,
      @JsonKey(name: "totals_show") WorkoutType totalsShow,
      int userID});

  @override
  $UserPreferredUnitsCopyWith<$Res> get preferredUnits;
}

/// @nodoc
class __$ProfileCopyWithImpl<$Res> implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(this._self, this._then);

  final _Profile _self;
  final $Res Function(_Profile) _then;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? apiActive = null,
    Object? autoImportDirectory = freezed,
    Object? language = null,
    Object? preferFullDate = null,
    Object? preferredUnits = null,
    Object? socialsDisabled = null,
    Object? theme = null,
    Object? timezone = null,
    Object? totalsShow = null,
    Object? userID = null,
  }) {
    return _then(_Profile(
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
      apiActive: null == apiActive
          ? _self.apiActive
          : apiActive // ignore: cast_nullable_to_non_nullable
              as bool,
      autoImportDirectory: freezed == autoImportDirectory
          ? _self.autoImportDirectory
          : autoImportDirectory // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      preferFullDate: null == preferFullDate
          ? _self.preferFullDate
          : preferFullDate // ignore: cast_nullable_to_non_nullable
              as bool,
      preferredUnits: null == preferredUnits
          ? _self.preferredUnits
          : preferredUnits // ignore: cast_nullable_to_non_nullable
              as UserPreferredUnits,
      socialsDisabled: null == socialsDisabled
          ? _self.socialsDisabled
          : socialsDisabled // ignore: cast_nullable_to_non_nullable
              as bool,
      theme: null == theme
          ? _self.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _self.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      totalsShow: null == totalsShow
          ? _self.totalsShow
          : totalsShow // ignore: cast_nullable_to_non_nullable
              as WorkoutType,
      userID: null == userID
          ? _self.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserPreferredUnitsCopyWith<$Res> get preferredUnits {
    return $UserPreferredUnitsCopyWith<$Res>(_self.preferredUnits, (value) {
      return _then(_self.copyWith(preferredUnits: value));
    });
  }
}

// dart format on
