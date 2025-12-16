import 'package:freezed_annotation/freezed_annotation.dart';

part 'measurement.freezed.dart';
part 'measurement.g.dart';

@freezed
abstract class Measurement with _$Measurement {
  const factory Measurement({
    int? id,
    String? createdAt,
    String? updatedAt,

    /* The number of steps taken */
    @Default(0) double steps,

    /* The ID of the user who owns the workout */
    int? userID,

    /* The weight of the user, in kilograms */
    required double? weight,

    /* Resting heart rate (beats per minute) */
    @JsonKey(name: 'resting_heart_rate') double? restingHeartRate,

    /* The date of the measurement (yyyy-mm-dd) */
    required String date,

    /* The height of the user, in centimeter */
    required double? height,
  }) = _Measurement;

  factory Measurement.fromJson(Map<String, dynamic> json) =>
      _$MeasurementFromJson(json);
}
