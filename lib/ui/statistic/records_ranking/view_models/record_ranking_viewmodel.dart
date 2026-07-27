import 'package:flutter/foundation.dart';
import 'package:aepyornis_app/data/repositories/statistics/statistics_repository.dart';
import 'package:aepyornis_app/domain/models/statistics/statistics_response.dart';

class RecordRankingViewModel extends ChangeNotifier {
  RecordRankingViewModel({
    required StatisticsRepository statisticsRepository,
    required this.workoutType,
    required this.label,
  }) : _statisticsRepository = statisticsRepository {
    loadRanking();
  }

  final StatisticsRepository _statisticsRepository;
  final String workoutType;
  final String label;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _hasLoaded = false;
  bool get hasLoaded => _hasLoaded;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<DistanceRecordEntry> _entries = [];
  List<DistanceRecordEntry> get entries => _entries;

  Future<void> loadRanking() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _statisticsRepository.getDistanceRecordRanking(
      workoutType: workoutType,
      label: label,
    );

    result.fold(
      (data) {
        _entries = data;
        _isLoading = false;
        _hasLoaded = true;
        notifyListeners();
      },
      (error) {
        _errorMessage = error.toString();
        _isLoading = false;
        _hasLoaded = true;
        notifyListeners();
      },
    );
  }
}
