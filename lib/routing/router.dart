import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:aepyornis_app/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:aepyornis_app/ui/core/ui/main_scaffold.dart';
import 'package:aepyornis_app/ui/home/view_models/home_viewmodel.dart';
import 'package:aepyornis_app/ui/home/widgets/home_screen.dart';
import 'package:aepyornis_app/ui/notification/view_models/notification_viewmodel.dart';
import 'package:aepyornis_app/ui/notification/widgets/notification_screen.dart';
import 'package:aepyornis_app/ui/settings/view_models/health_workouts_viewmodel.dart';
import 'package:aepyornis_app/ui/settings/view_models/settings_viewmodel.dart';
import 'package:aepyornis_app/ui/settings/widgets/health_connect_settings_screen.dart';
import 'package:aepyornis_app/ui/settings/widgets/health_workouts_screen.dart';
import 'package:aepyornis_app/ui/settings/widgets/settings_screen.dart';
import 'package:aepyornis_app/ui/statistic/overview/view_models/statistic_overview_viewmodel.dart';
import 'package:aepyornis_app/ui/statistic/overview/widgets/statistic_overview_screen.dart';
import 'package:aepyornis_app/ui/statistic/records_ranking/view_models/record_ranking_viewmodel.dart';
import 'package:aepyornis_app/ui/statistic/records_ranking/widgets/record_ranking_screen.dart';
import 'package:aepyornis_app/ui/workout/create/view_models/workout_create_viewmodel.dart';
import 'package:aepyornis_app/ui/workout/create/widgets/workout_create_screen.dart';
import 'package:aepyornis_app/ui/workout/detail/view_models/workout_detail_viewmodel.dart';
import 'package:aepyornis_app/ui/workout/detail/widgets/workout_detail_screen.dart';
import 'package:aepyornis_app/ui/workout/list/view_models/workout_list_viewmodel.dart';
import 'package:aepyornis_app/ui/workout/list/widgets/workout_list_screen.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../data/services/share_intent_service.dart';
import '../ui/auth/login/widgets/login_screen.dart';
import 'routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
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
    GoRoute(
      path: Routes.notifications,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => MaterialPage(
        key: ValueKey(state.uri.toString()),
        child: NotificationScreen(
          viewModel: NotificationViewModel(
            notificationRepository: context.read(),
          ),
        ),
      ),
    ),
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: Routes.home,
            builder: (context, state) {
              return HomeScreen(
                viewModel: context.read<HomeViewModel>(),
              );
            },
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Routes.workouts,
            builder: (context, state) {
              return WorkoutListScreen(
                viewModel: context.read<WorkoutListViewModel>(),
              );
            },
            routes: [
              GoRoute(
                path: Routes.workoutCreateRelative,
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) => MaterialPage(
                  key: ValueKey(state.uri.toString()),
                  child: WorkoutCreateScreen(
                    viewModel: WorkoutCreateViewModel(
                      workoutRepository: context.read(),
                      authRepository: context.read(),
                      shareIntentService: context.read(),
                    ),
                  ),
                ),
              ),
              GoRoute(
                path: ':id',
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  final workoutDetailViewModel = WorkoutDetailViewModel(
                    workoutRepository: context.read(),
                    authRepository: context.read(),
                  );

                  workoutDetailViewModel.loadWorkout.execute(id);

                  return MaterialPage(
                    key: ValueKey(state.uri.toString()),
                    child: WorkoutDetailScreen(
                      viewModel: workoutDetailViewModel,
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'edit',
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      final id = int.parse(state.pathParameters['id']!);
                      final vm = WorkoutCreateViewModel(
                        workoutRepository: context.read(),
                        authRepository: context.read(),
                        shareIntentService: context.read(),
                      );
                      vm.loadWorkoutForEdit(id);
                      return MaterialPage(
                        key: ValueKey(state.uri.toString()),
                        child: WorkoutCreateScreen(viewModel: vm),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Routes.stats,
            builder: (context, state) {
              return StatisticOverviewScreen(
                viewModel: context.read<StatisticOverviewViewModel>(),
              );
            },
            routes: [
              GoRoute(
                path: Routes.statisticRecordRankingRelative,
                builder: (context, state) {
                  final workoutType = state.pathParameters['workoutType'] ?? '';
                  final rawLabel = state.pathParameters['label'] ?? '';
                  final label = Uri.decodeComponent(rawLabel);

                  return RecordRankingScreen(
                    viewModel: RecordRankingViewModel(
                      statisticsRepository: context.read(),
                      workoutType: workoutType,
                      label: label,
                    ),
                  );
                },
              ),
            ],
          ),
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
        return ShareIntentListener(
          child: MainScaffold(navigationShell),
        );
      },
    ),
  ],
);

class ShareIntentListener extends StatefulWidget {
  final Widget child;

  const ShareIntentListener({super.key, required this.child});

  @override
  State<ShareIntentListener> createState() => _ShareIntentListenerState();
}

class _ShareIntentListenerState extends State<ShareIntentListener> {
  ShareIntentService? _shareIntentService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final service = context.read<ShareIntentService>();
    if (_shareIntentService != service) {
      _shareIntentService?.removeListener(_onShareIntent);
      _shareIntentService = service;
      _shareIntentService?.addListener(_onShareIntent);
      _onShareIntent();
    }
  }

  void _onShareIntent() {
    final service = _shareIntentService;
    if (service != null && service.hasNewFiles) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          GoRouter.of(context).go(Routes.workoutCreate);
        }
      });
    }
  }

  @override
  void dispose() {
    _shareIntentService?.removeListener(_onShareIntent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

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
