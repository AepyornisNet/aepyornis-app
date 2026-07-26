import 'dart:typed_data';

import 'package:fit_tool/fit_tool.dart';
import 'package:health_connector/health_connector.dart';

class FitExporter {
  static Uint8List buildFit({
    required String title,
    required ExerciseType exerciseType,
    required DateTime startTime,
    required DateTime endTime,
    required List<ExerciseRouteLocation> locations,
    Map<DateTime, int> heartRates = const {},
    Map<DateTime, int> cadences = const {},
    Map<DateTime, double> powers = const {},
  }) {
    final builder = FitFileBuilder(autoDefine: true, minStringSize: 50);

    final fileIdMessage = FileIdMessage()
      ..type = FileType.activity
      ..manufacturer = Manufacturer.development.value
      ..product = 1
      ..timeCreated = startTime.millisecondsSinceEpoch
      ..serialNumber = 0x12345678;
    builder.add(fileIdMessage);

    final durationInSeconds = endTime.difference(startTime).inSeconds;
    final sport = _mapExerciseTypeToSport(exerciseType);

    final activityMessage = ActivityMessage()
      ..timestamp = startTime.millisecondsSinceEpoch
      ..totalTimerTime = durationInSeconds.toDouble()
      ..numSessions = 1
      ..type = Activity.manual
      ..event = Event.activity
      ..eventType = EventType.stop;
    builder.add(activityMessage);

    final sessionMessage = SessionMessage()
      ..timestamp = startTime.millisecondsSinceEpoch
      ..startTime = startTime.millisecondsSinceEpoch
      ..totalElapsedTime = durationInSeconds.toDouble()
      ..totalTimerTime = durationInSeconds.toDouble()
      ..sport = sport
      ..subSport = SubSport.generic
      ..firstLapIndex = 0
      ..numLaps = 1;
    builder.add(sessionMessage);

    final bool hasLocations = locations.isNotEmpty;
    final bool hasHeartRates = heartRates.isNotEmpty;
    final bool hasCadences = cadences.isNotEmpty;
    final bool hasPowers = powers.isNotEmpty;

    final allTimestamps = <DateTime>{};
    if (hasLocations) {
      for (final loc in locations) {
        allTimestamps.add(loc.time);
      }
    }
    if (hasHeartRates) {
      allTimestamps.addAll(heartRates.keys);
    }
    if (hasCadences) {
      allTimestamps.addAll(cadences.keys);
    }
    if (hasPowers) {
      allTimestamps.addAll(powers.keys);
    }

    final sortedTimestamps = allTimestamps.toList()
      ..sort((a, b) => a.compareTo(b));

    final locationMap = <DateTime, ExerciseRouteLocation>{};
    if (hasLocations) {
      for (final loc in locations) {
        locationMap[loc.time] = loc;
      }
    }

    for (final time in sortedTimestamps) {
      final recordMessage = RecordMessage();
      recordMessage.timestamp = time.millisecondsSinceEpoch;

      if (hasLocations) {
        final loc = _findClosestLocation(time, locationMap);
        if (loc != null) {
          recordMessage.positionLat = loc.latitude;
          recordMessage.positionLong = loc.longitude;
          if (loc.altitude != null) {
            recordMessage.altitude = loc.altitude!.inMeters;
          }
        }
      }

      if (hasHeartRates) {
        final hr = _findClosestMetric(time, heartRates);
        if (hr != null) {
          recordMessage.heartRate = hr;
        }
      }

      if (hasCadences) {
        final cad = _findClosestMetric(time, cadences);
        if (cad != null) {
          recordMessage.cadence = cad;
        }
      }

      if (hasPowers) {
        final pwr = _findClosestMetric(time, powers);
        if (pwr != null) {
          recordMessage.power = pwr.round();
        }
      }

      builder.add(recordMessage);
    }

    // Build standard 14-byte Garmin FIT header with header CRC
    final records = builder.records;
    var recordsSize = 0;
    for (final r in records) {
      recordsSize += r.size;
    }

    final header = FitFileHeader(
      recordsSize: recordsSize,
      genCrc: true,
    );

    var crc = 0;
    crc = crc16(header.toBytes(), initial: crc);
    for (final r in records) {
      crc = crc16(r.toBytes(), initial: crc);
    }

    final fitFile = FitFile(header, records, crc);
    return fitFile.toBytes();
  }

  static Sport _mapExerciseTypeToSport(ExerciseType type) {
    switch (type) {
      case ExerciseType.running:
      case ExerciseType.runningTreadmill:
        return Sport.running;
      case ExerciseType.cycling:
      case ExerciseType.cyclingStationary:
        return Sport.cycling;
      case ExerciseType.walking:
        return Sport.walking;
      case ExerciseType.hiking:
        return Sport.hiking;
      default:
        return Sport.generic;
    }
  }

  static ExerciseRouteLocation? _findClosestLocation(
    DateTime targetTime,
    Map<DateTime, ExerciseRouteLocation> locations,
  ) {
    if (locations.isEmpty) {
      return null;
    }
    if (locations.containsKey(targetTime)) {
      return locations[targetTime];
    }

    ExerciseRouteLocation? closest;
    int minDiff = 5;
    locations.forEach((time, loc) {
      final diff = time.difference(targetTime).inSeconds.abs();
      if (diff < minDiff) {
        minDiff = diff;
        closest = loc;
      }
    });
    return closest;
  }

  static T? _findClosestMetric<T>(
    DateTime targetTime,
    Map<DateTime, T> metrics,
  ) {
    if (metrics.isEmpty) {
      return null;
    }
    if (metrics.containsKey(targetTime)) {
      return metrics[targetTime];
    }

    T? closestValue;
    int minDiff = 5;
    metrics.forEach((time, val) {
      final diff = time.difference(targetTime).inSeconds.abs();
      if (diff < minDiff) {
        minDiff = diff;
        closestValue = val;
      }
    });
    return closestValue;
  }
}
