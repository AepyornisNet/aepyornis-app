import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aepyornis_app/ui/workout/create/view_models/workout_create_viewmodel.dart';
import 'package:aepyornis_app/data/repositories/workout/workout_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';
import 'package:aepyornis_app/domain/models/equipment/equipment.dart';

class DummyWorkoutRepository implements WorkoutRepository {
  @override
  Future<Result<List<Equipment>>> getEquipment() async => Success([]);

  @override
  Future<Result<List<Workout>>> uploadWorkoutFiles({
    required List<PlatformFile> files,
    String? type,
    String? notes,
  }) async =>
      Success([]);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('WorkoutCreateViewModel File Validation', () {
    test('isSupportedFile correctly identifies allowed file extensions', () {
      final validFiles = [
        PlatformFile(name: 'activity.fit', size: 100),
        PlatformFile(name: 'track.GPX', size: 100),
        PlatformFile(name: 'workout.tcx', size: 100),
        PlatformFile(name: 'data.ftb', size: 100),
        PlatformFile(name: 'archive.zip', size: 100),
      ];

      final invalidFiles = [
        PlatformFile(name: 'document.pdf', size: 100),
        PlatformFile(name: 'image.png', size: 100),
        PlatformFile(name: 'notes.txt', size: 100),
        PlatformFile(name: 'video.mp4', size: 100),
      ];

      for (final file in validFiles) {
        expect(WorkoutCreateViewModel.isSupportedFile(file), isTrue,
            reason: '${file.name} should be supported');
      }

      for (final file in invalidFiles) {
        expect(WorkoutCreateViewModel.isSupportedFile(file), isFalse,
            reason: '${file.name} should not be supported');
      }
    });

    test('addFiles accepts supported files and rejects unsupported files', () {
      final vm = WorkoutCreateViewModel(
        workoutRepository: DummyWorkoutRepository(),
      );

      final mixedFiles = [
        PlatformFile(name: 'run.fit', size: 100),
        PlatformFile(name: 'bad.pdf', size: 100),
      ];

      vm.addFiles(mixedFiles);

      expect(vm.selectedFiles.length, 1);
      expect(vm.selectedFiles.first.name, 'run.fit');
      expect(vm.selectedTabIndex, 0);
      expect(vm.errorMessage, contains('Some files were ignored'));
    });

    test('addFiles rejects completely unsupported files with error message',
        () {
      final vm = WorkoutCreateViewModel(
        workoutRepository: DummyWorkoutRepository(),
      );

      final invalidFiles = [
        PlatformFile(name: 'unsupported.docx', size: 100),
      ];

      vm.addFiles(invalidFiles);

      expect(vm.selectedFiles, isEmpty);
      expect(vm.errorMessage, contains('Unsupported file type'));
    });
  });
}
