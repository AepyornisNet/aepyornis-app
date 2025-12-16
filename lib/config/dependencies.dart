import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../data/repositories/auth/auth_repository_remote.dart';
import '../data/repositories/measurement/measurement_repository.dart';
import '../data/repositories/measurement/measurement_repository_remote.dart';
import '../data/repositories/workout/workout_repository.dart';
import '../data/repositories/workout/workout_repository_remote.dart';
import '../data/services/api/api_client.dart';
import '../data/services/health_connect/health_connect_service.dart';
import '../data/services/shared_preferences_service.dart';

/// Configure dependencies for remote data.
/// This dependency list uses repositories that connect to a remote server.
List<SingleChildWidget> get providersRemote {
  return [
    Provider(create: (context) => ApiClient()),
    Provider(create: (context) => SharedPreferencesService()),
    Provider(create: (context) => HealthConnectService()),
    ChangeNotifierProvider(
        create: (context) => AuthRepositoryRemote(
              apiClient: context.read(),
              sharedPreferencesService: context.read(),
            ) as AuthRepository),
    Provider(
        create: (context) =>
            MeasurementRepositoryRemote(apiClient: context.read())
                as MeasurementRepository),
    Provider(
        create: (context) => WorkoutRepositoryRemote(apiClient: context.read())
            as WorkoutRepository)
  ];
}
