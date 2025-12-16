import 'package:result_dart/result_dart.dart';

abstract class ApiResponse<T> {
  static const String _jsonNodeResults = "results";
  static const String _jsonNodeErrors = "errors";

  static ResultDart<T, List<String>> fromJson<T extends Object, U>(
    Map<String, dynamic> json,
    T Function(U) mapper,
  ) {
    final errors = json[_jsonNodeErrors];
    if (errors is List && errors.isNotEmpty) {
      return Failure(errors.cast<String>());
    } else if (json[_jsonNodeResults] != null) {
      return Success(mapper(json[_jsonNodeResults]));
    } else {
      return Failure(["Invalid response"]);
    }
  }
}
