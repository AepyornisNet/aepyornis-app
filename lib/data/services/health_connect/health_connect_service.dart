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

  static final List<HealthDataPermission> _requiredPermissions =
      <HealthDataPermission>[
    HealthDataPermission.read(HealthDataType.steps),
    HealthDataPermission.read(HealthDataType.weight),
    HealthDataPermission.read(HealthDataType.height),
    HealthDataPermission.read(HealthDataType.restingHeartRate),
  ];

  static const Duration _weightFallbackWindow = Duration(days: 30);
  static const Duration _heightFallbackWindow = Duration(days: 365);
  static const Duration _restingHeartRateFallbackWindow = Duration(days: 7);

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
      for (final permission in _requiredPermissions) {
        final status = await connector.getPermissionStatus(permission);
        if (status != PermissionStatus.granted) {
          return false;
        }
      }
      return true;
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
      final results = await connector.requestPermissions(_requiredPermissions);
      return results.every((result) => result.status == PermissionStatus.granted);
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
