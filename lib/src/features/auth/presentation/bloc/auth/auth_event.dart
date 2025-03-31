part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthSignUp extends AuthEvent {
  const AuthSignUp({required this.email, required this.password});

  final String email;
  final String password;
}

final class AuthSignIn extends AuthEvent {
  const AuthSignIn({required this.email, required this.password});

  final String email;
  final String password;
}

final class AuthIsUserLoggedIn extends AuthEvent {}

final class AuthUserChanged extends AuthEvent {
  final User? user;
  const AuthUserChanged({this.user});
}
