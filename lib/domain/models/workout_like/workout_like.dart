import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:aepyornis_app/domain/models/user_summary/user_summary.dart';

part 'workout_like.freezed.dart';
part 'workout_like.g.dart';

/// Represents a like on a workout
@freezed
abstract class WorkoutLike with _$WorkoutLike {
  const factory WorkoutLike({
    required int id,
    @JsonKey(name: 'user_id') int? userId,
    UserSummary? user,
    @JsonKey(name: 'actor_iri') String? actorIri,
    @JsonKey(name: 'actor_name') String? actorName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _WorkoutLike;

  factory WorkoutLike.fromJson(Map<String, dynamic> json) =>
      _$WorkoutLikeFromJson(json);
}
