---
name: freezed-models
description: Guidelines and code templates for creating and editing Freezed data models with JSON serialization in Dart.
---

# Freezed Data Models Skill

Use this skill when defining or modifying data entities in `lib/domain/models/`.

## Pattern Template

When creating a new model (e.g. `lib/domain/models/workout/workout.dart`):

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout.freezed.dart';
part 'workout.g.dart';

@freezed
abstract class Workout with _$Workout {
  const factory Workout({
    required String id,
    required String name,
    required DateTime createdAt,
    int? durationSeconds,
  }) = _Workout;

  factory Workout.fromJson(Map<String, dynamic> json) => _$WorkoutFromJson(json);
}
```

## Checklist for New Models

1. Include `part '<filename>.freezed.dart';` and `part '<filename>.g.dart';`.
2. Use `@freezed` annotation above the class definition.
3. Define the `fromJson` factory constructor if the model interacts with network APIs or local storage.
4. Run `build_runner` to generate code:
   ```bash
   /home/brihm/develop/flutter/bin/dart run build_runner build --delete-conflicting-outputs
   ```
