import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker_app/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:workout_tracker_app/ui/core/ui/main_scaffold.dart';
import 'package:workout_tracker_app/ui/home/view_models/home_viewmodel.dart';
import 'package:workout_tracker_app/ui/home/widgets/home_screen.dart';
import 'package:workout_tracker_app/ui/recording/widgets/recording_screen.dart';
import 'package:workout_tracker_app/ui/settings/view_models/health_workouts_viewmodel.dart';
import 'package:workout_tracker_app/ui/settings/view_models/settings_viewmodel.dart';
import 'package:workout_tracker_app/ui/settings/widgets/health_connect_settings_screen.dart';
import 'package:workout_tracker_app/ui/settings/widgets/health_workouts_screen.dart';
import 'package:workout_tracker_app/ui/settings/widgets/settings_screen.dart';
import 'package:workout_tracker_app/ui/statistic/overview/widgets/statistic_overview_screen.dart';
import 'package:workout_tracker_app/ui/workout/detail/view_models/workout_detail_viewmodel.dart';
import 'package:workout_tracker_app/ui/workout/detail/widgets/workout_detail_screen.dart';
import 'package:workout_tracker_app/ui/workout/list/view_models/workout_list_viewmodel.dart';
import 'package:workout_tracker_app/ui/workout/list/widgets/workout_list_screen.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../ui/auth/login/widgets/login_screen.dart';
import 'routes.dart';

final router = GoRouter(
  // debugLogDiagnostics: true,
  initialLocation: Routes.home,
  redirect: _redirect,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        return LoginScreen(
            viewModel: LoginViewModel(authRepository: context.read()));
      },
    ),
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: Routes.home,
            builder: (context, state) {
              return HomeScreen(
                viewModel: HomeViewModel(
                  authRepository: context.read(),
                  measurementRepository: context.read(),
                  sharedPreferencesService: context.read(),
                  healthConnectService: context.read(),
                ),
              );
            },
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Routes.workouts,
            builder: (context, state) {
              return WorkoutListScreen(
                viewModel: WorkoutListViewModel(
                  workoutRepository: context.read(),
                ),
              );
            },
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  final workoutDetailViewModel = WorkoutDetailViewModel(
                    workoutRepository: context.read(),
                  );

                  workoutDetailViewModel.loadWorkout.execute(id);

                  return WorkoutDetailScreen(
                    viewModel: workoutDetailViewModel,
                  );
                },
              )
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: Routes.record,
              builder: (context, state) {
                return RecordingScreen();
              }),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: Routes.stats,
              builder: (context, state) {
                return StatisticOverviewScreen();
              }),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Routes.settings,
            builder: (context, state) {
              return SettingsScreen(
                viewModel: SettingsViewModel(
                  authRepository: context.read(),
                  sharedPreferencesService: context.read(),
                  healthConnectService: context.read(),
                  measurementRepository: context.read(),
                ),
              );
            },
            routes: [
              GoRoute(
                path: Routes.settingsHealthRelative,
                builder: (context, state) {
                  return HealthConnectSettingsScreen(
                    viewModel: SettingsViewModel(
                      authRepository: context.read(),
                      sharedPreferencesService: context.read(),
                      healthConnectService: context.read(),
                      measurementRepository: context.read(),
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: Routes.settingsHealthWorkoutsRelative,
                    builder: (context, state) {
                      return HealthWorkoutsScreen(
                        viewModel: HealthWorkoutsViewModel(
                          healthConnectService: context.read(),
                          workoutRepository: context.read(),
                          apiClient: context.read(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ]),
      ],
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell);
      },
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final loggedIn = await context.read<AuthRepository>().isAuthenticated;
  if (!loggedIn) {
    return Routes.login;
  }

  final loggingIn = state.matchedLocation == Routes.login;
  if (loggingIn) {
    return Routes.home;
  }

  return null;
}
