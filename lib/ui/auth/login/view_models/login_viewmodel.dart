import 'package:result_dart/result_dart.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:aepyornis_app/data/repositories/auth/auth_repository.dart';

class LoginData {
  LoginData({required this.url, required this.apiKey});

  final String url;
  final String apiKey;
}

class LoginViewModel {
  LoginViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository {
    loginApi = Command.createAsync(_loginApi, initialValue: null);
  }

  final AuthRepository _authRepository;

  late Command<LoginData, Result<void>?> loginApi;

  Future<Result<void>> _loginApi(LoginData data) async {
    final result =
        await _authRepository.loginApi(apiKey: data.apiKey, url: data.url);
    return result;
  }
}
