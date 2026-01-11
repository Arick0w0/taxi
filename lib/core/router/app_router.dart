import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/sample_feature/presentation/view/user_list_view.dart';
import '../auth/auth_provider.dart';

enum AppRoute { home, login, splash }

final rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authState;
      final isGoingToLogin = state.uri.toString() == '/login';

      if (!isLoggedIn && !isGoingToLogin) {
        return '/login';
      }

      if (isLoggedIn && isGoingToLogin) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const UserListView(),
        routes: [
          // Nested route example
          // GoRoute(
          //   path: 'details/:id',
          //   builder: (context, state) => DetailView(id: state.pathParameters['id']!),
          // ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text("Login Screen Placeholder")),
        ),
      ),
    ],
  );
});
