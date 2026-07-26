import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/domain/models/measurement/measurement.dart';

abstract class MeasurementRepository {
  // Returns the [Measurement] for the given [date]
  Future<Result<Measurement>> getMeasurement({required DateTime date});

  // Returns all [Measurement]s optionally filtered by [startDate] and [endDate]
  Future<Result<List<Measurement>>> getMeasurementsBetween({
    DateTime startDate,
    DateTime endDate,
  });

  Future<Result<void>> upsertMeasurement({
    required DateTime date,
    int? steps,
    double? weightKg,
    double? heightCm,
    int? restingHeartRate,
  });

  // Fetches the full [Measurement] list from the server and updates the local cache
  Future<Result<void>> updateMeasurements();
}
