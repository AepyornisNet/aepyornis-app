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
import '../ui/home/view_models/home_viewmodel.dart';
import '../ui/workout/list/view_models/workout_list_viewmodel.dart';

import '../data/repositories/statistics/statistics_repository.dart';
import '../data/repositories/statistics/statistics_repository_remote.dart';
import '../ui/statistic/overview/view_models/statistic_overview_viewmodel.dart';

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
            as WorkoutRepository),
    Provider(
        create: (context) =>
            StatisticsRepositoryRemote(apiClient: context.read())
                as StatisticsRepository),
    Provider(
        create: (context) => WorkoutListViewModel(
              workoutRepository: context.read(),
            )),
    ChangeNotifierProvider(
        create: (context) => HomeViewModel(
              authRepository: context.read(),
              measurementRepository: context.read(),
              sharedPreferencesService: context.read(),
              healthConnectService: context.read(),
              workoutRepository: context.read(),
              apiClient: context.read(),
            )),
    ChangeNotifierProvider(
        create: (context) => StatisticOverviewViewModel(
              statisticsRepository: context.read(),
            )),
  ];
}
