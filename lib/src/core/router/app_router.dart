import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:termingo/src/core/router/routes.dart';
import 'package:termingo/src/core/utils/init_dependencies.dart';
import 'package:termingo/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:termingo/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:termingo/src/features/auth/presentation/pages/login_page.dart';
import 'package:termingo/src/features/auth/presentation/pages/register_page.dart';
import 'package:termingo/src/features/home/presentation/pages/home_page.dart';
import 'package:termingo/src/features/teams/presentation/bloc/teams_bloc.dart';
import 'package:termingo/src/features/teams/presentation/pages/create_team_page.dart';
import 'package:termingo/src/features/teams/presentation/pages/join_team_page.dart';
import 'package:termingo/src/features/teams/presentation/pages/team_page.dart';

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: Routes.loginRoute,
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
      GoRoute(
        path: Routes.createTeamRoute,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
            child: BlocProvider(
              create:
                  (context) =>
                      TeamsBloc(joinTeam: serviceLocator(), createTeam: serviceLocator(), getTeams: serviceLocator()),
              child: CreateTeamPage(currentUserId: serviceLocator<AuthRepository>().currentUser!.uid),
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.joinTeamRoute,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
            child: BlocProvider(
              create:
                  (context) =>
                      TeamsBloc(joinTeam: serviceLocator(), getTeams: serviceLocator(), createTeam: serviceLocator()),
              child: JoinTeamPage(currentUserId: serviceLocator<AuthRepository>().currentUser!.uid),
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.teamRoute,
        name: 'team',
        pageBuilder: (context, state) {
          final teamId = state.pathParameters['teamId'];

          return NoTransitionPage(
            child: BlocProvider(
              create:
                  (context) =>
                      TeamsBloc(joinTeam: serviceLocator(), getTeams: serviceLocator(), createTeam: serviceLocator()),
              child: TeamPage(teamId: teamId!),
            ),
          );
        },
      ),
    ],
    refreshListenable: GoRouterRefreshStream(),
    redirect: (context, state) {
      final authBloc = serviceLocator<AuthBloc>();

      final isLoggedIn = authBloc.state is AuthAuthenticated;
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
