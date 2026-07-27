import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:aepyornis_app/domain/models/equipment/equipment.dart';
import 'package:aepyornis_app/domain/models/map_data/map_data.dart';
import 'package:aepyornis_app/domain/models/user/user.dart';
import 'package:aepyornis_app/domain/models/workout_attachment/workout_attachment.dart';
import 'package:aepyornis_app/domain/models/workout_type/workout_type.dart';

part 'workout.freezed.dart';
part 'workout.g.dart';

@freezed
abstract class Workout with _$Workout {
  const factory Workout({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,

    /// The ID of the user who owns the workout
    @JsonKey(name: 'user_id') int? userID,

    /// The owner user of the workout
    User? user,

    /// The timestamp the workout was recorded
    required DateTime date,

    /// Whether the workout has been modified and the details should be re-rendered
    bool? dirty,

    /// Which equipment is used for this workout
    @JsonKey(name: 'equipment') @Default([]) List<Equipment> equipment,

    /// The map data associated with the workout
    @JsonKey(name: 'map_data') MapData? data,

    /// The name of the workout
    required String name,

    /// The notes associated with the workout, in markdown
    @Default('') String notes,

    /// UUID to publicly share a workout - this UUID can be rotated
    @JsonKey(name: 'public_uuid') String? publicUUID,

    /// Optional custom workout type descriptors
    @JsonKey(name: 'custom_type') String? customType,
    @JsonKey(name: 'sub_type') String? subType,
    @JsonKey(name: 'type') required WorkoutType type,
    @JsonKey(name: 'visibility') String? visibility,
    @JsonKey(name: 'locked') @Default(false) bool locked,
    @JsonKey(name: 'has_file') @Default(false) bool hasFile,
    @JsonKey(name: 'has_tracks') @Default(false) bool hasTracks,
    @JsonKey(name: 'address_string') String? addressString,
    @JsonKey(name: 'total_distance') @Default(0.0) double totalDistance,
    @JsonKey(name: 'total_duration') @Default(0) int totalDuration,
    @JsonKey(name: 'pause_duration') @Default(0) int pauseDuration,
    @JsonKey(name: 'total_weight') @Default(0.0) double totalWeight,
    @JsonKey(name: 'total_repetitions') @Default(0) int totalRepetitions,
    @JsonKey(name: 'total_up') @Default(0.0) double totalUp,
    @JsonKey(name: 'total_down') @Default(0.0) double totalDown,
    @JsonKey(name: 'average_speed') @Default(0.0) double averageSpeed,
    @JsonKey(name: 'average_speed_no_pause')
    @Default(0.0)
    double averageSpeedNoPause,
    @JsonKey(name: 'max_speed') @Default(0.0) double maxSpeed,
    @JsonKey(name: 'min_elevation') @Default(0.0) double minElevation,
    @JsonKey(name: 'max_elevation') @Default(0.0) double maxElevation,
    @JsonKey(name: 'average_cadence') double? averageCadence,
    @JsonKey(name: 'max_cadence') double? maxCadence,
    @JsonKey(name: 'average_heart_rate') double? averageHeartRate,
    @JsonKey(name: 'max_heart_rate') double? maxHeartRate,
    @JsonKey(name: 'average_power') double? averagePower,
    @JsonKey(name: 'max_power') double? maxPower,
    @JsonKey(name: 'liked_by_me') @Default(false) bool likedByMe,
    @JsonKey(name: 'likes_count') @Default(0) int likesCount,
    @JsonKey(name: 'replies_count') @Default(0) int repliesCount,
    @JsonKey(name: 'interval_bests')
    @Default([])
    List<Map<String, dynamic>> intervalBests,
    @JsonKey(name: 'climbs') @Default([]) List<Map<String, dynamic>> climbs,
    @Default([]) List<WorkoutAttachment> attachments,
  }) = _Workout;

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(_normalizeWorkoutJson(json));
}

extension WorkoutOwnership on Workout {
  bool isOwnedBy(User? currentUser) {
    if (currentUser == null) return true;
    final currentUserId = currentUser.id ?? currentUser.profile?.id;
    if (currentUserId == null) return true;

    final ownerId = userID ?? user?.id ?? user?.profile?.id;
    if (ownerId == null) return true;

    return ownerId == currentUserId;
  }
}

Map<String, dynamic> _normalizeWorkoutJson(Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);

  void copyKey(String target, String source) {
    if (!normalized.containsKey(target) && json.containsKey(source)) {
      normalized[target] = json[source];
    }
  }

  copyKey('id', 'ID');
  copyKey('created_at', 'CreatedAt');
  copyKey('updated_at', 'UpdatedAt');
  copyKey('user_id', 'userID');
  copyKey('map_data', 'data');
  copyKey('public_uuid', 'publicUUID');
  copyKey('address_string', 'addressString');
  copyKey('total_distance', 'totalDistance');
  copyKey('total_duration', 'totalDuration');
  copyKey('pause_duration', 'pauseDuration');
  copyKey('total_weight', 'totalWeight');
  copyKey('total_repetitions', 'totalRepetitions');
  copyKey('total_up', 'totalUp');
  copyKey('total_down', 'totalDown');
  copyKey('average_speed', 'averageSpeed');
  copyKey('average_speed_no_pause', 'averageSpeedNoPause');
  copyKey('max_speed', 'maxSpeed');
  copyKey('min_elevation', 'minElevation');
  copyKey('max_elevation', 'maxElevation');
  copyKey('average_cadence', 'averageCadence');
  copyKey('max_cadence', 'maxCadence');
  copyKey('average_heart_rate', 'averageHeartRate');
  copyKey('max_heart_rate', 'maxHeartRate');
  copyKey('average_power', 'averagePower');
  copyKey('max_power', 'maxPower');
  copyKey('custom_type', 'customType');
  copyKey('sub_type', 'subType');
  copyKey('visibility', 'visibility');
  copyKey('liked_by_me', 'likedByMe');
  copyKey('likes_count', 'likesCount');
  copyKey('replies_count', 'repliesCount');
  copyKey('interval_bests', 'intervalBests');
  copyKey('climbs', 'climbs');

  if (normalized['user'] == null ||
      normalized['user'] is! Map<String, dynamic>) {
    normalized.remove('user');
  }

  if (normalized['map_data'] is Map<String, dynamic>) {
    final mapData = Map<String, dynamic>.from(
        normalized['map_data'] as Map<String, dynamic>);
    if (!mapData.containsKey('details') && json.containsKey('records')) {
      final records = json['records'];
      if (records is Map<String, dynamic>) {
        mapData['details'] =
            records.containsKey('details') ? records['details'] : records;
      }
    }
    if (!mapData.containsKey('extra_metrics') &&
        json.containsKey('records') &&
        json['records'] is Map<String, dynamic> &&
        json['records'].containsKey('extra_metrics')) {
      mapData['extra_metrics'] = json['records']['extra_metrics'];
    }
    normalized['map_data'] = mapData;
  } else if (json.containsKey('records')) {
    final records = json['records'];
    if (records is Map<String, dynamic>) {
      normalized['map_data'] = {
        'details':
            records.containsKey('details') ? records['details'] : records,
        if (records.containsKey('extra_metrics'))
          'extra_metrics': records['extra_metrics'],
      };
    }
  }

  return normalized;
}
