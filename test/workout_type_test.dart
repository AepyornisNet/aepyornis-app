import 'package:flutter_test/flutter_test.dart';
import 'package:aepyornis_app/domain/models/workout_type/workout_type.dart';

void main() {
  group('WorkoutType Generated Tests', () {
    test('kWorkoutTypes contains generated items from workout-types.yaml', () {
      expect(kWorkoutTypes, isNotEmpty);
      expect(kWorkoutTypes.any((t) => t.value == 'running'), isTrue);
      expect(kWorkoutTypes.any((t) => t.value == 'cycling'), isTrue);
      expect(kWorkoutTypes.any((t) => t.value == 'swimming'), isTrue);
    });

    test('getWorkoutTypeConfig looks up configuration correctly', () {
      final runningConfig = getWorkoutTypeConfig('running');
      expect(runningConfig, isNotNull);
      expect(runningConfig!.value, 'running');
      expect(runningConfig.location, isTrue);
      expect(runningConfig.distance, isTrue);
      expect(runningConfig.pace, isTrue);

      final hiitConfig = getWorkoutTypeConfig('hiit');
      expect(hiitConfig, isNotNull);
      expect(hiitConfig!.repetition, isTrue);
      expect(hiitConfig.weight, isTrue);
    });

    test('WorkoutType parses dynamic keys correctly', () {
      final runningType = WorkoutType.fromJson('running');
      expect(runningType.value, 'running');

      final unknownType = WorkoutType.fromJson('non_existent_type');
      expect(unknownType.value, 'non_existent_type');
    });
  });
}
