import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/presentation/pages/pages.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
        path: '/splash',
        builder: (BuildContext context, GoRouterState state) =>
            const CheckAuthStatusPage()),
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage()),
    GoRoute(
        path: '/resetpassword',
        builder: (BuildContext context, GoRouterState state) =>
            const ResetPasswordPage()),
    GoRoute(
        path: '/dashboard',
        builder: (BuildContext context, GoRouterState state) =>
            const DashboardPage()),
    GoRoute(
        path: '/children',
        builder: (BuildContext context, GoRouterState state) =>
            const ChildrenPage()),
    GoRoute(
        path: '/activity',
        builder: (BuildContext context, GoRouterState state) =>
            const ActivityPage()),
    GoRoute(
        path: '/settings',
        builder: (BuildContext context, GoRouterState state) =>
            const SettingsPersonPage()),
  ],
);
