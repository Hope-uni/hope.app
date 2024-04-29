import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/presentation/pages/pages.dart';
//import 'package:hope_app/presentation/providers/providers.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(GoRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/children',
    refreshListenable: goRouterNotifier,
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) =>
            const CheckAuthStatusPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(),
      ),
      GoRoute(
        path: '/resetpassword',
        name: 'resetpassword',
        builder: (BuildContext context, GoRouterState state) =>
            const ResetPasswordPage(),
      ),
      GoRoute(
        path: '/children',
        name: 'children',
        builder: (BuildContext context, GoRouterState state) =>
            const ChildrenPage(),
      ),
      GoRoute(
          path: '/child/:idChild',
          name: 'child',
          builder: (BuildContext context, GoRouterState state) => ChildDataPage(
                idChild: int.parse(state.pathParameters['idChild']!),
              )),
      GoRoute(
        path: '/activities',
        name: 'activities',
        builder: (BuildContext context, GoRouterState state) =>
            const ActivitiesPage(),
      ),
      GoRoute(
        path: '/activity/:idActivity/:isEdit',
        name: 'activity',
        builder: (BuildContext context, GoRouterState state) => ActivityPage(
          isGoEdit: bool.parse(state.pathParameters['isEdit']!),
          idItem: int.parse(state.pathParameters['idActivity']!),
        ),
      ),
      GoRoute(
        path: '/newActivity',
        name: 'newActivity',
        builder: (BuildContext context, GoRouterState state) =>
            const NewActivityPage(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (BuildContext context, GoRouterState state) =>
            const ProfilePage(),
      ),
      GoRoute(
        path: '/pictogram',
        name: 'pictogram',
        builder: (BuildContext context, GoRouterState state) =>
            PictogramPage(idChild: state.extra as int),
      ),
      GoRoute(
        path: '/customPictogram',
        name: 'customPictogram',
        builder: (context, state) => CustomPictogramasPage(
          idChild: state.extra as int,
        ),
      ),
    ],
    /*redirect: (context, state) {
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
    },*/
  );
});
