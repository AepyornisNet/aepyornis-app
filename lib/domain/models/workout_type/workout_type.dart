import 'package:flutter/material.dart';
import 'package:aepyornis_app/domain/models/workout_type/workout_type_generated.dart';

export 'package:aepyornis_app/domain/models/workout_type/workout_type_generated.dart';

class WorkoutType {
  /// The underlying value of this enum member.
  late String value;

  WorkoutType(this.value);
  WorkoutType._internal(this.value);

  static WorkoutType auto_ = WorkoutType._internal("auto");
  static WorkoutType running_ = WorkoutType._internal("running");
  static WorkoutType cycling_ = WorkoutType._internal("cycling");
  static WorkoutType eCycling_ = WorkoutType._internal("e-cycling");
  static WorkoutType eBiking_ = WorkoutType._internal("e_biking");
  static WorkoutType walking_ = WorkoutType._internal("walking");
  static WorkoutType skiing_ = WorkoutType._internal("skiing");
  static WorkoutType snowboarding_ = WorkoutType._internal("snowboarding");
  static WorkoutType swimming_ = WorkoutType._internal("swimming");
  static WorkoutType kayaking_ = WorkoutType._internal("kayaking");
  static WorkoutType golfing_ = WorkoutType._internal("golfing");
  static WorkoutType golf_ = WorkoutType._internal("golf");
  static WorkoutType hiking_ = WorkoutType._internal("hiking");
  static WorkoutType pushUps_ = WorkoutType._internal("push-ups");
  static WorkoutType weightLifting_ = WorkoutType._internal("weight-lifting");
  static WorkoutType horseRiding_ = WorkoutType._internal("horse-riding");
  static WorkoutType inlineSkating_ = WorkoutType._internal("inline-skating");
  static WorkoutType rowing_ = WorkoutType._internal("rowing");
  static WorkoutType other_ = WorkoutType._internal("other");

  @override
  bool operator ==(Object other) {
    if (other is WorkoutType) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode {
    return value.hashCode;
  }

  IconData get icon {
    switch (value.toLowerCase()) {
      case "auto":
        return Icons.sports;
      case "running":
        return Icons.directions_run;
      case "cycling":
      case "e_biking":
      case "e-cycling":
        return Icons.directions_bike;
      case "walking":
      case "wheelchair_push_walk":
      case "wheelchair_push_run":
        return Icons.directions_walk;
      case "skiing":
      case "alpine_skiing":
      case "cross_country_skiing":
        return Icons.downhill_skiing;
      case "snowboarding":
        return Icons.snowboarding;
      case "swimming":
      case "diving":
        return Icons.pool;
      case "kayaking":
      case "paddling":
      case "rafting":
      case "boating":
      case "sailing":
        return Icons.kayaking;
      case "golf":
      case "golfing":
      case "disc_golf":
        return Icons.golf_course;
      case "hiking":
      case "mountaineering":
      case "rock_climbing":
        return Icons.hiking;
      case "fitness_equipment":
      case "training":
      case "weight_lifting":
      case "weight-lifting":
      case "hiit":
      case "push-ups":
      case "push_ups":
        return Icons.fitness_center;
      case "rowing":
      case "grinding":
        return Icons.rowing;
      case "tennis":
      case "racket":
        return Icons.sports_tennis;
      case "motorcycling":
      case "driving":
      case "motor_sports":
        return Icons.directions_car;
      case "flying":
      case "hang_gliding":
      case "sky_diving":
      case "jumpmaster":
        return Icons.flight;
      case "surfing":
      case "windsurfing":
      case "kitesurfing":
      case "stand_up_paddleboarding":
      case "wakeboarding":
      case "water_skiing":
      case "wakesurfing":
      case "water_tubing":
      case "water_sport":
        return Icons.surfing;
      case "boxing":
      case "mixed_martial_arts":
        return Icons.sports_mma;
      case "video_gaming":
        return Icons.sports_esports;
      case "meditation":
      case "yoga":
        return Icons.self_improvement;
      default:
        return Icons.sports;
    }
  }

  WorkoutType.fromJson(dynamic data) {
    final decoded = data as String?;
    if (decoded != null &&
        (kWorkoutTypeMap.containsKey(decoded.toLowerCase()) ||
            decoded == "auto" ||
            decoded == "other")) {
      value = decoded;
    } else {
      value = decoded ?? other_.value;
    }
  }

  String toJson() {
    return value;
  }
}
