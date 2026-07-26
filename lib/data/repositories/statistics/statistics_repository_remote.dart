import 'package:result_dart/result_dart.dart';
import 'package:workout_tracker_app/data/repositories/statistics/statistics_repository.dart';
import 'package:workout_tracker_app/data/services/api/api_client.dart';
import 'package:workout_tracker_app/domain/models/statistics/statistics_response.dart';

class StatisticsRepositoryRemote implements StatisticsRepository {
  StatisticsRepositoryRemote({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<Result<StatisticsResponse>> getStatistics({
    String? since,
    String? per,
  }) {
    return _apiClient.getStatistics(since: since, per: per);
  }

  @override
  Future<Result<List<WorkoutRecord>>> getRecords({
    String? handle,
  }) {
    return _apiClient.getRecords(handle: handle);
  }
}
