import 'dart:io';

import 'package:health/health.dart';

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
  HealthConnectService({Health? health}) : _health = health ?? Health();

  final Health _health;
  bool _configured = false;

  static final List<HealthDataType> _requiredTypes = <HealthDataType>[
    HealthDataType.STEPS,
    HealthDataType.WEIGHT,
    HealthDataType.HEIGHT,
    HealthDataType.RESTING_HEART_RATE,
  ];

  static final List<HealthDataAccess> _requiredPermissions =
      List<HealthDataAccess>.filled(
          _requiredTypes.length, HealthDataAccess.READ);

  static const Duration _weightFallbackWindow = Duration(days: 30);
  static const Duration _heightFallbackWindow = Duration(days: 365);
  static const Duration _restingHeartRateFallbackWindow = Duration(days: 7);

  Future<bool> isReady() async => Platform.isAndroid || Platform.isIOS;

  Future<void> _ensureConfigured() async {
    if (_configured) {
      return;
    }

    try {
      await _health.configure();
      _configured = true;
    } catch (_) {
      // Swallow errors; downstream permission checks will fail gracefully.
    }
  }

  Future<bool> hasPermissions() async {
    if (!await isReady()) {
      return false;
    }

    await _ensureConfigured();

    try {
      final hasPermission = await _health.hasPermissions(
        _requiredTypes,
        permissions: _requiredPermissions,
      );

      return hasPermission ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> requestPermissions() async {
    if (!await isReady()) {
      return false;
    }

    await _ensureConfigured();

    final alreadyGranted = await hasPermissions();
    if (alreadyGranted) {
      return true;
    }

    try {
      return await _health.requestAuthorization(
        _requiredTypes,
        permissions: _requiredPermissions,
      );
    } catch (_) {
      return false;
    }
  }

  Future<DailyHealthMetrics?> readDailyMetrics(DateTime date) async {
    await _ensureConfigured();

    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final steps = await _readSteps(startOfDay, endOfDay);

    final restingHeartRate = await _readLatestIntValue(
      type: HealthDataType.RESTING_HEART_RATE,
      start: startOfDay.subtract(_restingHeartRateFallbackWindow),
      end: endOfDay,
    );

    final weightKg = await _readLatestDoubleValue(
      type: HealthDataType.WEIGHT,
      start: startOfDay,
      end: endOfDay,
      fallback: _weightFallbackWindow,
    );

    final heightMeters = await _readLatestDoubleValue(
      type: HealthDataType.HEIGHT,
      start: endOfDay.subtract(_heightFallbackWindow),
      end: endOfDay,
    );

    return DailyHealthMetrics(
      date: startOfDay,
      steps: steps,
      weightKg: weightKg,
      heightCm: heightMeters != null ? heightMeters * 100 : null,
      restingHeartRateBpm: restingHeartRate,
    );
  }

  Future<int> _readSteps(DateTime start, DateTime end) async {
    try {
      final totalSteps = await _health.getTotalStepsInInterval(start, end);
      if (totalSteps == null) {
        return 0;
      }

      final steps = totalSteps.toDouble();
      if (steps.isNaN || steps.isInfinite) {
        return 0;
      }

      return steps.round();
    } catch (_) {
      return 0;
    }
  }

  Future<int?> _readLatestIntValue({
    required HealthDataType type,
    required DateTime start,
    required DateTime end,
    Duration? fallback,
  }) async {
    final value = await _readLatestDoubleValue(
      type: type,
      start: start,
      end: end,
      fallback: fallback,
    );
    return value?.round();
  }

  Future<double?> _readLatestDoubleValue({
    required HealthDataType type,
    required DateTime start,
    required DateTime end,
    Duration? fallback,
  }) async {
    var point = await _latestDataPoint(type: type, start: start, end: end);
    if (point == null && fallback != null) {
      point = await _latestDataPoint(
        type: type,
        start: end.subtract(fallback),
        end: end,
      );
    }

    final value = point?.value;
    if (value is NumericHealthValue) {
      final numericValue = value.numericValue.toDouble();
      if (numericValue.isFinite) {
        return numericValue;
      }
    }

    return null;
  }

  Future<HealthDataPoint?> _latestDataPoint({
    required HealthDataType type,
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      final dataPoints = await _health.getHealthDataFromTypes(
        types: [type],
        startTime: start,
        endTime: end,
      );
      if (dataPoints.isEmpty) {
        return null;
      }

      dataPoints.sort((a, b) {
        final aDate = a.dateTo;
        final bDate = b.dateTo;
        return bDate.compareTo(aDate);
      });

      return dataPoints.first;
    } catch (_) {
      return null;
    }
  }
}
