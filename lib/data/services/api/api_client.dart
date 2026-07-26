import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:result_dart/result_dart.dart';
import 'package:workout_tracker_app/data/services/api/model/api_response/api_response.dart';
import 'package:workout_tracker_app/domain/models/measurement/measurement.dart';
import 'package:workout_tracker_app/domain/models/statistics/statistics_response.dart';
import 'package:workout_tracker_app/domain/models/user/user.dart';
import 'package:workout_tracker_app/domain/models/workout/workout.dart';
import 'package:workout_tracker_app/domain/models/workout_reply/workout_reply.dart';

typedef AuthHeaderProvider = String? Function();
typedef ApiUrlProvider = String? Function();

class ApiClient {
  ApiClient({
    String? base,
  });

  AuthHeaderProvider? _authHeaderProvider;
  ApiUrlProvider? _apiUrlProvider;

  set apiUrlProvider(ApiUrlProvider value) {
    _apiUrlProvider = value;
  }

  set authHeaderProvider(AuthHeaderProvider value) {
    _authHeaderProvider = value;
  }

  Map<String, String> get authHeaders {
    final headers = <String, String>{};
    final authHeader = _authHeaderProvider?.call();
    if (authHeader != null) {
      headers[HttpHeaders.authorizationHeader] = authHeader;
    }
    return headers;
  }

  String? resolveUrl(String? path) {
    if (path == null || path.isEmpty) return null;
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    final base = _apiUrlProvider?.call();
    if (base == null || base.isEmpty) return path;
    final cleanBase =
        base.endsWith('/') ? base.substring(0, base.length - 1) : base;
    final cleanPath = path.startsWith('/') ? path : '/$path';
    return '$cleanBase$cleanPath';
  }

  Uri _url(String path) {
    final base = _apiUrlProvider?.call();
    if (base == null) {
      throw Exception('Base URL is not set');
    }

    return Uri.parse('$base$path');
  }

  Future<Map<String, String>> _headers() async {
    final headers = <String, String>{};
    final authHeader = _authHeaderProvider?.call();
    if (authHeader != null) {
      headers[HttpHeaders.authorizationHeader] = authHeader;
    }

    return headers;
  }

  Future<Result<List<Measurement>>> getDailyMeasurements() async {
    try {
      final response = await http.get(_url('/api/v2/measurements'),
          headers: await _headers());
      if (response.statusCode == 200) {
        final apiResponse =
            ApiResponse.fromJson<List<Measurement>, List<dynamic>>(
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
          (results) => results
              .map((e) => Measurement.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
        try {
          final data = apiResponse.getOrThrow();
          return Success(data);
        } on Exception catch (e) {
          return Failure(e);
        }
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<void>> upsertMeasurement({
    required DateTime date,
    int? steps,
    double? weightKg,
    double? heightCm,
    int? restingHeartRate,
  }) async {
    final payload = <String, dynamic>{
      'date': date.toIso8601String().substring(0, 10),
    };

    if (steps != null) {
      payload['steps'] = steps;
    }
    if (weightKg != null) {
      payload['weight'] = weightKg;
    }
    if (heightCm != null) {
      payload['height'] = heightCm;
    }
    if (restingHeartRate != null) {
      payload['resting_heart_rate'] = restingHeartRate;
    }

    if (payload.length == 1) {
      return Failure(Exception('No measurement data supplied'));
    }

    try {
      final response = await http.post(_url('/api/v2/measurements'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            ...await _headers(),
          },
          body: jsonEncode(payload));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(0);
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<List<Workout>>> getWorkouts({int page = 1, int? limit}) async {
    try {
      final baseUri = _url('/api/v2/workouts');
      final queryParams = Map<String, String>.from(baseUri.queryParameters);
      queryParams['page'] = page.toString();
      if (limit != null) {
        queryParams['limit'] = limit.toString();
      }
      final uri = baseUri.replace(queryParameters: queryParams);

      final response = await http.get(uri, headers: await _headers());
      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        if (decoded is Map<String, dynamic>) {
          final apiResponse =
              ApiResponse.fromJson<List<Workout>, List<dynamic>>(
            decoded,
            (results) => results
                .map((e) => Workout.fromJson(e as Map<String, dynamic>))
                .toList(),
          );
          try {
            final data = apiResponse.getOrThrow();
            return Success(data);
          } on Exception catch (e) {
            return Failure(e);
          }
        } else if (decoded is List) {
          final list = decoded
              .map((e) => Workout.fromJson(e as Map<String, dynamic>))
              .toList();
          return Success(list);
        }
        return Failure(HttpException("Invalid response"));
      } else {
        return Failure(
          HttpException("Invalid response (${response.statusCode})"),
        );
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<Workout>> getWorkout(int id) async {
    try {
      final response = await http.get(_url('/api/v2/workouts/$id'),
          headers: await _headers());
      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson<Workout, dynamic>(
            jsonDecode(utf8.decode(response.bodyBytes)),
            (json) => Workout.fromJson(json));
        try {
          final data = apiResponse.getOrThrow();
          return Success(data);
        } on Exception catch (e) {
          return Failure(e);
        }
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<User>> whoAmI() async {
    try {
      final response =
          await http.get(_url('/api/v2/whoami'), headers: await _headers());
      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson<User, dynamic>(
            jsonDecode(utf8.decode(response.bodyBytes)),
            (json) => User.fromJson(json));
        try {
          final data = apiResponse.getOrThrow();
          return Success(data);
        } on Exception catch (e) {
          return Failure(e);
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        return Failure(HttpException("Unauthorized"));
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<Workout>> uploadWorkoutFile({
    required List<int> bytes,
    required String filename,
    String? type,
    String? notes,
  }) async {
    try {
      final uri = _url('/api/v2/workouts');
      final request = http.MultipartRequest('POST', uri);
      final headers = await _headers();
      request.headers.addAll(headers);

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: filename,
          contentType: MediaType('application', 'octet-stream'),
        ),
      );

      if (type != null) {
        request.fields['type'] = type;
      }
      if (notes != null) {
        request.fields['notes'] = notes;
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        if (decoded is Map<String, dynamic>) {
          final apiResponse = ApiResponse.fromJson<Object, dynamic>(
            decoded,
            (raw) => raw as Object,
          );
          try {
            final data = apiResponse.getOrThrow();
            if (data is List && data.isNotEmpty) {
              return Success(
                  Workout.fromJson(data.first as Map<String, dynamic>));
            } else if (data is Map<String, dynamic>) {
              return Success(Workout.fromJson(data));
            }
          } on Exception catch (e) {
            return Failure(e);
          }
        } else if (decoded is List && decoded.isNotEmpty) {
          return Success(
              Workout.fromJson(decoded.first as Map<String, dynamic>));
        }
        return Failure(HttpException('Unexpected response payload'));
      } else {
        return Failure(
          HttpException(
            'Invalid response (${response.statusCode}): ${response.body}',
          ),
        );
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<List<Workout>>> getRecentWorkouts({
    int limit = 10,
    int offset = 0,
    String scope = 'following',
  }) async {
    try {
      final baseUri = _url('/api/v2/workouts/recent');
      final queryParams = Map<String, String>.from(baseUri.queryParameters);
      queryParams['limit'] = limit.toString();
      queryParams['offset'] = offset.toString();
      queryParams['scope'] = scope;
      final uri = baseUri.replace(queryParameters: queryParams);

      final response = await http.get(uri, headers: await _headers());
      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        if (decoded is Map<String, dynamic>) {
          final apiResponse =
              ApiResponse.fromJson<List<Workout>, List<dynamic>>(
            decoded,
            (results) => results
                .map((e) => Workout.fromJson(e as Map<String, dynamic>))
                .toList(),
          );
          try {
            final data = apiResponse.getOrThrow();
            return Success(data);
          } on Exception catch (e) {
            return Failure(e);
          }
        } else if (decoded is List) {
          final list = decoded
              .map((e) => Workout.fromJson(e as Map<String, dynamic>))
              .toList();
          return Success(list);
        }
        return Failure(HttpException("Invalid response"));
      } else {
        return Failure(
          HttpException("Invalid response (${response.statusCode})"),
        );
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<Map<String, dynamic>>> likeWorkout(int id) async {
    try {
      final response = await http.post(
        _url('/api/v2/workouts/$id/like'),
        headers: await _headers(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        if (decoded is Map<String, dynamic> && decoded.containsKey('results')) {
          final results = decoded['results'];
          if (results is Map<String, dynamic>) {
            return Success(results);
          }
        }
        return Success({'liked': true});
      } else {
        return Failure(
          HttpException("Invalid response (${response.statusCode})"),
        );
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<List<WorkoutReply>>> getWorkoutReplies(int workoutId) async {
    try {
      final response = await http.get(
        _url('/api/v2/workouts/$workoutId/replies'),
        headers: await _headers(),
      );
      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        if (decoded is Map<String, dynamic>) {
          final apiResponse =
              ApiResponse.fromJson<List<WorkoutReply>, List<dynamic>>(
            decoded,
            (results) => results
                .map((e) => WorkoutReply.fromJson(e as Map<String, dynamic>))
                .toList(),
          );
          try {
            final data = apiResponse.getOrThrow();
            return Success(data);
          } on Exception catch (e) {
            return Failure(e);
          }
        } else if (decoded is List) {
          final list = decoded
              .map((e) => WorkoutReply.fromJson(e as Map<String, dynamic>))
              .toList();
          return Success(list);
        }
        return Failure(HttpException("Invalid response"));
      } else {
        return Failure(
          HttpException("Invalid response (${response.statusCode})"),
        );
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<WorkoutReply>> createReply(int workoutId, String content) async {
    try {
      final response = await http.post(
        _url('/api/v2/workouts/$workoutId/replies'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          ...await _headers(),
        },
        body: jsonEncode({'content': content}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        if (decoded is Map<String, dynamic>) {
          final apiResponse = ApiResponse.fromJson<WorkoutReply, dynamic>(
            decoded,
            (json) => WorkoutReply.fromJson(json as Map<String, dynamic>),
          );
          try {
            final data = apiResponse.getOrThrow();
            return Success(data);
          } on Exception catch (e) {
            return Failure(e);
          }
        }
        return Failure(HttpException("Invalid response structure"));
      } else {
        return Failure(
          HttpException("Invalid response (${response.statusCode})"),
        );
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<StatisticsResponse>> getStatistics({
    String? since,
    String? per,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (since != null && since.isNotEmpty) queryParams['since'] = since;
      if (per != null && per.isNotEmpty) queryParams['per'] = per;

      final uri = _url('/api/v2/statistics')
          .replace(queryParameters: queryParams.isNotEmpty ? queryParams : null);
      final response = await http.get(uri, headers: await _headers());

      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        if (decoded is Map<String, dynamic>) {
          final apiResponse = ApiResponse.fromJson<StatisticsResponse, dynamic>(
            decoded,
            (json) => StatisticsResponse.fromJson(json as Map<String, dynamic>),
          );
          try {
            final data = apiResponse.getOrThrow();
            return Success(data);
          } on Exception catch (e) {
            return Failure(e);
          }
        }
        return Failure(HttpException("Invalid response structure"));
      } else {
        return Failure(
          HttpException("Invalid response (${response.statusCode})"),
        );
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<List<WorkoutRecord>>> getRecords({String? handle}) async {
    try {
      final queryParams = <String, String>{};
      if (handle != null && handle.isNotEmpty) queryParams['handle'] = handle;

      final uri = _url('/api/v2/records')
          .replace(queryParameters: queryParams.isNotEmpty ? queryParams : null);
      final response = await http.get(uri, headers: await _headers());

      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        if (decoded is Map<String, dynamic>) {
          final apiResponse =
              ApiResponse.fromJson<List<WorkoutRecord>, List<dynamic>>(
            decoded,
            (results) => results
                .map((e) => WorkoutRecord.fromJson(e as Map<String, dynamic>))
                .toList(),
          );
          try {
            final data = apiResponse.getOrThrow();
            return Success(data);
          } on Exception catch (e) {
            return Failure(e);
          }
        } else if (decoded is List) {
          final list = decoded
              .map((e) => WorkoutRecord.fromJson(e as Map<String, dynamic>))
              .toList();
          return Success(list);
        }
        return Failure(HttpException("Invalid response structure"));
      } else {
        return Failure(
          HttpException("Invalid response (${response.statusCode})"),
        );
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
