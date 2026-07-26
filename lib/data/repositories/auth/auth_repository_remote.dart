import 'dart:io';

import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/data/services/api/api_client.dart';
import 'package:aepyornis_app/data/services/shared_preferences_service.dart';
import 'package:aepyornis_app/domain/models/user/user.dart';

import 'auth_repository.dart';

class AuthRepositoryRemote extends AuthRepository {
  AuthRepositoryRemote({
    required ApiClient apiClient,
    required SharedPreferencesService sharedPreferencesService,
  })  : _sharedPreferencesService = sharedPreferencesService,
        _apiClient = apiClient {
    apiClient.authHeaderProvider = _authHeaderProvider;
    apiClient.apiUrlProvider = _apiUrlProvider;
  }

  final SharedPreferencesService _sharedPreferencesService;
  final ApiClient _apiClient;

  bool? _isAuthenticated;
  String? _authToken;
  String? _url;
  User? _currentUser;

  @override
  User? get currentUser {
    return _currentUser;
  }

  @override
  Future<bool> get isAuthenticated async {
    if (_isAuthenticated != null) {
      return _isAuthenticated!;
    }

    final apiKey = await _sharedPreferencesService.getApiKey();
    if (apiKey == null) {
      return false;
    }

    final url = await _sharedPreferencesService.getUrl();
    if (url == null) {
      return false;
    }

    _authToken = apiKey;
    _url = url;
    try {
      _isAuthenticated = await _fetchUser();
    } catch (e) {
      _isAuthenticated = true;
    }

    return _isAuthenticated ?? false;
  }

  @override
  Future<Result<void>> loginApi({
    required String url,
    required String apiKey,
  }) async {
    try {
      await _sharedPreferencesService.setUrl(url);
      await _sharedPreferencesService.setApiKey(apiKey);
      _authToken = apiKey;
      _url = url;
      if (await _fetchUser()) {
        _isAuthenticated = true;
        notifyListeners();
        return Success(0);
      } else {
        return Failure(Exception('Failed to authenticate'));
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<void>> loginEmailPassword({
    required String url,
    required String email,
    required String password,
  }) async {
    try {
      await _sharedPreferencesService.setUrl(url);
      _url = url;

      final tokenResult =
          await _apiClient.signIn(email: email, password: password);
      if (tokenResult.isError()) {
        return Failure(
          tokenResult.exceptionOrNull() ?? Exception('Sign in failed'),
        );
      }

      final token = tokenResult.getOrNull()!;
      await _sharedPreferencesService.setApiKey(token);
      _authToken = token;

      if (await _fetchUser()) {
        _isAuthenticated = true;
        notifyListeners();
        return Success(0);
      } else {
        return Failure(Exception('Failed to fetch user profile'));
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _sharedPreferencesService.setApiKey(null);
      await _sharedPreferencesService.setUrl(null);
      _isAuthenticated = false;
      _authToken = null;
      _url = null;
      _currentUser = null;
      notifyListeners();
      return Success(0);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<bool> _fetchUser() async {
    final result = await _apiClient.whoAmI();

    if (result.isError()) {
      final e = result.exceptionOrNull();
      if (e is HttpException) {
        if (e.message == 'Unauthorized') {
          return false;
        }
      }

      throw e ?? Exception('Unknown error');
    }

    _currentUser = result.getOrNull();
    return true;
  }

  String? _authHeaderProvider() =>
      _authToken != null ? 'Bearer $_authToken' : null;

  String? _apiUrlProvider() => _url;
}
