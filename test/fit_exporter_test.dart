import 'package:fit_tool/fit_tool.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector.dart';
import 'package:aepyornis_app/data/services/health_connect/fit_exporter.dart';

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

  test('FitExporter includes total distance, calories, lap and session metrics',
      () {
    final startTime = DateTime(2026, 7, 27, 10, 0, 0);
    final endTime = DateTime(2026, 7, 27, 10, 30, 0);

    final locations = [
      ExerciseRouteLocation(
        time: startTime,
        latitude: 52.5200,
        longitude: 13.4050,
        altitude: Length.meters(100),
      ),
      ExerciseRouteLocation(
        time: startTime.add(const Duration(minutes: 15)),
        latitude: 52.5250,
        longitude: 13.4100,
        altitude: Length.meters(120),
      ),
      ExerciseRouteLocation(
        time: endTime,
        latitude: 52.5300,
        longitude: 13.4150,
        altitude: Length.meters(110),
      ),
    ];

    final bytes = FitExporter.buildFit(
      title: 'Outdoor Run',
      exerciseType: ExerciseType.running,
      startTime: startTime,
      endTime: endTime,
      locations: locations,
      totalDistance: 3500.0,
      totalCalories: 280,
      heartRates: {
        startTime: 120,
        startTime.add(const Duration(minutes: 15)): 150,
        endTime: 160,
      },
    );

    final parsedFit = FitFile.fromBytes(bytes);

    final sessionMessages = parsedFit.records
        .where((r) => r.message is SessionMessage)
        .map((r) => r.message as SessionMessage)
        .toList();
    expect(sessionMessages, hasLength(1));
    final session = sessionMessages.first;
    expect(session.totalDistance, equals(3500.0));
    expect(session.totalCalories, equals(280));
    expect(session.avgHeartRate, equals(143));
    expect(session.maxHeartRate, equals(160));
    expect(session.totalAscent, equals(20));
    expect(session.totalDescent, equals(10));
    expect(session.startPositionLat, closeTo(52.5200, 0.0001));
    expect(session.startPositionLong, closeTo(13.4050, 0.0001));
    expect(session.necLat, closeTo(52.5300, 0.0001));
    expect(session.swcLat, closeTo(52.5200, 0.0001));

    final lapMessages = parsedFit.records
        .where((r) => r.message is LapMessage)
        .map((r) => r.message as LapMessage)
        .toList();
    expect(lapMessages, hasLength(1));
    final lap = lapMessages.first;
    expect(lap.totalDistance, equals(3500.0));
    expect(lap.totalCalories, equals(280));
    expect(lap.avgHeartRate, equals(143));
    expect(lap.maxHeartRate, equals(160));
    expect(lap.totalAscent, equals(20));
    expect(lap.totalDescent, equals(10));

    final recordMessages = parsedFit.records
        .where((r) => r.message is RecordMessage)
        .map((r) => r.message as RecordMessage)
        .toList();
    expect(recordMessages, hasLength(3));
    expect(recordMessages.first.distance, equals(0.0));
    expect(recordMessages.last.distance, greaterThan(0.0));
    expect(recordMessages.last.speed, greaterThan(0.0));
  });

  test(
      'FitExporter handles initial zero altitude gracefully without zero-elevation first entry',
      () {
    final startTime = DateTime(2026, 7, 27, 10, 0, 0);
    final endTime = DateTime(2026, 7, 27, 10, 10, 0);

    final locations = [
      ExerciseRouteLocation(
        time: startTime,
        latitude: 52.5200,
        longitude: 13.4050,
        altitude: Length.meters(0), // Initial 0 before GPS 3D lock
      ),
      ExerciseRouteLocation(
        time: startTime.add(const Duration(minutes: 5)),
        latitude: 52.5250,
        longitude: 13.4100,
        altitude: Length.meters(250),
      ),
      ExerciseRouteLocation(
        time: endTime,
        latitude: 52.5300,
        longitude: 13.4150,
        altitude: Length.meters(255),
      ),
    ];

    final bytes = FitExporter.buildFit(
      title: 'Elevation Test',
      exerciseType: ExerciseType.running,
      startTime: startTime,
      endTime: endTime,
      locations: locations,
    );

    final parsedFit = FitFile.fromBytes(bytes);
    final recordMessages = parsedFit.records
        .where((r) => r.message is RecordMessage)
        .map((r) => r.message as RecordMessage)
        .toList();

    expect(recordMessages, isNotEmpty);
    expect(recordMessages.first.altitude, closeTo(250.0, 0.1));
  });
}
