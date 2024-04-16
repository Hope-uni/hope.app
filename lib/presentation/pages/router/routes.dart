import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/presentation/pages/pages.dart';
import 'package:hope_app/presentation/providers/providers.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(GoRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/children',
    refreshListenable: goRouterNotifier,
    routes: <RouteBase>[
      GoRoute(
          path: '/splash',
          builder: (BuildContext context, GoRouterState state) =>
              const CheckAuthStatusPage()),
      GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) =>
              const LoginPage()),
      GoRoute(
          path: '/resetpassword',
          builder: (BuildContext context, GoRouterState state) =>
              const ResetPasswordPage()),
      GoRoute(
          path: '/children',
          builder: (BuildContext context, GoRouterState state) =>
              const ChildrenPage()),
      GoRoute(
          path: '/child',
          builder: (BuildContext context, GoRouterState state) => ChildDataPage(
                idChild: state.extra as int,
              )),
      GoRoute(
          path: '/activity',
          builder: (BuildContext context, GoRouterState state) =>
              const ActivityPage()),
      GoRoute(
          path: '/profile',
          builder: (BuildContext context, GoRouterState state) =>
              const ProfilePage()),
      GoRoute(
          path: '/pictogram',
          builder: (BuildContext context, GoRouterState state) => PictogramPage(
                idChild: state.extra as int,
              )),
      GoRoute(
        path: '/customPictogram',
        builder: (context, state) => CustomPictogramasPage(
          idChild: state.extra as int,
        ),
      )
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/resetpassword') return null;
        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/resetpassword' ||
            isGoingTo == '/splash') return '/children';
      }
      //Aqui agregar validaciones de roles o permisos y tambien agregar rutas a array para hacerlo mas dinamico
      //if(user.role =='tutor')

      return null;
    },
  );
});
