// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Workout {
  @JsonKey(name: 'id')
  int? get id;
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// The ID of the user who owns the workout
  @JsonKey(name: 'user_id')
  int? get userID;

  /// The owner user of the workout
  User? get user;

  /// The timestamp the workout was recorded
  DateTime get date;

  /// Whether the workout has been modified and the details should be re-rendered
  bool? get dirty;

  /// Which equipment is used for this workout
  @JsonKey(name: 'equipment')
  List<Equipment> get equipment;

  /// The map data associated with the workout
  @JsonKey(name: 'map_data')
  MapData? get data;

  /// The name of the workout
  String get name;

  /// The notes associated with the workout, in markdown
  String get notes;

  /// UUID to publicly share a workout - this UUID can be rotated
  @JsonKey(name: 'public_uuid')
  String? get publicUUID;

  /// Optional custom workout type descriptors
  @JsonKey(name: 'custom_type')
  String? get customType;
  @JsonKey(name: 'sub_type')
  String? get subType;
  @JsonKey(name: 'type')
  WorkoutType get type;
  @JsonKey(name: 'visibility')
  String? get visibility;
  @JsonKey(name: 'locked')
  bool get locked;
  @JsonKey(name: 'has_file')
  bool get hasFile;
  @JsonKey(name: 'has_tracks')
  bool get hasTracks;
  @JsonKey(name: 'address_string')
  String? get addressString;
  @JsonKey(name: 'total_distance')
  double get totalDistance;
  @JsonKey(name: 'total_duration')
  int get totalDuration;
  @JsonKey(name: 'pause_duration')
  int get pauseDuration;
  @JsonKey(name: 'total_weight')
  double get totalWeight;
  @JsonKey(name: 'total_repetitions')
  int get totalRepetitions;
  @JsonKey(name: 'total_up')
  double get totalUp;
  @JsonKey(name: 'total_down')
  double get totalDown;
  @JsonKey(name: 'average_speed')
  double get averageSpeed;
  @JsonKey(name: 'average_speed_no_pause')
  double get averageSpeedNoPause;
  @JsonKey(name: 'max_speed')
  double get maxSpeed;
  @JsonKey(name: 'min_elevation')
  double get minElevation;
  @JsonKey(name: 'max_elevation')
  double get maxElevation;
  @JsonKey(name: 'average_cadence')
  double? get averageCadence;
  @JsonKey(name: 'max_cadence')
  double? get maxCadence;
  @JsonKey(name: 'average_heart_rate')
  double? get averageHeartRate;
  @JsonKey(name: 'max_heart_rate')
  double? get maxHeartRate;
  @JsonKey(name: 'average_power')
  double? get averagePower;
  @JsonKey(name: 'max_power')
  double? get maxPower;
  @JsonKey(name: 'liked_by_me')
  bool get likedByMe;
  @JsonKey(name: 'likes_count')
  int get likesCount;
  @JsonKey(name: 'replies_count')
  int get repliesCount;
  @JsonKey(name: 'interval_bests')
  List<Map<String, dynamic>> get intervalBests;
  @JsonKey(name: 'climbs')
  List<Map<String, dynamic>> get climbs;
  List<WorkoutAttachment> get attachments;

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutCopyWith<Workout> get copyWith =>
      _$WorkoutCopyWithImpl<Workout>(this as Workout, _$identity);

  /// Serializes this Workout to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Workout &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.dirty, dirty) || other.dirty == dirty) &&
            const DeepCollectionEquality().equals(other.equipment, equipment) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.publicUUID, publicUUID) ||
                other.publicUUID == publicUUID) &&
            (identical(other.customType, customType) ||
                other.customType == customType) &&
            (identical(other.subType, subType) || other.subType == subType) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.locked, locked) || other.locked == locked) &&
            (identical(other.hasFile, hasFile) || other.hasFile == hasFile) &&
            (identical(other.hasTracks, hasTracks) ||
                other.hasTracks == hasTracks) &&
            (identical(other.addressString, addressString) ||
                other.addressString == addressString) &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance) &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration) &&
            (identical(other.pauseDuration, pauseDuration) ||
                other.pauseDuration == pauseDuration) &&
            (identical(other.totalWeight, totalWeight) ||
                other.totalWeight == totalWeight) &&
            (identical(other.totalRepetitions, totalRepetitions) ||
                other.totalRepetitions == totalRepetitions) &&
            (identical(other.totalUp, totalUp) || other.totalUp == totalUp) &&
            (identical(other.totalDown, totalDown) ||
                other.totalDown == totalDown) &&
            (identical(other.averageSpeed, averageSpeed) ||
                other.averageSpeed == averageSpeed) &&
            (identical(other.averageSpeedNoPause, averageSpeedNoPause) ||
                other.averageSpeedNoPause == averageSpeedNoPause) &&
            (identical(other.maxSpeed, maxSpeed) ||
                other.maxSpeed == maxSpeed) &&
            (identical(other.minElevation, minElevation) ||
                other.minElevation == minElevation) &&
            (identical(other.maxElevation, maxElevation) ||
                other.maxElevation == maxElevation) &&
            (identical(other.averageCadence, averageCadence) ||
                other.averageCadence == averageCadence) &&
            (identical(other.maxCadence, maxCadence) ||
                other.maxCadence == maxCadence) &&
            (identical(other.averageHeartRate, averageHeartRate) ||
                other.averageHeartRate == averageHeartRate) &&
            (identical(other.maxHeartRate, maxHeartRate) ||
                other.maxHeartRate == maxHeartRate) &&
            (identical(other.averagePower, averagePower) ||
                other.averagePower == averagePower) &&
            (identical(other.maxPower, maxPower) ||
                other.maxPower == maxPower) &&
            (identical(other.likedByMe, likedByMe) ||
                other.likedByMe == likedByMe) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.repliesCount, repliesCount) ||
                other.repliesCount == repliesCount) &&
            const DeepCollectionEquality()
                .equals(other.intervalBests, intervalBests) &&
            const DeepCollectionEquality().equals(other.climbs, climbs) &&
            const DeepCollectionEquality()
                .equals(other.attachments, attachments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        createdAt,
        updatedAt,
        userID,
        user,
        date,
        dirty,
        const DeepCollectionEquality().hash(equipment),
        data,
        name,
        notes,
        publicUUID,
        customType,
        subType,
        type,
        visibility,
        locked,
        hasFile,
        hasTracks,
        addressString,
        totalDistance,
        totalDuration,
        pauseDuration,
        totalWeight,
        totalRepetitions,
        totalUp,
        totalDown,
        averageSpeed,
        averageSpeedNoPause,
        maxSpeed,
        minElevation,
        maxElevation,
        averageCadence,
        maxCadence,
        averageHeartRate,
        maxHeartRate,
        averagePower,
        maxPower,
        likedByMe,
        likesCount,
        repliesCount,
        const DeepCollectionEquality().hash(intervalBests),
        const DeepCollectionEquality().hash(climbs),
        const DeepCollectionEquality().hash(attachments)
      ]);

  @override
  String toString() {
    return 'Workout(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, userID: $userID, user: $user, date: $date, dirty: $dirty, equipment: $equipment, data: $data, name: $name, notes: $notes, publicUUID: $publicUUID, customType: $customType, subType: $subType, type: $type, visibility: $visibility, locked: $locked, hasFile: $hasFile, hasTracks: $hasTracks, addressString: $addressString, totalDistance: $totalDistance, totalDuration: $totalDuration, pauseDuration: $pauseDuration, totalWeight: $totalWeight, totalRepetitions: $totalRepetitions, totalUp: $totalUp, totalDown: $totalDown, averageSpeed: $averageSpeed, averageSpeedNoPause: $averageSpeedNoPause, maxSpeed: $maxSpeed, minElevation: $minElevation, maxElevation: $maxElevation, averageCadence: $averageCadence, maxCadence: $maxCadence, averageHeartRate: $averageHeartRate, maxHeartRate: $maxHeartRate, averagePower: $averagePower, maxPower: $maxPower, likedByMe: $likedByMe, likesCount: $likesCount, repliesCount: $repliesCount, intervalBests: $intervalBests, climbs: $climbs, attachments: $attachments)';
  }
}

/// @nodoc
abstract mixin class $WorkoutCopyWith<$Res> {
  factory $WorkoutCopyWith(Workout value, $Res Function(Workout) _then) =
      _$WorkoutCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'user_id') int? userID,
      User? user,
      DateTime date,
      bool? dirty,
      @JsonKey(name: 'equipment') List<Equipment> equipment,
      @JsonKey(name: 'map_data') MapData? data,
      String name,
      String notes,
      @JsonKey(name: 'public_uuid') String? publicUUID,
      @JsonKey(name: 'custom_type') String? customType,
      @JsonKey(name: 'sub_type') String? subType,
      @JsonKey(name: 'type') WorkoutType type,
      @JsonKey(name: 'visibility') String? visibility,
      @JsonKey(name: 'locked') bool locked,
      @JsonKey(name: 'has_file') bool hasFile,
      @JsonKey(name: 'has_tracks') bool hasTracks,
      @JsonKey(name: 'address_string') String? addressString,
      @JsonKey(name: 'total_distance') double totalDistance,
      @JsonKey(name: 'total_duration') int totalDuration,
      @JsonKey(name: 'pause_duration') int pauseDuration,
      @JsonKey(name: 'total_weight') double totalWeight,
      @JsonKey(name: 'total_repetitions') int totalRepetitions,
      @JsonKey(name: 'total_up') double totalUp,
      @JsonKey(name: 'total_down') double totalDown,
      @JsonKey(name: 'average_speed') double averageSpeed,
      @JsonKey(name: 'average_speed_no_pause') double averageSpeedNoPause,
      @JsonKey(name: 'max_speed') double maxSpeed,
      @JsonKey(name: 'min_elevation') double minElevation,
      @JsonKey(name: 'max_elevation') double maxElevation,
      @JsonKey(name: 'average_cadence') double? averageCadence,
      @JsonKey(name: 'max_cadence') double? maxCadence,
      @JsonKey(name: 'average_heart_rate') double? averageHeartRate,
      @JsonKey(name: 'max_heart_rate') double? maxHeartRate,
      @JsonKey(name: 'average_power') double? averagePower,
      @JsonKey(name: 'max_power') double? maxPower,
      @JsonKey(name: 'liked_by_me') bool likedByMe,
      @JsonKey(name: 'likes_count') int likesCount,
      @JsonKey(name: 'replies_count') int repliesCount,
      @JsonKey(name: 'interval_bests') List<Map<String, dynamic>> intervalBests,
      @JsonKey(name: 'climbs') List<Map<String, dynamic>> climbs,
      List<WorkoutAttachment> attachments});

  $UserCopyWith<$Res>? get user;
  $MapDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$WorkoutCopyWithImpl<$Res> implements $WorkoutCopyWith<$Res> {
  _$WorkoutCopyWithImpl(this._self, this._then);

  final Workout _self;
  final $Res Function(Workout) _then;

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? userID = freezed,
    Object? user = freezed,
    Object? date = null,
    Object? dirty = freezed,
    Object? equipment = null,
    Object? data = freezed,
    Object? name = null,
    Object? notes = null,
    Object? publicUUID = freezed,
    Object? customType = freezed,
    Object? subType = freezed,
    Object? type = null,
    Object? visibility = freezed,
    Object? locked = null,
    Object? hasFile = null,
    Object? hasTracks = null,
    Object? addressString = freezed,
    Object? totalDistance = null,
    Object? totalDuration = null,
    Object? pauseDuration = null,
    Object? totalWeight = null,
    Object? totalRepetitions = null,
    Object? totalUp = null,
    Object? totalDown = null,
    Object? averageSpeed = null,
    Object? averageSpeedNoPause = null,
    Object? maxSpeed = null,
    Object? minElevation = null,
    Object? maxElevation = null,
    Object? averageCadence = freezed,
    Object? maxCadence = freezed,
    Object? averageHeartRate = freezed,
    Object? maxHeartRate = freezed,
    Object? averagePower = freezed,
    Object? maxPower = freezed,
    Object? likedByMe = null,
    Object? likesCount = null,
    Object? repliesCount = null,
    Object? intervalBests = null,
    Object? climbs = null,
    Object? attachments = null,
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
      userID: freezed == userID
          ? _self.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dirty: freezed == dirty
          ? _self.dirty
          : dirty // ignore: cast_nullable_to_non_nullable
              as bool?,
      equipment: null == equipment
          ? _self.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<Equipment>,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as MapData?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      publicUUID: freezed == publicUUID
          ? _self.publicUUID
          : publicUUID // ignore: cast_nullable_to_non_nullable
              as String?,
      customType: freezed == customType
          ? _self.customType
          : customType // ignore: cast_nullable_to_non_nullable
              as String?,
      subType: freezed == subType
          ? _self.subType
          : subType // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorkoutType,
      visibility: freezed == visibility
          ? _self.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String?,
      locked: null == locked
          ? _self.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      hasFile: null == hasFile
          ? _self.hasFile
          : hasFile // ignore: cast_nullable_to_non_nullable
              as bool,
      hasTracks: null == hasTracks
          ? _self.hasTracks
          : hasTracks // ignore: cast_nullable_to_non_nullable
              as bool,
      addressString: freezed == addressString
          ? _self.addressString
          : addressString // ignore: cast_nullable_to_non_nullable
              as String?,
      totalDistance: null == totalDistance
          ? _self.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      totalDuration: null == totalDuration
          ? _self.totalDuration
          : totalDuration // ignore: cast_nullable_to_non_nullable
              as int,
      pauseDuration: null == pauseDuration
          ? _self.pauseDuration
          : pauseDuration // ignore: cast_nullable_to_non_nullable
              as int,
      totalWeight: null == totalWeight
          ? _self.totalWeight
          : totalWeight // ignore: cast_nullable_to_non_nullable
              as double,
      totalRepetitions: null == totalRepetitions
          ? _self.totalRepetitions
          : totalRepetitions // ignore: cast_nullable_to_non_nullable
              as int,
      totalUp: null == totalUp
          ? _self.totalUp
          : totalUp // ignore: cast_nullable_to_non_nullable
              as double,
      totalDown: null == totalDown
          ? _self.totalDown
          : totalDown // ignore: cast_nullable_to_non_nullable
              as double,
      averageSpeed: null == averageSpeed
          ? _self.averageSpeed
          : averageSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      averageSpeedNoPause: null == averageSpeedNoPause
          ? _self.averageSpeedNoPause
          : averageSpeedNoPause // ignore: cast_nullable_to_non_nullable
              as double,
      maxSpeed: null == maxSpeed
          ? _self.maxSpeed
          : maxSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      minElevation: null == minElevation
          ? _self.minElevation
          : minElevation // ignore: cast_nullable_to_non_nullable
              as double,
      maxElevation: null == maxElevation
          ? _self.maxElevation
          : maxElevation // ignore: cast_nullable_to_non_nullable
              as double,
      averageCadence: freezed == averageCadence
          ? _self.averageCadence
          : averageCadence // ignore: cast_nullable_to_non_nullable
              as double?,
      maxCadence: freezed == maxCadence
          ? _self.maxCadence
          : maxCadence // ignore: cast_nullable_to_non_nullable
              as double?,
      averageHeartRate: freezed == averageHeartRate
          ? _self.averageHeartRate
          : averageHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      maxHeartRate: freezed == maxHeartRate
          ? _self.maxHeartRate
          : maxHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      averagePower: freezed == averagePower
          ? _self.averagePower
          : averagePower // ignore: cast_nullable_to_non_nullable
              as double?,
      maxPower: freezed == maxPower
          ? _self.maxPower
          : maxPower // ignore: cast_nullable_to_non_nullable
              as double?,
      likedByMe: null == likedByMe
          ? _self.likedByMe
          : likedByMe // ignore: cast_nullable_to_non_nullable
              as bool,
      likesCount: null == likesCount
          ? _self.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      repliesCount: null == repliesCount
          ? _self.repliesCount
          : repliesCount // ignore: cast_nullable_to_non_nullable
              as int,
      intervalBests: null == intervalBests
          ? _self.intervalBests
          : intervalBests // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      climbs: null == climbs
          ? _self.climbs
          : climbs // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      attachments: null == attachments
          ? _self.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<WorkoutAttachment>,
    ));
  }

  /// Create a copy of Workout
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

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapDataCopyWith<$Res>? get data {
    if (_self.data == null) {
      return null;
    }

    return $MapDataCopyWith<$Res>(_self.data!, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Workout].
extension WorkoutPatterns on Workout {
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
    TResult Function(_Workout value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Workout() when $default != null:
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
    TResult Function(_Workout value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Workout():
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
    TResult? Function(_Workout value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Workout() when $default != null:
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
            @JsonKey(name: 'id') int? id,
            @JsonKey(name: 'created_at') String? createdAt,
            @JsonKey(name: 'updated_at') String? updatedAt,
            @JsonKey(name: 'user_id') int? userID,
            User? user,
            DateTime date,
            bool? dirty,
            @JsonKey(name: 'equipment') List<Equipment> equipment,
            @JsonKey(name: 'map_data') MapData? data,
            String name,
            String notes,
            @JsonKey(name: 'public_uuid') String? publicUUID,
            @JsonKey(name: 'custom_type') String? customType,
            @JsonKey(name: 'sub_type') String? subType,
            @JsonKey(name: 'type') WorkoutType type,
            @JsonKey(name: 'visibility') String? visibility,
            @JsonKey(name: 'locked') bool locked,
            @JsonKey(name: 'has_file') bool hasFile,
            @JsonKey(name: 'has_tracks') bool hasTracks,
            @JsonKey(name: 'address_string') String? addressString,
            @JsonKey(name: 'total_distance') double totalDistance,
            @JsonKey(name: 'total_duration') int totalDuration,
            @JsonKey(name: 'pause_duration') int pauseDuration,
            @JsonKey(name: 'total_weight') double totalWeight,
            @JsonKey(name: 'total_repetitions') int totalRepetitions,
            @JsonKey(name: 'total_up') double totalUp,
            @JsonKey(name: 'total_down') double totalDown,
            @JsonKey(name: 'average_speed') double averageSpeed,
            @JsonKey(name: 'average_speed_no_pause') double averageSpeedNoPause,
            @JsonKey(name: 'max_speed') double maxSpeed,
            @JsonKey(name: 'min_elevation') double minElevation,
            @JsonKey(name: 'max_elevation') double maxElevation,
            @JsonKey(name: 'average_cadence') double? averageCadence,
            @JsonKey(name: 'max_cadence') double? maxCadence,
            @JsonKey(name: 'average_heart_rate') double? averageHeartRate,
            @JsonKey(name: 'max_heart_rate') double? maxHeartRate,
            @JsonKey(name: 'average_power') double? averagePower,
            @JsonKey(name: 'max_power') double? maxPower,
            @JsonKey(name: 'liked_by_me') bool likedByMe,
            @JsonKey(name: 'likes_count') int likesCount,
            @JsonKey(name: 'replies_count') int repliesCount,
            @JsonKey(name: 'interval_bests')
            List<Map<String, dynamic>> intervalBests,
            @JsonKey(name: 'climbs') List<Map<String, dynamic>> climbs,
            List<WorkoutAttachment> attachments)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Workout() when $default != null:
        return $default(
            _that.id,
            _that.createdAt,
            _that.updatedAt,
            _that.userID,
            _that.user,
            _that.date,
            _that.dirty,
            _that.equipment,
            _that.data,
            _that.name,
            _that.notes,
            _that.publicUUID,
            _that.customType,
            _that.subType,
            _that.type,
            _that.visibility,
            _that.locked,
            _that.hasFile,
            _that.hasTracks,
            _that.addressString,
            _that.totalDistance,
            _that.totalDuration,
            _that.pauseDuration,
            _that.totalWeight,
            _that.totalRepetitions,
            _that.totalUp,
            _that.totalDown,
            _that.averageSpeed,
            _that.averageSpeedNoPause,
            _that.maxSpeed,
            _that.minElevation,
            _that.maxElevation,
            _that.averageCadence,
            _that.maxCadence,
            _that.averageHeartRate,
            _that.maxHeartRate,
            _that.averagePower,
            _that.maxPower,
            _that.likedByMe,
            _that.likesCount,
            _that.repliesCount,
            _that.intervalBests,
            _that.climbs,
            _that.attachments);
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
            @JsonKey(name: 'id') int? id,
            @JsonKey(name: 'created_at') String? createdAt,
            @JsonKey(name: 'updated_at') String? updatedAt,
            @JsonKey(name: 'user_id') int? userID,
            User? user,
            DateTime date,
            bool? dirty,
            @JsonKey(name: 'equipment') List<Equipment> equipment,
            @JsonKey(name: 'map_data') MapData? data,
            String name,
            String notes,
            @JsonKey(name: 'public_uuid') String? publicUUID,
            @JsonKey(name: 'custom_type') String? customType,
            @JsonKey(name: 'sub_type') String? subType,
            @JsonKey(name: 'type') WorkoutType type,
            @JsonKey(name: 'visibility') String? visibility,
            @JsonKey(name: 'locked') bool locked,
            @JsonKey(name: 'has_file') bool hasFile,
            @JsonKey(name: 'has_tracks') bool hasTracks,
            @JsonKey(name: 'address_string') String? addressString,
            @JsonKey(name: 'total_distance') double totalDistance,
            @JsonKey(name: 'total_duration') int totalDuration,
            @JsonKey(name: 'pause_duration') int pauseDuration,
            @JsonKey(name: 'total_weight') double totalWeight,
            @JsonKey(name: 'total_repetitions') int totalRepetitions,
            @JsonKey(name: 'total_up') double totalUp,
            @JsonKey(name: 'total_down') double totalDown,
            @JsonKey(name: 'average_speed') double averageSpeed,
            @JsonKey(name: 'average_speed_no_pause') double averageSpeedNoPause,
            @JsonKey(name: 'max_speed') double maxSpeed,
            @JsonKey(name: 'min_elevation') double minElevation,
            @JsonKey(name: 'max_elevation') double maxElevation,
            @JsonKey(name: 'average_cadence') double? averageCadence,
            @JsonKey(name: 'max_cadence') double? maxCadence,
            @JsonKey(name: 'average_heart_rate') double? averageHeartRate,
            @JsonKey(name: 'max_heart_rate') double? maxHeartRate,
            @JsonKey(name: 'average_power') double? averagePower,
            @JsonKey(name: 'max_power') double? maxPower,
            @JsonKey(name: 'liked_by_me') bool likedByMe,
            @JsonKey(name: 'likes_count') int likesCount,
            @JsonKey(name: 'replies_count') int repliesCount,
            @JsonKey(name: 'interval_bests')
            List<Map<String, dynamic>> intervalBests,
            @JsonKey(name: 'climbs') List<Map<String, dynamic>> climbs,
            List<WorkoutAttachment> attachments)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Workout():
        return $default(
            _that.id,
            _that.createdAt,
            _that.updatedAt,
            _that.userID,
            _that.user,
            _that.date,
            _that.dirty,
            _that.equipment,
            _that.data,
            _that.name,
            _that.notes,
            _that.publicUUID,
            _that.customType,
            _that.subType,
            _that.type,
            _that.visibility,
            _that.locked,
            _that.hasFile,
            _that.hasTracks,
            _that.addressString,
            _that.totalDistance,
            _that.totalDuration,
            _that.pauseDuration,
            _that.totalWeight,
            _that.totalRepetitions,
            _that.totalUp,
            _that.totalDown,
            _that.averageSpeed,
            _that.averageSpeedNoPause,
            _that.maxSpeed,
            _that.minElevation,
            _that.maxElevation,
            _that.averageCadence,
            _that.maxCadence,
            _that.averageHeartRate,
            _that.maxHeartRate,
            _that.averagePower,
            _that.maxPower,
            _that.likedByMe,
            _that.likesCount,
            _that.repliesCount,
            _that.intervalBests,
            _that.climbs,
            _that.attachments);
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
            @JsonKey(name: 'id') int? id,
            @JsonKey(name: 'created_at') String? createdAt,
            @JsonKey(name: 'updated_at') String? updatedAt,
            @JsonKey(name: 'user_id') int? userID,
            User? user,
            DateTime date,
            bool? dirty,
            @JsonKey(name: 'equipment') List<Equipment> equipment,
            @JsonKey(name: 'map_data') MapData? data,
            String name,
            String notes,
            @JsonKey(name: 'public_uuid') String? publicUUID,
            @JsonKey(name: 'custom_type') String? customType,
            @JsonKey(name: 'sub_type') String? subType,
            @JsonKey(name: 'type') WorkoutType type,
            @JsonKey(name: 'visibility') String? visibility,
            @JsonKey(name: 'locked') bool locked,
            @JsonKey(name: 'has_file') bool hasFile,
            @JsonKey(name: 'has_tracks') bool hasTracks,
            @JsonKey(name: 'address_string') String? addressString,
            @JsonKey(name: 'total_distance') double totalDistance,
            @JsonKey(name: 'total_duration') int totalDuration,
            @JsonKey(name: 'pause_duration') int pauseDuration,
            @JsonKey(name: 'total_weight') double totalWeight,
            @JsonKey(name: 'total_repetitions') int totalRepetitions,
            @JsonKey(name: 'total_up') double totalUp,
            @JsonKey(name: 'total_down') double totalDown,
            @JsonKey(name: 'average_speed') double averageSpeed,
            @JsonKey(name: 'average_speed_no_pause') double averageSpeedNoPause,
            @JsonKey(name: 'max_speed') double maxSpeed,
            @JsonKey(name: 'min_elevation') double minElevation,
            @JsonKey(name: 'max_elevation') double maxElevation,
            @JsonKey(name: 'average_cadence') double? averageCadence,
            @JsonKey(name: 'max_cadence') double? maxCadence,
            @JsonKey(name: 'average_heart_rate') double? averageHeartRate,
            @JsonKey(name: 'max_heart_rate') double? maxHeartRate,
            @JsonKey(name: 'average_power') double? averagePower,
            @JsonKey(name: 'max_power') double? maxPower,
            @JsonKey(name: 'liked_by_me') bool likedByMe,
            @JsonKey(name: 'likes_count') int likesCount,
            @JsonKey(name: 'replies_count') int repliesCount,
            @JsonKey(name: 'interval_bests')
            List<Map<String, dynamic>> intervalBests,
            @JsonKey(name: 'climbs') List<Map<String, dynamic>> climbs,
            List<WorkoutAttachment> attachments)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Workout() when $default != null:
        return $default(
            _that.id,
            _that.createdAt,
            _that.updatedAt,
            _that.userID,
            _that.user,
            _that.date,
            _that.dirty,
            _that.equipment,
            _that.data,
            _that.name,
            _that.notes,
            _that.publicUUID,
            _that.customType,
            _that.subType,
            _that.type,
            _that.visibility,
            _that.locked,
            _that.hasFile,
            _that.hasTracks,
            _that.addressString,
            _that.totalDistance,
            _that.totalDuration,
            _that.pauseDuration,
            _that.totalWeight,
            _that.totalRepetitions,
            _that.totalUp,
            _that.totalDown,
            _that.averageSpeed,
            _that.averageSpeedNoPause,
            _that.maxSpeed,
            _that.minElevation,
            _that.maxElevation,
            _that.averageCadence,
            _that.maxCadence,
            _that.averageHeartRate,
            _that.maxHeartRate,
            _that.averagePower,
            _that.maxPower,
            _that.likedByMe,
            _that.likesCount,
            _that.repliesCount,
            _that.intervalBests,
            _that.climbs,
            _that.attachments);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Workout implements Workout {
  const _Workout(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'user_id') this.userID,
      this.user,
      required this.date,
      this.dirty,
      @JsonKey(name: 'equipment') final List<Equipment> equipment = const [],
      @JsonKey(name: 'map_data') this.data,
      required this.name,
      this.notes = '',
      @JsonKey(name: 'public_uuid') this.publicUUID,
      @JsonKey(name: 'custom_type') this.customType,
      @JsonKey(name: 'sub_type') this.subType,
      @JsonKey(name: 'type') required this.type,
      @JsonKey(name: 'visibility') this.visibility,
      @JsonKey(name: 'locked') this.locked = false,
      @JsonKey(name: 'has_file') this.hasFile = false,
      @JsonKey(name: 'has_tracks') this.hasTracks = false,
      @JsonKey(name: 'address_string') this.addressString,
      @JsonKey(name: 'total_distance') this.totalDistance = 0.0,
      @JsonKey(name: 'total_duration') this.totalDuration = 0,
      @JsonKey(name: 'pause_duration') this.pauseDuration = 0,
      @JsonKey(name: 'total_weight') this.totalWeight = 0.0,
      @JsonKey(name: 'total_repetitions') this.totalRepetitions = 0,
      @JsonKey(name: 'total_up') this.totalUp = 0.0,
      @JsonKey(name: 'total_down') this.totalDown = 0.0,
      @JsonKey(name: 'average_speed') this.averageSpeed = 0.0,
      @JsonKey(name: 'average_speed_no_pause') this.averageSpeedNoPause = 0.0,
      @JsonKey(name: 'max_speed') this.maxSpeed = 0.0,
      @JsonKey(name: 'min_elevation') this.minElevation = 0.0,
      @JsonKey(name: 'max_elevation') this.maxElevation = 0.0,
      @JsonKey(name: 'average_cadence') this.averageCadence,
      @JsonKey(name: 'max_cadence') this.maxCadence,
      @JsonKey(name: 'average_heart_rate') this.averageHeartRate,
      @JsonKey(name: 'max_heart_rate') this.maxHeartRate,
      @JsonKey(name: 'average_power') this.averagePower,
      @JsonKey(name: 'max_power') this.maxPower,
      @JsonKey(name: 'liked_by_me') this.likedByMe = false,
      @JsonKey(name: 'likes_count') this.likesCount = 0,
      @JsonKey(name: 'replies_count') this.repliesCount = 0,
      @JsonKey(name: 'interval_bests')
      final List<Map<String, dynamic>> intervalBests = const [],
      @JsonKey(name: 'climbs')
      final List<Map<String, dynamic>> climbs = const [],
      final List<WorkoutAttachment> attachments = const []})
      : _equipment = equipment,
        _intervalBests = intervalBests,
        _climbs = climbs,
        _attachments = attachments;
  factory _Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// The ID of the user who owns the workout
  @override
  @JsonKey(name: 'user_id')
  final int? userID;

  /// The owner user of the workout
  @override
  final User? user;

  /// The timestamp the workout was recorded
  @override
  final DateTime date;

  /// Whether the workout has been modified and the details should be re-rendered
  @override
  final bool? dirty;

  /// Which equipment is used for this workout
  final List<Equipment> _equipment;

  /// Which equipment is used for this workout
  @override
  @JsonKey(name: 'equipment')
  List<Equipment> get equipment {
    if (_equipment is EqualUnmodifiableListView) return _equipment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_equipment);
  }

  /// The map data associated with the workout
  @override
  @JsonKey(name: 'map_data')
  final MapData? data;

  /// The name of the workout
  @override
  final String name;

  /// The notes associated with the workout, in markdown
  @override
  @JsonKey()
  final String notes;

  /// UUID to publicly share a workout - this UUID can be rotated
  @override
  @JsonKey(name: 'public_uuid')
  final String? publicUUID;

  /// Optional custom workout type descriptors
  @override
  @JsonKey(name: 'custom_type')
  final String? customType;
  @override
  @JsonKey(name: 'sub_type')
  final String? subType;
  @override
  @JsonKey(name: 'type')
  final WorkoutType type;
  @override
  @JsonKey(name: 'visibility')
  final String? visibility;
  @override
  @JsonKey(name: 'locked')
  final bool locked;
  @override
  @JsonKey(name: 'has_file')
  final bool hasFile;
  @override
  @JsonKey(name: 'has_tracks')
  final bool hasTracks;
  @override
  @JsonKey(name: 'address_string')
  final String? addressString;
  @override
  @JsonKey(name: 'total_distance')
  final double totalDistance;
  @override
  @JsonKey(name: 'total_duration')
  final int totalDuration;
  @override
  @JsonKey(name: 'pause_duration')
  final int pauseDuration;
  @override
  @JsonKey(name: 'total_weight')
  final double totalWeight;
  @override
  @JsonKey(name: 'total_repetitions')
  final int totalRepetitions;
  @override
  @JsonKey(name: 'total_up')
  final double totalUp;
  @override
  @JsonKey(name: 'total_down')
  final double totalDown;
  @override
  @JsonKey(name: 'average_speed')
  final double averageSpeed;
  @override
  @JsonKey(name: 'average_speed_no_pause')
  final double averageSpeedNoPause;
  @override
  @JsonKey(name: 'max_speed')
  final double maxSpeed;
  @override
  @JsonKey(name: 'min_elevation')
  final double minElevation;
  @override
  @JsonKey(name: 'max_elevation')
  final double maxElevation;
  @override
  @JsonKey(name: 'average_cadence')
  final double? averageCadence;
  @override
  @JsonKey(name: 'max_cadence')
  final double? maxCadence;
  @override
  @JsonKey(name: 'average_heart_rate')
  final double? averageHeartRate;
  @override
  @JsonKey(name: 'max_heart_rate')
  final double? maxHeartRate;
  @override
  @JsonKey(name: 'average_power')
  final double? averagePower;
  @override
  @JsonKey(name: 'max_power')
  final double? maxPower;
  @override
  @JsonKey(name: 'liked_by_me')
  final bool likedByMe;
  @override
  @JsonKey(name: 'likes_count')
  final int likesCount;
  @override
  @JsonKey(name: 'replies_count')
  final int repliesCount;
  final List<Map<String, dynamic>> _intervalBests;
  @override
  @JsonKey(name: 'interval_bests')
  List<Map<String, dynamic>> get intervalBests {
    if (_intervalBests is EqualUnmodifiableListView) return _intervalBests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_intervalBests);
  }

  final List<Map<String, dynamic>> _climbs;
  @override
  @JsonKey(name: 'climbs')
  List<Map<String, dynamic>> get climbs {
    if (_climbs is EqualUnmodifiableListView) return _climbs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_climbs);
  }

  final List<WorkoutAttachment> _attachments;
  @override
  @JsonKey()
  List<WorkoutAttachment> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutCopyWith<_Workout> get copyWith =>
      __$WorkoutCopyWithImpl<_Workout>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkoutToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Workout &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.dirty, dirty) || other.dirty == dirty) &&
            const DeepCollectionEquality()
                .equals(other._equipment, _equipment) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.publicUUID, publicUUID) ||
                other.publicUUID == publicUUID) &&
            (identical(other.customType, customType) ||
                other.customType == customType) &&
            (identical(other.subType, subType) || other.subType == subType) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.locked, locked) || other.locked == locked) &&
            (identical(other.hasFile, hasFile) || other.hasFile == hasFile) &&
            (identical(other.hasTracks, hasTracks) ||
                other.hasTracks == hasTracks) &&
            (identical(other.addressString, addressString) ||
                other.addressString == addressString) &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance) &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration) &&
            (identical(other.pauseDuration, pauseDuration) ||
                other.pauseDuration == pauseDuration) &&
            (identical(other.totalWeight, totalWeight) ||
                other.totalWeight == totalWeight) &&
            (identical(other.totalRepetitions, totalRepetitions) ||
                other.totalRepetitions == totalRepetitions) &&
            (identical(other.totalUp, totalUp) || other.totalUp == totalUp) &&
            (identical(other.totalDown, totalDown) ||
                other.totalDown == totalDown) &&
            (identical(other.averageSpeed, averageSpeed) ||
                other.averageSpeed == averageSpeed) &&
            (identical(other.averageSpeedNoPause, averageSpeedNoPause) ||
                other.averageSpeedNoPause == averageSpeedNoPause) &&
            (identical(other.maxSpeed, maxSpeed) ||
                other.maxSpeed == maxSpeed) &&
            (identical(other.minElevation, minElevation) ||
                other.minElevation == minElevation) &&
            (identical(other.maxElevation, maxElevation) ||
                other.maxElevation == maxElevation) &&
            (identical(other.averageCadence, averageCadence) ||
                other.averageCadence == averageCadence) &&
            (identical(other.maxCadence, maxCadence) ||
                other.maxCadence == maxCadence) &&
            (identical(other.averageHeartRate, averageHeartRate) ||
                other.averageHeartRate == averageHeartRate) &&
            (identical(other.maxHeartRate, maxHeartRate) ||
                other.maxHeartRate == maxHeartRate) &&
            (identical(other.averagePower, averagePower) ||
                other.averagePower == averagePower) &&
            (identical(other.maxPower, maxPower) ||
                other.maxPower == maxPower) &&
            (identical(other.likedByMe, likedByMe) ||
                other.likedByMe == likedByMe) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.repliesCount, repliesCount) ||
                other.repliesCount == repliesCount) &&
            const DeepCollectionEquality()
                .equals(other._intervalBests, _intervalBests) &&
            const DeepCollectionEquality().equals(other._climbs, _climbs) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        createdAt,
        updatedAt,
        userID,
        user,
        date,
        dirty,
        const DeepCollectionEquality().hash(_equipment),
        data,
        name,
        notes,
        publicUUID,
        customType,
        subType,
        type,
        visibility,
        locked,
        hasFile,
        hasTracks,
        addressString,
        totalDistance,
        totalDuration,
        pauseDuration,
        totalWeight,
        totalRepetitions,
        totalUp,
        totalDown,
        averageSpeed,
        averageSpeedNoPause,
        maxSpeed,
        minElevation,
        maxElevation,
        averageCadence,
        maxCadence,
        averageHeartRate,
        maxHeartRate,
        averagePower,
        maxPower,
        likedByMe,
        likesCount,
        repliesCount,
        const DeepCollectionEquality().hash(_intervalBests),
        const DeepCollectionEquality().hash(_climbs),
        const DeepCollectionEquality().hash(_attachments)
      ]);

  @override
  String toString() {
    return 'Workout(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, userID: $userID, user: $user, date: $date, dirty: $dirty, equipment: $equipment, data: $data, name: $name, notes: $notes, publicUUID: $publicUUID, customType: $customType, subType: $subType, type: $type, visibility: $visibility, locked: $locked, hasFile: $hasFile, hasTracks: $hasTracks, addressString: $addressString, totalDistance: $totalDistance, totalDuration: $totalDuration, pauseDuration: $pauseDuration, totalWeight: $totalWeight, totalRepetitions: $totalRepetitions, totalUp: $totalUp, totalDown: $totalDown, averageSpeed: $averageSpeed, averageSpeedNoPause: $averageSpeedNoPause, maxSpeed: $maxSpeed, minElevation: $minElevation, maxElevation: $maxElevation, averageCadence: $averageCadence, maxCadence: $maxCadence, averageHeartRate: $averageHeartRate, maxHeartRate: $maxHeartRate, averagePower: $averagePower, maxPower: $maxPower, likedByMe: $likedByMe, likesCount: $likesCount, repliesCount: $repliesCount, intervalBests: $intervalBests, climbs: $climbs, attachments: $attachments)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutCopyWith<$Res> implements $WorkoutCopyWith<$Res> {
  factory _$WorkoutCopyWith(_Workout value, $Res Function(_Workout) _then) =
      __$WorkoutCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'user_id') int? userID,
      User? user,
      DateTime date,
      bool? dirty,
      @JsonKey(name: 'equipment') List<Equipment> equipment,
      @JsonKey(name: 'map_data') MapData? data,
      String name,
      String notes,
      @JsonKey(name: 'public_uuid') String? publicUUID,
      @JsonKey(name: 'custom_type') String? customType,
      @JsonKey(name: 'sub_type') String? subType,
      @JsonKey(name: 'type') WorkoutType type,
      @JsonKey(name: 'visibility') String? visibility,
      @JsonKey(name: 'locked') bool locked,
      @JsonKey(name: 'has_file') bool hasFile,
      @JsonKey(name: 'has_tracks') bool hasTracks,
      @JsonKey(name: 'address_string') String? addressString,
      @JsonKey(name: 'total_distance') double totalDistance,
      @JsonKey(name: 'total_duration') int totalDuration,
      @JsonKey(name: 'pause_duration') int pauseDuration,
      @JsonKey(name: 'total_weight') double totalWeight,
      @JsonKey(name: 'total_repetitions') int totalRepetitions,
      @JsonKey(name: 'total_up') double totalUp,
      @JsonKey(name: 'total_down') double totalDown,
      @JsonKey(name: 'average_speed') double averageSpeed,
      @JsonKey(name: 'average_speed_no_pause') double averageSpeedNoPause,
      @JsonKey(name: 'max_speed') double maxSpeed,
      @JsonKey(name: 'min_elevation') double minElevation,
      @JsonKey(name: 'max_elevation') double maxElevation,
      @JsonKey(name: 'average_cadence') double? averageCadence,
      @JsonKey(name: 'max_cadence') double? maxCadence,
      @JsonKey(name: 'average_heart_rate') double? averageHeartRate,
      @JsonKey(name: 'max_heart_rate') double? maxHeartRate,
      @JsonKey(name: 'average_power') double? averagePower,
      @JsonKey(name: 'max_power') double? maxPower,
      @JsonKey(name: 'liked_by_me') bool likedByMe,
      @JsonKey(name: 'likes_count') int likesCount,
      @JsonKey(name: 'replies_count') int repliesCount,
      @JsonKey(name: 'interval_bests') List<Map<String, dynamic>> intervalBests,
      @JsonKey(name: 'climbs') List<Map<String, dynamic>> climbs,
      List<WorkoutAttachment> attachments});

  @override
  $UserCopyWith<$Res>? get user;
  @override
  $MapDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$WorkoutCopyWithImpl<$Res> implements _$WorkoutCopyWith<$Res> {
  __$WorkoutCopyWithImpl(this._self, this._then);

  final _Workout _self;
  final $Res Function(_Workout) _then;

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? userID = freezed,
    Object? user = freezed,
    Object? date = null,
    Object? dirty = freezed,
    Object? equipment = null,
    Object? data = freezed,
    Object? name = null,
    Object? notes = null,
    Object? publicUUID = freezed,
    Object? customType = freezed,
    Object? subType = freezed,
    Object? type = null,
    Object? visibility = freezed,
    Object? locked = null,
    Object? hasFile = null,
    Object? hasTracks = null,
    Object? addressString = freezed,
    Object? totalDistance = null,
    Object? totalDuration = null,
    Object? pauseDuration = null,
    Object? totalWeight = null,
    Object? totalRepetitions = null,
    Object? totalUp = null,
    Object? totalDown = null,
    Object? averageSpeed = null,
    Object? averageSpeedNoPause = null,
    Object? maxSpeed = null,
    Object? minElevation = null,
    Object? maxElevation = null,
    Object? averageCadence = freezed,
    Object? maxCadence = freezed,
    Object? averageHeartRate = freezed,
    Object? maxHeartRate = freezed,
    Object? averagePower = freezed,
    Object? maxPower = freezed,
    Object? likedByMe = null,
    Object? likesCount = null,
    Object? repliesCount = null,
    Object? intervalBests = null,
    Object? climbs = null,
    Object? attachments = null,
  }) {
    return _then(_Workout(
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
      userID: freezed == userID
          ? _self.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dirty: freezed == dirty
          ? _self.dirty
          : dirty // ignore: cast_nullable_to_non_nullable
              as bool?,
      equipment: null == equipment
          ? _self._equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<Equipment>,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as MapData?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      publicUUID: freezed == publicUUID
          ? _self.publicUUID
          : publicUUID // ignore: cast_nullable_to_non_nullable
              as String?,
      customType: freezed == customType
          ? _self.customType
          : customType // ignore: cast_nullable_to_non_nullable
              as String?,
      subType: freezed == subType
          ? _self.subType
          : subType // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorkoutType,
      visibility: freezed == visibility
          ? _self.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String?,
      locked: null == locked
          ? _self.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      hasFile: null == hasFile
          ? _self.hasFile
          : hasFile // ignore: cast_nullable_to_non_nullable
              as bool,
      hasTracks: null == hasTracks
          ? _self.hasTracks
          : hasTracks // ignore: cast_nullable_to_non_nullable
              as bool,
      addressString: freezed == addressString
          ? _self.addressString
          : addressString // ignore: cast_nullable_to_non_nullable
              as String?,
      totalDistance: null == totalDistance
          ? _self.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      totalDuration: null == totalDuration
          ? _self.totalDuration
          : totalDuration // ignore: cast_nullable_to_non_nullable
              as int,
      pauseDuration: null == pauseDuration
          ? _self.pauseDuration
          : pauseDuration // ignore: cast_nullable_to_non_nullable
              as int,
      totalWeight: null == totalWeight
          ? _self.totalWeight
          : totalWeight // ignore: cast_nullable_to_non_nullable
              as double,
      totalRepetitions: null == totalRepetitions
          ? _self.totalRepetitions
          : totalRepetitions // ignore: cast_nullable_to_non_nullable
              as int,
      totalUp: null == totalUp
          ? _self.totalUp
          : totalUp // ignore: cast_nullable_to_non_nullable
              as double,
      totalDown: null == totalDown
          ? _self.totalDown
          : totalDown // ignore: cast_nullable_to_non_nullable
              as double,
      averageSpeed: null == averageSpeed
          ? _self.averageSpeed
          : averageSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      averageSpeedNoPause: null == averageSpeedNoPause
          ? _self.averageSpeedNoPause
          : averageSpeedNoPause // ignore: cast_nullable_to_non_nullable
              as double,
      maxSpeed: null == maxSpeed
          ? _self.maxSpeed
          : maxSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      minElevation: null == minElevation
          ? _self.minElevation
          : minElevation // ignore: cast_nullable_to_non_nullable
              as double,
      maxElevation: null == maxElevation
          ? _self.maxElevation
          : maxElevation // ignore: cast_nullable_to_non_nullable
              as double,
      averageCadence: freezed == averageCadence
          ? _self.averageCadence
          : averageCadence // ignore: cast_nullable_to_non_nullable
              as double?,
      maxCadence: freezed == maxCadence
          ? _self.maxCadence
          : maxCadence // ignore: cast_nullable_to_non_nullable
              as double?,
      averageHeartRate: freezed == averageHeartRate
          ? _self.averageHeartRate
          : averageHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      maxHeartRate: freezed == maxHeartRate
          ? _self.maxHeartRate
          : maxHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      averagePower: freezed == averagePower
          ? _self.averagePower
          : averagePower // ignore: cast_nullable_to_non_nullable
              as double?,
      maxPower: freezed == maxPower
          ? _self.maxPower
          : maxPower // ignore: cast_nullable_to_non_nullable
              as double?,
      likedByMe: null == likedByMe
          ? _self.likedByMe
          : likedByMe // ignore: cast_nullable_to_non_nullable
              as bool,
      likesCount: null == likesCount
          ? _self.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      repliesCount: null == repliesCount
          ? _self.repliesCount
          : repliesCount // ignore: cast_nullable_to_non_nullable
              as int,
      intervalBests: null == intervalBests
          ? _self._intervalBests
          : intervalBests // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      climbs: null == climbs
          ? _self._climbs
          : climbs // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      attachments: null == attachments
          ? _self._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<WorkoutAttachment>,
    ));
  }

  /// Create a copy of Workout
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

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapDataCopyWith<$Res>? get data {
    if (_self.data == null) {
      return null;
    }

    return $MapDataCopyWith<$Res>(_self.data!, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

// dart format on
