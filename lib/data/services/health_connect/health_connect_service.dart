import 'dart:io';

import 'package:health_connector/health_connector.dart';

class DailyHealthMetrics {
  const DailyHealthMetrics({
    required this.date,
    required this.steps,
    this.weightKg,
    this.heightCm,
    this.restingHeartRateBpm,
  });

  final DateTime date;
  final int steps;
  final double? weightKg;
  final double? heightCm;
  final int? restingHeartRateBpm;
}

class HealthConnectService {
  HealthConnectService({HealthConnector? connector}) : _connector = connector;

  HealthConnector? _connector;

  static const Duration _weightFallbackWindow = Duration(days: 30);
  static const Duration _heightFallbackWindow = Duration(days: 365);
  static const Duration _restingHeartRateFallbackWindow = Duration(days: 7);

  List<HealthDataPermission> get _platformPermissions {
    final currentPlatform = Platform.isIOS
        ? HealthPlatform.appleHealth
        : HealthPlatform.healthConnect;

    final candidates = <HealthDataType>[
      HealthDataType.steps,
      HealthDataType.weight,
      HealthDataType.height,
      HealthDataType.restingHeartRate,
      HealthDataType.exerciseSession,
      HealthDataType.heartRate,
      HealthDataType.heartRateSeries,
      HealthDataType.cyclingPedalingCadenceSeries,
      HealthDataType.stepsCadenceSeries,
      HealthDataType.powerSeries,
      HealthDataType.cyclingPower,
    ];

    return candidates
        .where((type) => type.supportedHealthPlatforms.contains(currentPlatform))
        .map((type) => HealthDataPermission.read(type))
        .toList();
  }

  Future<HealthConnector?> _ensureConnector() async {
    if (_connector != null) {
      return _connector;
    }

    try {
      _connector = await HealthConnector.create();
      return _connector;
    } catch (_) {
      return null;
    }
  }

  Future<bool> isReady() async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      return false;
    }

    try {
      final status = await HealthConnector.getHealthPlatformStatus();
      return status == HealthPlatformStatus.available;
    } catch (_) {
      return false;
    }
  }

  Future<bool> hasPermissions() async {
    if (!await isReady()) {
      return false;
    }

    final connector = await _ensureConnector();
    if (connector == null) {
      return false;
    }

    try {
      final permissions = _platformPermissions;
      for (final permission in permissions) {
        final status = await connector.getPermissionStatus(permission);
        if (status == PermissionStatus.granted) {
          return true;
        }
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> requestPermissions() async {
    if (!await isReady()) {
      return false;
    }

    final connector = await _ensureConnector();
    if (connector == null) {
      return false;
    }

    try {
      final permissions = [
        ..._platformPermissions,
        HealthDataType.exerciseSession.readExerciseRoutePermission,
      ];
      final results = await connector.requestPermissions(permissions);
      return results.any((result) => result.status == PermissionStatus.granted);
    } catch (_) {
      return false;
    }
  }

  Future<DailyHealthMetrics?> readDailyMetrics(DateTime date) async {
    final connector = await _ensureConnector();
    if (connector == null) {
      return null;
    }

    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final steps = await _readSteps(connector, startOfDay, endOfDay);

    final restingHeartRate = await _readRestingHeartRate(
      connector,
      startOfDay.subtract(_restingHeartRateFallbackWindow),
      endOfDay,
    );

    final weightKg = await _readWeight(
      connector,
      startOfDay.subtract(_weightFallbackWindow),
      endOfDay,
    );

    final heightMeters = await _readHeight(
      connector,
      endOfDay.subtract(_heightFallbackWindow),
      endOfDay,
    );

    return DailyHealthMetrics(
      date: startOfDay,
      steps: steps,
      weightKg: weightKg,
      heightCm: heightMeters != null ? heightMeters * 100 : null,
      restingHeartRateBpm: restingHeartRate,
    );
  }

  Future<List<ExerciseSessionRecord>> readExerciseSessions({
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    final connector = await _ensureConnector();
    if (connector == null) {
      return [];
    }

    final end = endTime ?? DateTime.now();
    final start = startTime ?? end.subtract(const Duration(days: 90));

    try {
      final request = HealthDataType.exerciseSession.readInTimeRange(
        startTime: start,
        endTime: end,
      );
      final response = await connector.readRecords(request);
      final records = response.records;
      records.sort((a, b) => b.startTime.compareTo(a.startTime));
      return records;
    } catch (_) {
      return [];
    }
  }

  Future<ExerciseRoute?> readExerciseRoute(HealthRecordId sessionId) async {
    final connector = await _ensureConnector();
    if (connector == null) {
      return null;
    }

    try {
      return await connector.readExerciseRoute(sessionId);
    } catch (_) {
      return null;
    }
  }

  Future<Map<DateTime, int>> readHeartRates(
    DateTime startTime,
    DateTime endTime,
  ) async {
    final connector = await _ensureConnector();
    if (connector == null) {
      return {};
    }

    final Map<DateTime, int> result = {};

    try {
      if (Platform.isAndroid) {
        final request = HealthDataType.heartRateSeries.readInTimeRange(
          startTime: startTime,
          endTime: endTime,
        );
        final response = await connector.readRecords(request);
        for (final series in response.records) {
          for (final sample in series.samples) {
            result[sample.time] = sample.rate.inPerMinute.round();
          }
        }
      } else {
        final request = HealthDataType.heartRate.readInTimeRange(
          startTime: startTime,
          endTime: endTime,
        );
        final response = await connector.readRecords(request);
        for (final record in response.records) {
          result[record.time] = record.rate.inPerMinute.round();
        }
      }
    } catch (_) {}

    return result;
  }

  Future<Map<DateTime, int>> readCadence(
    DateTime startTime,
    DateTime endTime,
  ) async {
    final connector = await _ensureConnector();
    if (connector == null) {
      return {};
    }

    final Map<DateTime, int> result = {};

    try {
      final request = HealthDataType.cyclingPedalingCadenceSeries.readInTimeRange(
        startTime: startTime,
        endTime: endTime,
      );
      final response = await connector.readRecords(request);
      for (final series in response.records) {
        for (final sample in series.samples) {
          result[sample.time] = sample.cadence.inPerMinute.round();
        }
      }
    } catch (_) {}

    try {
      final request = HealthDataType.stepsCadenceSeries.readInTimeRange(
        startTime: startTime,
        endTime: endTime,
      );
      final response = await connector.readRecords(request);
      for (final series in response.records) {
        for (final sample in series.samples) {
          result[sample.time] = sample.cadence.inPerMinute.round();
        }
      }
    } catch (_) {}

    return result;
  }

  Future<Map<DateTime, double>> readPower(
    DateTime startTime,
    DateTime endTime,
  ) async {
    final connector = await _ensureConnector();
    if (connector == null) {
      return {};
    }

    final Map<DateTime, double> result = {};

    try {
      final request = HealthDataType.powerSeries.readInTimeRange(
        startTime: startTime,
        endTime: endTime,
      );
      final response = await connector.readRecords(request);
      for (final series in response.records) {
        for (final sample in series.samples) {
          result[sample.time] = sample.power.inWatts;
        }
      }
    } catch (_) {}

    try {
      final request = HealthDataType.cyclingPower.readInTimeRange(
        startTime: startTime,
        endTime: endTime,
      );
      final response = await connector.readRecords(request);
      for (final record in response.records) {
        result[record.time] = record.power.inWatts;
      }
    } catch (_) {}

    return result;
  }

  Future<int> _readSteps(
    HealthConnector connector,
    DateTime start,
    DateTime end,
  ) async {
    try {
      final request = HealthDataType.steps.aggregateSum(
        startTime: start,
        endTime: end,
      );
      final response = await connector.aggregate(request);
      final stepsValue = response.value.toDouble();
      if (stepsValue.isNaN || stepsValue.isInfinite) {
        return 0;
      }
      return stepsValue.round();
    } catch (_) {
      return 0;
    }
  }

  Future<double?> _readWeight(
    HealthConnector connector,
    DateTime start,
    DateTime end,
  ) async {
    try {
      final request = HealthDataType.weight.readInTimeRange(
        startTime: start,
        endTime: end,
      );
      final response = await connector.readRecords(request);
      final records = response.records;
      if (records.isEmpty) {
        return null;
      }
      records.sort((a, b) => b.time.compareTo(a.time));
      return records.first.weight.inKilograms;
    } catch (_) {
      return null;
    }
  }

  Future<double?> _readHeight(
    HealthConnector connector,
    DateTime start,
    DateTime end,
  ) async {
    try {
      final request = HealthDataType.height.readInTimeRange(
        startTime: start,
        endTime: end,
      );
      final response = await connector.readRecords(request);
      final records = response.records;
      if (records.isEmpty) {
        return null;
      }
      records.sort((a, b) => b.time.compareTo(a.time));
      return records.first.height.inMeters;
    } catch (_) {
      return null;
    }
  }

  Future<int?> _readRestingHeartRate(
    HealthConnector connector,
    DateTime start,
    DateTime end,
  ) async {
    try {
      final request = HealthDataType.restingHeartRate.readInTimeRange(
        startTime: start,
        endTime: end,
      );
      final response = await connector.readRecords(request);
      final records = response.records;
      if (records.isEmpty) {
        return null;
      }
      records.sort((a, b) => b.time.compareTo(a.time));
      return records.first.rate.inPerMinute.round();
    } catch (_) {
      return null;
    }
  }
}
