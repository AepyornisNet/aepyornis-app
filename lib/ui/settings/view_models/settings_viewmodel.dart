import 'dart:async';

import 'package:flutter_command/flutter_command.dart';
import 'package:intl/intl.dart';
import 'package:result_dart/result_dart.dart';
import 'package:workout_tracker_app/data/repositories/auth/auth_repository.dart';
import 'package:workout_tracker_app/data/repositories/measurement/measurement_repository.dart';
import 'package:workout_tracker_app/data/services/health_connect/health_connect_service.dart';
import 'package:workout_tracker_app/data/services/shared_preferences_service.dart';
import 'package:workout_tracker_app/domain/models/measurement/measurement.dart';

class SettingsViewModel {
  SettingsViewModel({
    required AuthRepository authRepository,
    required SharedPreferencesService sharedPreferencesService,
    required HealthConnectService healthConnectService,
    required MeasurementRepository measurementRepository,
  })  : _authRepository = authRepository,
        _sharedPreferencesService = sharedPreferencesService,
        _healthConnectService = healthConnectService,
        _measurementRepository = measurementRepository,
        _isoDateFormatter = DateFormat('yyyy-MM-dd') {
    logout = Command.createAsyncNoParam(_logout, initialValue: null);
    connectHealth =
        Command.createAsyncNoParam(_connectHealth, initialValue: null);
    syncHealthMeasurements =
        Command.createAsync(_syncHealthMeasurements, initialValue: null);
  }

  final AuthRepository _authRepository;
  final SharedPreferencesService _sharedPreferencesService;
  final HealthConnectService _healthConnectService;
  final MeasurementRepository _measurementRepository;
  final DateFormat _isoDateFormatter;

  late Command<void, Result<void>?> logout;
  late Command<void, bool?> connectHealth;
  late Command<int, Result<int>?> syncHealthMeasurements;

  Future<Result<void>?> _logout() async {
    return await _authRepository.logout();
  }

  Future<bool> _connectHealth() async {
    final ready = await _healthConnectService.isReady();
    if (!ready) {
      await _sharedPreferencesService.setSyncHealthConnect(false);
      return false;
    }

    final alreadyGranted = await _healthConnectService.hasPermissions();
    if (alreadyGranted) {
      await _sharedPreferencesService.setSyncHealthConnect(true);
      return true;
    }

    final granted = await _healthConnectService.requestPermissions();
    await _sharedPreferencesService.setSyncHealthConnect(granted);
    return granted;
  }

  Future<Result<int>> _syncHealthMeasurements(int days) async {
    if (days <= 0) {
      return Failure(Exception('invalid_days'));
    }

    final ready = await _healthConnectService.isReady();
    if (!ready) {
      await _sharedPreferencesService.setSyncHealthConnect(false);
      return Failure(Exception('health_connect_unavailable'));
    }

    var hasPermissions = await _healthConnectService.hasPermissions();
    if (!hasPermissions) {
      hasPermissions = await _healthConnectService.requestPermissions();
    }
    if (!hasPermissions) {
      await _sharedPreferencesService.setSyncHealthConnect(false);
      return Failure(Exception('health_connect_permissions_denied'));
    }

    List<Measurement> existingMeasurements;
    try {
      final existingResult =
          await _measurementRepository.getMeasurementsBetween();
      existingMeasurements = existingResult.getOrThrow();
    } on Exception catch (e) {
      return Failure(e);
    }

    final existingDates = existingMeasurements.map((m) => m.date).toSet();
    final today = DateTime.now();
    final startOfToday = DateTime(today.year, today.month, today.day);

    var syncedCount = 0;
    for (int offset = 0; offset < days; offset++) {
      final date = startOfToday.subtract(Duration(days: offset));
      final dateKey = _isoDateFormatter.format(date);
      if (existingDates.contains(dateKey)) {
        continue;
      }

      final metrics = await _healthConnectService.readDailyMetrics(date);
      if (metrics == null || _isMetricsEmpty(metrics)) {
        continue;
      }

      final upsertResult = await _measurementRepository.upsertMeasurement(
        date: metrics.date,
        steps: metrics.steps > 0 ? metrics.steps : null,
        weightKg: metrics.weightKg,
        heightCm: metrics.heightCm,
        restingHeartRate: metrics.restingHeartRateBpm,
      );

      try {
        upsertResult.getOrThrow();
        syncedCount++;
        existingDates.add(dateKey);
      } on Exception catch (e) {
        return Failure(e);
      }
    }

    unawaited(_measurementRepository.updateMeasurements());

    return Success(syncedCount);
  }

  bool _isMetricsEmpty(DailyHealthMetrics metrics) {
    return metrics.steps <= 0 &&
        metrics.weightKg == null &&
        metrics.heightCm == null &&
        metrics.restingHeartRateBpm == null;
  }
}
