import 'dart:math' as math;
import 'dart:typed_data';

import 'package:fit_tool/fit_tool.dart';
import 'package:health_connector/health_connector.dart';

class _DistanceAndSpeed {
  const _DistanceAndSpeed(this.distance, this.speed);
  final double distance;
  final double speed;
}

class _InterpolatedLocation {
  const _InterpolatedLocation({
    required this.latitude,
    required this.longitude,
    this.altitude,
  });

  final double latitude;
  final double longitude;
  final double? altitude;
}

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
    double? totalDistance,
    int? totalCalories,
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

    final bool hasLocations = locations.isNotEmpty;
    final bool hasHeartRates = heartRates.isNotEmpty;
    final bool hasCadences = cadences.isNotEmpty;
    final bool hasPowers = powers.isNotEmpty;

    final rawSortedLocations = hasLocations
        ? (List<ExerciseRouteLocation>.from(locations)
          ..sort((a, b) => a.time.compareTo(b.time)))
        : <ExerciseRouteLocation>[];

    final sortedLocations = <ExerciseRouteLocation>[];
    if (hasLocations) {
      double? firstValidAltitude;
      for (final loc in rawSortedLocations) {
        if (loc.altitude != null && loc.altitude!.inMeters.abs() > 0.001) {
          firstValidAltitude = loc.altitude!.inMeters;
          break;
        }
      }

      bool foundNonZero = false;
      for (final loc in rawSortedLocations) {
        if (!foundNonZero &&
            loc.altitude != null &&
            loc.altitude!.inMeters.abs() <= 0.001 &&
            firstValidAltitude != null) {
          sortedLocations.add(
            ExerciseRouteLocation(
              time: loc.time,
              latitude: loc.latitude,
              longitude: loc.longitude,
              altitude: Length.meters(firstValidAltitude),
            ),
          );
        } else {
          if (loc.altitude != null && loc.altitude!.inMeters.abs() > 0.001) {
            foundNonZero = true;
          }
          sortedLocations.add(loc);
        }
      }
    }

    final locationDistances = <double>[];
    final locationSpeeds = <double>[];
    double totalGpsDistance = 0.0;
    double totalAscent = 0.0;
    double totalDescent = 0.0;
    bool hasAscentDescent = false;

    double? startPositionLat;
    double? startPositionLong;
    double? endPositionLat;
    double? endPositionLong;
    double? necLat;
    double? necLong;
    double? swcLat;
    double? swcLong;

    if (hasLocations) {
      startPositionLat = sortedLocations.first.latitude;
      startPositionLong = sortedLocations.first.longitude;
      endPositionLat = sortedLocations.last.latitude;
      endPositionLong = sortedLocations.last.longitude;

      necLat = sortedLocations.first.latitude;
      swcLat = sortedLocations.first.latitude;
      necLong = sortedLocations.first.longitude;
      swcLong = sortedLocations.first.longitude;

      for (int i = 0; i < sortedLocations.length; i++) {
        final loc = sortedLocations[i];
        if (loc.latitude > necLat!) necLat = loc.latitude;
        if (loc.latitude < swcLat!) swcLat = loc.latitude;
        if (loc.longitude > necLong!) necLong = loc.longitude;
        if (loc.longitude < swcLong!) swcLong = loc.longitude;

        if (i == 0) {
          locationDistances.add(0.0);
          locationSpeeds.add(0.0);
        } else {
          final prevLoc = sortedLocations[i - 1];
          final stepDist = _haversineDistance(
            prevLoc.latitude,
            prevLoc.longitude,
            loc.latitude,
            loc.longitude,
          );
          totalGpsDistance += stepDist;
          locationDistances.add(totalGpsDistance);

          final dtSec =
              loc.time.difference(prevLoc.time).inMilliseconds / 1000.0;
          final speed = dtSec > 0 ? stepDist / dtSec : 0.0;
          locationSpeeds.add(speed);

          if (loc.altitude != null && prevLoc.altitude != null) {
            final altDiff = loc.altitude!.inMeters - prevLoc.altitude!.inMeters;
            if (altDiff > 0) {
              totalAscent += altDiff;
              hasAscentDescent = true;
            } else if (altDiff < 0) {
              totalDescent += (-altDiff);
              hasAscentDescent = true;
            }
          }
        }
      }
    }

    final double finalTotalDistance = totalDistance ??
        (hasLocations && totalGpsDistance > 0 ? totalGpsDistance : 0.0);

    final double? avgSpeed = (finalTotalDistance > 0 && durationInSeconds > 0)
        ? (finalTotalDistance / durationInSeconds)
        : null;

    final double? maxSpeed = locationSpeeds.isNotEmpty
        ? locationSpeeds.reduce(math.max)
        : avgSpeed;

    int? avgHeartRate;
    int? maxHeartRate;
    if (hasHeartRates) {
      avgHeartRate = (heartRates.values.reduce((a, b) => a + b) /
              heartRates.length)
          .round();
      maxHeartRate = heartRates.values.reduce(math.max);
    }

    int? avgCadence;
    int? maxCadence;
    if (hasCadences) {
      avgCadence =
          (cadences.values.reduce((a, b) => a + b) / cadences.length).round();
      maxCadence = cadences.values.reduce(math.max);
    }

    int? avgPower;
    int? maxPower;
    if (hasPowers) {
      avgPower =
          (powers.values.reduce((a, b) => a + b) / powers.length).round();
      maxPower = powers.values.reduce(math.max).round();
    }

    final activityMessage = ActivityMessage()
      ..timestamp = endTime.millisecondsSinceEpoch
      ..totalTimerTime = durationInSeconds.toDouble()
      ..numSessions = 1
      ..type = Activity.manual
      ..event = Event.activity
      ..eventType = EventType.stop;
    builder.add(activityMessage);

    final allTimestamps = <DateTime>{};
    if (hasLocations) {
      for (final loc in sortedLocations) {
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
    if (allTimestamps.isEmpty) {
      allTimestamps.add(startTime);
      if (endTime != startTime) {
        allTimestamps.add(endTime);
      }
    }

    final sortedTimestamps = allTimestamps.toList()
      ..sort((a, b) => a.compareTo(b));

    for (final time in sortedTimestamps) {
      final recordMessage = RecordMessage();
      recordMessage.timestamp = time.millisecondsSinceEpoch;

      if (hasLocations) {
        final interpolatedLoc = _interpolateLocation(time, sortedLocations);
        recordMessage.positionLat = interpolatedLoc.latitude;
        recordMessage.positionLong = interpolatedLoc.longitude;
        if (interpolatedLoc.altitude != null) {
          recordMessage.altitude = interpolatedLoc.altitude;
        }

        final interp = _interpolateDistanceAndSpeed(
          time,
          sortedLocations,
          locationDistances,
          locationSpeeds,
        );
        recordMessage.distance = interp.distance;
        recordMessage.speed = interp.speed;
      } else if (finalTotalDistance > 0 && durationInSeconds > 0) {
        final progress = (time.difference(startTime).inMilliseconds /
                (durationInSeconds * 1000.0))
            .clamp(0.0, 1.0);
        recordMessage.distance = finalTotalDistance * progress;
        if (avgSpeed != null) {
          recordMessage.speed = avgSpeed;
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

    final lapMessage = LapMessage()
      ..messageIndex = 0
      ..timestamp = endTime.millisecondsSinceEpoch
      ..startTime = startTime.millisecondsSinceEpoch
      ..totalElapsedTime = durationInSeconds.toDouble()
      ..totalTimerTime = durationInSeconds.toDouble()
      ..sport = sport
      ..subSport = SubSport.generic;

    if (finalTotalDistance > 0) {
      lapMessage.totalDistance = finalTotalDistance;
    }
    if (totalCalories != null && totalCalories > 0) {
      lapMessage.totalCalories = totalCalories;
    }
    if (avgSpeed != null && avgSpeed > 0) {
      lapMessage.avgSpeed = avgSpeed;
    }
    if (maxSpeed != null && maxSpeed > 0) {
      lapMessage.maxSpeed = maxSpeed;
    }
    if (avgHeartRate != null) {
      lapMessage.avgHeartRate = avgHeartRate;
    }
    if (maxHeartRate != null) {
      lapMessage.maxHeartRate = maxHeartRate;
    }
    if (avgCadence != null) {
      lapMessage.avgCadence = avgCadence;
    }
    if (maxCadence != null) {
      lapMessage.maxCadence = maxCadence;
    }
    if (avgPower != null) {
      lapMessage.avgPower = avgPower;
    }
    if (maxPower != null) {
      lapMessage.maxPower = maxPower;
    }
    if (hasAscentDescent) {
      lapMessage.totalAscent = totalAscent.round();
      lapMessage.totalDescent = totalDescent.round();
    }
    if (startPositionLat != null && startPositionLong != null) {
      lapMessage.startPositionLat = startPositionLat;
      lapMessage.startPositionLong = startPositionLong;
    }
    if (endPositionLat != null && endPositionLong != null) {
      lapMessage.endPositionLat = endPositionLat;
      lapMessage.endPositionLong = endPositionLong;
    }
    builder.add(lapMessage);

    final sessionMessage = SessionMessage()
      ..timestamp = endTime.millisecondsSinceEpoch
      ..startTime = startTime.millisecondsSinceEpoch
      ..totalElapsedTime = durationInSeconds.toDouble()
      ..totalTimerTime = durationInSeconds.toDouble()
      ..sport = sport
      ..subSport = SubSport.generic
      ..firstLapIndex = 0
      ..numLaps = 1;

    if (finalTotalDistance > 0) {
      sessionMessage.totalDistance = finalTotalDistance;
    }
    if (totalCalories != null && totalCalories > 0) {
      sessionMessage.totalCalories = totalCalories;
    }
    if (avgSpeed != null && avgSpeed > 0) {
      sessionMessage.avgSpeed = avgSpeed;
    }
    if (maxSpeed != null && maxSpeed > 0) {
      sessionMessage.maxSpeed = maxSpeed;
    }
    if (avgHeartRate != null) {
      sessionMessage.avgHeartRate = avgHeartRate;
    }
    if (maxHeartRate != null) {
      sessionMessage.maxHeartRate = maxHeartRate;
    }
    if (avgCadence != null) {
      sessionMessage.avgCadence = avgCadence;
    }
    if (maxCadence != null) {
      sessionMessage.maxCadence = maxCadence;
    }
    if (avgPower != null) {
      sessionMessage.avgPower = avgPower;
    }
    if (maxPower != null) {
      sessionMessage.maxPower = maxPower;
    }
    if (hasAscentDescent) {
      sessionMessage.totalAscent = totalAscent.round();
      sessionMessage.totalDescent = totalDescent.round();
    }
    if (startPositionLat != null && startPositionLong != null) {
      sessionMessage.startPositionLat = startPositionLat;
      sessionMessage.startPositionLong = startPositionLong;
    }
    if (necLat != null && necLong != null && swcLat != null && swcLong != null) {
      sessionMessage.necLat = necLat;
      sessionMessage.necLong = necLong;
      sessionMessage.swcLat = swcLat;
      sessionMessage.swcLong = swcLong;
    }
    builder.add(sessionMessage);

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

  static double _haversineDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const r = 6371000.0;
    final dLat = (lat2 - lat1) * math.pi / 180.0;
    final dLon = (lon2 - lon1) * math.pi / 180.0;
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1 * math.pi / 180.0) *
            math.cos(lat2 * math.pi / 180.0) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return r * c;
  }

  static _InterpolatedLocation _interpolateLocation(
    DateTime targetTime,
    List<ExerciseRouteLocation> locations,
  ) {
    if (locations.isEmpty) {
      throw StateError('locations must not be empty');
    }

    if (!targetTime.isAfter(locations.first.time)) {
      final first = locations.first;
      return _InterpolatedLocation(
        latitude: first.latitude,
        longitude: first.longitude,
        altitude: first.altitude?.inMeters,
      );
    }

    if (!targetTime.isBefore(locations.last.time)) {
      final last = locations.last;
      return _InterpolatedLocation(
        latitude: last.latitude,
        longitude: last.longitude,
        altitude: last.altitude?.inMeters,
      );
    }

    for (int i = 0; i < locations.length - 1; i++) {
      final loc1 = locations[i];
      final loc2 = locations[i + 1];
      final t1 = loc1.time;
      final t2 = loc2.time;

      if ((targetTime.isAfter(t1) || targetTime.isAtSameMomentAs(t1)) &&
          targetTime.isBefore(t2)) {
        final totalMs = t2.difference(t1).inMilliseconds;
        if (totalMs == 0) {
          return _InterpolatedLocation(
            latitude: loc1.latitude,
            longitude: loc1.longitude,
            altitude: loc1.altitude?.inMeters,
          );
        }

        final ratio = targetTime.difference(t1).inMilliseconds / totalMs;
        final lat = loc1.latitude + (loc2.latitude - loc1.latitude) * ratio;
        final lon = loc1.longitude + (loc2.longitude - loc1.longitude) * ratio;

        double? alt;
        if (loc1.altitude != null && loc2.altitude != null) {
          alt = loc1.altitude!.inMeters +
              (loc2.altitude!.inMeters - loc1.altitude!.inMeters) * ratio;
        } else if (loc1.altitude != null) {
          alt = loc1.altitude!.inMeters;
        } else if (loc2.altitude != null) {
          alt = loc2.altitude!.inMeters;
        }

        return _InterpolatedLocation(
          latitude: lat,
          longitude: lon,
          altitude: alt,
        );
      }
    }

    final last = locations.last;
    return _InterpolatedLocation(
      latitude: last.latitude,
      longitude: last.longitude,
      altitude: last.altitude?.inMeters,
    );
  }

  static _DistanceAndSpeed _interpolateDistanceAndSpeed(
    DateTime targetTime,
    List<ExerciseRouteLocation> locations,
    List<double> distances,
    List<double> speeds,
  ) {
    if (locations.isEmpty) {
      return const _DistanceAndSpeed(0.0, 0.0);
    }

    if (!targetTime.isAfter(locations.first.time)) {
      return _DistanceAndSpeed(0.0, speeds.first);
    }

    if (!targetTime.isBefore(locations.last.time)) {
      return _DistanceAndSpeed(distances.last, speeds.last);
    }

    for (int i = 0; i < locations.length - 1; i++) {
      final t1 = locations[i].time;
      final t2 = locations[i + 1].time;
      if ((targetTime.isAfter(t1) || targetTime.isAtSameMomentAs(t1)) &&
          targetTime.isBefore(t2)) {
        final totalMs = t2.difference(t1).inMilliseconds;
        if (totalMs == 0) {
          return _DistanceAndSpeed(distances[i], speeds[i]);
        }
        final ratio = targetTime.difference(t1).inMilliseconds / totalMs;
        final dist = distances[i] + (distances[i + 1] - distances[i]) * ratio;
        final spd = speeds[i] + (speeds[i + 1] - speeds[i]) * ratio;
        return _DistanceAndSpeed(dist, spd);
      }
    }

    return _DistanceAndSpeed(distances.last, speeds.last);
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


