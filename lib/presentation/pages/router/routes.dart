import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/pages/pages.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  final keyValueRepository = KeyValueStorageRepositoryImpl();

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        name: $splash,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreenPage(),
      ),
      GoRoute(
        path: '/login',
        name: $login,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(),
      ),
      GoRoute(
        path: '/resetpassword',
        name: $resetpassword,
        builder: (BuildContext context, GoRouterState state) =>
            const ResetPasswordPage(),
      ),
      GoRoute(
        path: '/dashboard',
        name: $dashboard,
        builder: (BuildContext context, GoRouterState state) =>
            const DashboardPage(),
      ),
      GoRoute(
        path: '/childrenTutor',
        name: $childrenTutor,
        builder: (BuildContext context, GoRouterState state) =>
            const ChildrenTutorPage(),
      ),
      GoRoute(
        path: '/childrenTherapist',
        name: $childrenTherapist,
        builder: (BuildContext context, GoRouterState state) =>
            const ChildrenTherapistPage(),
      ),
      GoRoute(
          path: '/child/:idChild',
          name: $child,
          builder: (BuildContext context, GoRouterState state) {
            final extra = state.extra as Map<String, dynamic>?;
            return ChildDataPage(
              idChild: int.parse(state.pathParameters[$idChild]!),
              extra: extra,
            );
          }),
      GoRoute(
        path: '/activities',
        name: $activities,
        builder: (BuildContext context, GoRouterState state) =>
            const ActivitiesPage(),
      ),
      GoRoute(
        path: '/activity/:idActivity',
        name: $activity,
        builder: (BuildContext context, GoRouterState state) => ActivityPage(
          idActivity: int.parse(state.pathParameters[$idActivity]!),
        ),
      ),
      GoRoute(
        path: '/newActivity',
        name: $newActivity,
        builder: (BuildContext context, GoRouterState state) =>
            const NewActivityPage(),
      ),
      GoRoute(
        path: '/addActivity/:idActivity',
        name: $addActivity,
        builder: (BuildContext context, GoRouterState state) => AddActivityPage(
            idActivity: int.parse(state.pathParameters[$idActivity]!)),
      ),
      GoRoute(
          path: '/removeActivity/:idActivity',
          name: $removeActivity,
          builder: (BuildContext context, GoRouterState state) {
            final extra = state.extra as Map<String, dynamic>?;
            return RemoveAcivityPage(
                idActivity: int.parse(state.pathParameters[$idActivity]!),
                nameActivity: extra);
          }),
      GoRoute(
        path: '/profile',
        name: $profileRoute,
        builder: (BuildContext context, GoRouterState state) =>
            const ProfilePage(),
      ),
      GoRoute(
        path: '/pictogram/:idChild',
        name: $pictogram,
        builder: (BuildContext context, GoRouterState state) => PictogramPage(
          idChild: int.parse(state.pathParameters[$idChild]!),
        ),
      ),
      GoRoute(
        path: '/customPictogram/:idChild',
        name: $customPictogram,
        builder: (BuildContext context, GoRouterState state) =>
            CustomPictogramasPage(
          idChild: int.parse(state.pathParameters[$idChild]!),
        ),
      ),
      GoRoute(
        path: '/board',
        name: $board,
        builder: (BuildContext context, GoRouterState state) =>
            const BoardPage(),
      ),
    ],
    redirect: (context, state) async {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/resetpassword') {
          return null;
        }
        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        final String? token =
            await keyValueRepository.getValueStorage<String>($token);

        if (token == null) return '/login';

        if (isGoingTo == '/login' ||
            isGoingTo == '/resetpassword' ||
            isGoingTo == '/splash') {
          return '/dashboard';
        }

        final profileState = ref.read(profileProvider);
        final bool? verified =
            await keyValueRepository.getValueStorage<bool>($verified);

        if (profileState.isLoading && verified == true) {
          ref.read(profileProvider.notifier).loadProfileAndPermmisions();
        }
      }
      return null;
    },
  );
});
