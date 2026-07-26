import 'package:fit_tool/fit_tool.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector.dart';
import 'package:workout_tracker_app/data/services/health_connect/fit_exporter.dart';

void main() {
  test('FitExporter builds valid FIT file bytes with 14-byte header', () {
    final startTime = DateTime.now().subtract(const Duration(minutes: 30));
    final endTime = DateTime.now();

    final bytes = FitExporter.buildFit(
      title: 'Running Workout',
      exerciseType: ExerciseType.running,
      startTime: startTime,
      endTime: endTime,
      locations: [],
      heartRates: {
        startTime.add(const Duration(minutes: 5)): 140,
        startTime.add(const Duration(minutes: 10)): 150,
      },
    );

    expect(bytes, isNotEmpty);
    expect(bytes[0], equals(14));
    expect(String.fromCharCodes(bytes.sublist(8, 12)), equals('.FIT'));

    final parsedFit = FitFile.fromBytes(bytes);
    expect(parsedFit.header.size, equals(14));
  });

  test('FitExporter omits position fields when locations list is empty', () {
    final startTime = DateTime.now().subtract(const Duration(minutes: 30));
    final endTime = DateTime.now();

    final bytes = FitExporter.buildFit(
      title: 'Indoor Cycling',
      exerciseType: ExerciseType.cyclingStationary,
      startTime: startTime,
      endTime: endTime,
      locations: [],
      heartRates: {
        startTime.add(const Duration(minutes: 1)): 130,
      },
      cadences: {
        startTime.add(const Duration(minutes: 1)): 85,
      },
    );

    final parsedFit = FitFile.fromBytes(bytes);
    final recordMessages = parsedFit.records
        .where((r) => r.message is RecordMessage)
        .map((r) => r.message as RecordMessage)
        .toList();

    expect(recordMessages, isNotEmpty);
    for (final rec in recordMessages) {
      expect(rec.positionLat, isNull);
      expect(rec.positionLong, isNull);
      expect(rec.altitude, isNull);
    }
  });
}
