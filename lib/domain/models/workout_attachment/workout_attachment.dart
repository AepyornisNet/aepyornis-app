import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_attachment.freezed.dart';
part 'workout_attachment.g.dart';

@freezed
abstract class WorkoutAttachment with _$WorkoutAttachment {
  const factory WorkoutAttachment({
    int? id,
    String? kind,
    String? filename,
    @JsonKey(name: 'content_type') String? contentType,
    int? order,
    String? url,
  }) = _WorkoutAttachment;

  factory WorkoutAttachment.fromJson(Map<String, dynamic> json) =>
      _$WorkoutAttachmentFromJson(json);
}
