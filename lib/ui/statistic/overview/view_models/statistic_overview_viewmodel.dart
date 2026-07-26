import 'package:flutter/foundation.dart';
import 'package:aepyornis_app/data/repositories/statistics/statistics_repository.dart';
import 'package:aepyornis_app/domain/models/statistics/statistics_response.dart';

class StatisticOverviewViewModel extends ChangeNotifier {
  StatisticOverviewViewModel({
    required StatisticsRepository statisticsRepository,
  }) : _statisticsRepository = statisticsRepository;

  final StatisticsRepository _statisticsRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  StatisticsResponse? _statistics;
  StatisticsResponse? get statistics => _statistics;

  List<WorkoutRecord> _records = [];
  List<WorkoutRecord> get records => _records;

  String _since = '1 year';
  String get since => _since;

  String _per = 'month';
  String get per => _per;

  String _workoutType = 'all';
  String get workoutType => _workoutType;

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  void setSelectedTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  void setWorkoutType(String type) {
    if (type != _workoutType) {
      _workoutType = type;
      notifyListeners();
    }
  }

  void setFilter({String? since, String? per}) {
    var changed = false;
    if (since != null && since != _since) {
      _since = since;
      changed = true;
    }
    if (per != null && per != _per) {
      _per = per;
      changed = true;
    }
    if (changed) {
      notifyListeners();
      loadStatistics();
    }
  }

  Future<void> loadData() async {
    await Future.wait([
      loadStatistics(),
      loadRecords(),
    ]);
  }

  Future<void> loadStatistics() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _statisticsRepository.getStatistics(
      since: _since,
      per: _per,
    );

    result.fold(
      (data) {
        _statistics = data;
        _isLoading = false;
        notifyListeners();
      },
      (error) {
        _errorMessage = error.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> loadRecords() async {
    final result = await _statisticsRepository.getRecords();

    result.fold(
      (recordsData) {
        _records = recordsData;
        notifyListeners();
      },
      (error) {
        // Silently preserve previous records if fail
      },
    );
  }
}
