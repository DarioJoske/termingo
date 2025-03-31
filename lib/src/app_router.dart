import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:termingo/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:termingo/src/features/auth/presentation/pages/login_page.dart';
import 'package:termingo/src/features/auth/presentation/pages/register_page.dart';
import 'package:termingo/src/features/home/presentation/pages/home_page.dart';
import 'package:termingo/src/init_dependencies.dart';
import 'package:termingo/src/routes.dart';

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: Routes.loginRoute,
    refreshListenable: GoRouterRefreshStream(),
    redirect: (context, state) {
      final authBloc = serviceLocator<AuthBloc>();

      final isLoggedIn = authBloc.state is AuthSuccess;
      final isLoggingIn = state.matchedLocation == Routes.loginRoute || state.matchedLocation == Routes.registerRoute;

      // Redirect to the login page if the user is not authenticated, and if authenticated, do not show the login page

      if (!isLoggedIn && !isLoggingIn) {
        return Routes.loginRoute;
      }

      if (isLoggedIn && isLoggingIn) {
        return Routes.homeRoute;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.homeRoute,
        pageBuilder: (context, state) {
          return NoTransitionPage(child: HomePage());
        },
      ),
      GoRoute(
        path: Routes.loginRoute,
        pageBuilder: (context, state) {
          return NoTransitionPage(child: LoginPage());
        },
      ),
      GoRoute(
        path: Routes.registerRoute,
        pageBuilder: (context, state) {
          return NoTransitionPage(child: RegisterPage());
        },
      ),
    ],
  );
}

// for convert stream to listenable
class StreamToListenable extends ChangeNotifier {
  late final List<StreamSubscription> subscriptions;

  StreamToListenable(List<Stream> streams) {
    subscriptions = [];
    for (var e in streams) {
      var s = e.asBroadcastStream().listen(_tt);
      subscriptions.add(s);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    for (var e in subscriptions) {
      e.cancel();
    }
    super.dispose();
  }

  void _tt(event) => notifyListeners();
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream() {
    final AuthBloc authBloc = serviceLocator<AuthBloc>();
    notifyListeners();
    _subscription = authBloc.stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
