import 'package:flutter/material.dart';

class WorkoutType {
  /// The underlying value of this enum member.
  late String value;

  WorkoutType(this.value);
  WorkoutType._internal(this.value);

  static WorkoutType auto_ = WorkoutType._internal("auto");
  static WorkoutType running_ = WorkoutType._internal("running");
  static WorkoutType cycling_ = WorkoutType._internal("cycling");
  static WorkoutType eCycling_ = WorkoutType._internal("e-cycling");
  static WorkoutType walking_ = WorkoutType._internal("walking");
  static WorkoutType skiing_ = WorkoutType._internal("skiing");
  static WorkoutType snowboarding_ = WorkoutType._internal("snowboarding");
  static WorkoutType swimming_ = WorkoutType._internal("swimming");
  static WorkoutType kayaking_ = WorkoutType._internal("kayaking");
  static WorkoutType golfing_ = WorkoutType._internal("golfing");
  static WorkoutType hiking_ = WorkoutType._internal("hiking");
  static WorkoutType pushUps_ = WorkoutType._internal("push-ups");
  static WorkoutType weightLifting_ = WorkoutType._internal("weight-lifting");
  static WorkoutType horseRiding_ = WorkoutType._internal("horse-riding");
  static WorkoutType inlineSkating_ = WorkoutType._internal("inline-skating");
  static WorkoutType rowing_ = WorkoutType._internal("rowing");
  static WorkoutType other_ = WorkoutType._internal("other");

  @override
  bool operator ==(other) {
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
    switch (value) {
      case "auto":
        return Icons.sports;
      case "running":
        return Icons.directions_run;
      case "cycling":
        return Icons.directions_bike;
      case "e-cycling":
        return Icons.electric_bike;
      case "walking":
        return Icons.directions_walk;
      case "skiing":
        return Icons.downhill_skiing;
      case "snowboarding":
        return Icons.snowboarding;
      case "swimming":
        return Icons.pool;
      case "kayaking":
        return Icons.kayaking;
      case "golfing":
        return Icons.golf_course;
      case "hiking":
        return Icons.hiking;
      case "push-ups":
        return Icons.fitness_center;
      case "weight-lifting":
        return Icons.fitness_center;
      case "horse-riding":
        return Icons.directions_run;
      case "inline-skating":
        return Icons.directions_walk;
      case "rowing":
        return Icons.rowing;
      case "other":
        return Icons.sports;
    }
    return Icons.sports;
  }

  WorkoutType.fromJson(dynamic data) {
    final decoded = data as String?;
    switch (decoded) {
      case "auto":
        value = decoded!;
        break;
      case "running":
        value = decoded!;
        break;
      case "cycling":
        value = decoded!;
        break;
      case "e-cycling":
        value = decoded!;
        break;
      case "walking":
        value = decoded!;
        break;
      case "skiing":
        value = decoded!;
        break;
      case "snowboarding":
        value = decoded!;
        break;
      case "swimming":
        value = decoded!;
        break;
      case "kayaking":
        value = decoded!;
        break;
      case "golfing":
        value = decoded!;
        break;
      case "hiking":
        value = decoded!;
        break;
      case "push-ups":
        value = decoded!;
        break;
      case "weight-lifting":
        value = decoded!;
        break;
      case "horse-riding":
        value = decoded!;
        break;
      case "inline-skating":
        value = decoded!;
        break;
      case "rowing":
        value = decoded!;
        break;
      case "other":
        value = decoded!;
        break;
      default:
        value = other_.value;
    }
  }

  String toJson() {
    return value;
  }
}
