import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:workout_tracker_app/domain/models/user/user.dart';

part 'workout_reply.freezed.dart';
part 'workout_reply.g.dart';

@freezed
abstract class WorkoutReply with _$WorkoutReply {
  const factory WorkoutReply({
    required int id,
    @JsonKey(name: 'object_iri') String? objectIri,
    @JsonKey(name: 'user_id') int? userId,
    User? user,
    @JsonKey(name: 'actor_iri') String? actorIri,
    @JsonKey(name: 'actor_name') String? actorName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    required String content,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'published_at') String? publishedAt,
  }) = _WorkoutReply;

  factory WorkoutReply.fromJson(Map<String, dynamic> json) =>
      _$WorkoutReplyFromJson(json);
}
