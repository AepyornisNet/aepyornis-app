import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/domain/models/user/user.dart';

abstract class AuthRepository extends ChangeNotifier {
  /// Returns true when the user is logged in
  /// Returns [Future] because it will load a stored auth state the first time.
  Future<bool> get isAuthenticated;

  User? get currentUser;

  Future<Result<void>> loginApi({required String url, required String apiKey});

  Future<Result<void>> logout();
}
