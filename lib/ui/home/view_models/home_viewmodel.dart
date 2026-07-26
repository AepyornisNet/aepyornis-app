import 'package:flutter/foundation.dart';
import 'package:aepyornis_app/data/repositories/auth/auth_repository.dart';
import 'package:aepyornis_app/data/repositories/measurement/measurement_repository.dart';
import 'package:aepyornis_app/data/repositories/workout/workout_repository.dart';
import 'package:aepyornis_app/data/services/health_connect/health_connect_service.dart';
import 'package:aepyornis_app/data/services/shared_preferences_service.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';
import 'package:aepyornis_app/domain/models/workout_reply/workout_reply.dart';

import 'package:aepyornis_app/data/services/api/api_client.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required AuthRepository authRepository,
    required MeasurementRepository measurementRepository,
    required SharedPreferencesService sharedPreferencesService,
    required HealthConnectService healthConnectService,
    required WorkoutRepository workoutRepository,
    required ApiClient apiClient,
  })  : _authRepository = authRepository,
        _sharedPreferencesService = sharedPreferencesService,
        _healthConnectService = healthConnectService,
        _workoutRepository = workoutRepository,
        _apiClient = apiClient {
    loadInitialFeed();
  }

  final AuthRepository _authRepository;
  final SharedPreferencesService _sharedPreferencesService;
  final HealthConnectService _healthConnectService;
  final WorkoutRepository _workoutRepository;
  final ApiClient _apiClient;

  String? resolveUrl(String? path) => _apiClient.resolveUrl(path);

  Map<String, String> get authHeaders => _apiClient.authHeaders;

  bool isOwnWorkout(Workout workout) {
    final current = _authRepository.currentUser;
    if (current == null) return false;
    if (workout.userID != null && current.id != null) {
      return workout.userID == current.id;
    }
    if (workout.user != null &&
        current.id != null &&
        workout.user!.id != null) {
      return workout.user!.id == current.id;
    }
    if (workout.user != null && current.username.isNotEmpty) {
      return workout.user!.username == current.username;
    }
    return false;
  }

  double savedScrollOffset = 0.0;

  String _feedScope = 'following'; // 'following' | 'global'
  String get feedScope => _feedScope;

  List<Workout> _workouts = [];
  List<Workout> get workouts => _workouts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final Map<int, List<WorkoutReply>> _workoutReplies = {};
  Map<int, List<WorkoutReply>> get workoutReplies => _workoutReplies;

  final Map<int, bool> _loadingReplies = {};
  Map<int, bool> get loadingReplies => _loadingReplies;

  final Map<int, bool> _likingState = {};
  Map<int, bool> get likingState => _likingState;

  final Map<int, bool> _replyingState = {};
  Map<int, bool> get replyingState => _replyingState;

  Future<void> setFeedScope(String scope) async {
    if (_feedScope == scope) return;
    _feedScope = scope;
    notifyListeners();
    await loadInitialFeed();
  }

  Future<void> loadInitialFeed() async {
    _isLoading = true;
    _errorMessage = null;
    _workouts = [];
    _hasMore = true;
    savedScrollOffset = 0.0;
    notifyListeners();

    final result = await _workoutRepository.getRecentWorkouts(
      limit: 10,
      offset: 0,
      scope: _feedScope,
    );

    result.fold(
      (data) {
        _workouts = List.from(data);
        _hasMore = data.length == 10;
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

  Future<void> loadMoreFeed() async {
    if (_isLoading || _isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    notifyListeners();

    final currentOffset = _workouts.length;
    final result = await _workoutRepository.getRecentWorkouts(
      limit: 10,
      offset: currentOffset,
      scope: _feedScope,
    );

    result.fold(
      (data) {
        if (data.isNotEmpty) {
          _workouts.addAll(data);
          _hasMore = data.length == 10;
        } else {
          _hasMore = false;
        }
        _isLoadingMore = false;
        notifyListeners();
      },
      (error) {
        _hasMore = false;
        _isLoadingMore = false;
        notifyListeners();
      },
    );
  }

  Future<void> toggleLike(Workout workout) async {
    if (workout.id == null || _likingState[workout.id] == true) return;

    final id = workout.id!;
    _likingState[id] = true;
    notifyListeners();

    final result = await _workoutRepository.likeWorkout(id);

    result.fold(
      (res) {
        final liked = res['liked'] == true;
        final likesCount = (res['likes_count'] as num?)?.toInt() ??
            (liked
                ? workout.likesCount + 1
                : (workout.likesCount > 0 ? workout.likesCount - 1 : 0));

        final index = _workouts.indexWhere((w) => w.id == id);
        if (index >= 0) {
          _workouts[index] = _workouts[index].copyWith(
            likedByMe: liked,
            likesCount: likesCount,
          );
        }
      },
      (error) {
        // failed
      },
    );

    _likingState[id] = false;
    notifyListeners();
  }

  Future<void> loadReplies(int workoutId) async {
    _loadingReplies[workoutId] = true;
    notifyListeners();

    final result = await _workoutRepository.getWorkoutReplies(workoutId);
    result.fold(
      (replies) {
        _workoutReplies[workoutId] = replies;
      },
      (error) {
        _workoutReplies[workoutId] = [];
      },
    );

    _loadingReplies[workoutId] = false;
    notifyListeners();
  }

  Future<bool> postReply(int workoutId, String content) async {
    if (content.trim().isEmpty || _replyingState[workoutId] == true) {
      return false;
    }

    _replyingState[workoutId] = true;
    notifyListeners();

    final result =
        await _workoutRepository.createReply(workoutId, content.trim());
    bool success = false;

    result.fold(
      (newReply) {
        final currentReplies = _workoutReplies[workoutId] ?? [];
        _workoutReplies[workoutId] = [newReply, ...currentReplies];

        final index = _workouts.indexWhere((w) => w.id == workoutId);
        if (index >= 0) {
          _workouts[index] = _workouts[index].copyWith(
            repliesCount: _workouts[index].repliesCount + 1,
          );
        }
        success = true;
      },
      (error) {
        success = false;
      },
    );

    _replyingState[workoutId] = false;
    notifyListeners();
    return success;
  }

  Future<void> requestPermissions() async {
    if (!await _sharedPreferencesService.getSyncHealthConnect()) {
      return;
    }

    final granted = await _healthConnectService.requestPermissions();
    if (!granted) {
      await _sharedPreferencesService.setSyncHealthConnect(false);
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }
}
