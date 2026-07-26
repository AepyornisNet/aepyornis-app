import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/domain/models/statistics/statistics_response.dart';

abstract class StatisticsRepository {
  Future<Result<StatisticsResponse>> getStatistics({
    String? since,
    String? per,
  });

  Future<Result<List<WorkoutRecord>>> getRecords({
    String? handle,
  });
}
