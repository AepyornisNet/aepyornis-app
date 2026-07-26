import 'package:result_dart/result_dart.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:aepyornis_app/data/repositories/auth/auth_repository.dart';

enum AuthMode { emailPassword, apiKey }

class LoginData {
  LoginData({
    required this.url,
    this.email,
    this.password,
    this.apiKey,
    this.authMode = AuthMode.emailPassword,
  });

  final String url;
  final String? email;
  final String? password;
  final String? apiKey;
  final AuthMode authMode;
}

class LoginViewModel {
  LoginViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository {
    loginApi = Command.createAsync(_loginApi, initialValue: null);
  }

  final AuthRepository _authRepository;

  late Command<LoginData, Result<void>?> loginApi;

  Future<Result<void>> _loginApi(LoginData data) async {
    if (data.authMode == AuthMode.emailPassword) {
      return await _authRepository.loginEmailPassword(
        url: data.url,
        email: data.email ?? '',
        password: data.password ?? '',
      );
    } else {
      return await _authRepository.loginApi(
        apiKey: data.apiKey ?? '',
        url: data.url,
      );
    }
  }
}
