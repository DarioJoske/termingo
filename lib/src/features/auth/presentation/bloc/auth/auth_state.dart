part of 'auth_bloc.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated({required this.user});
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

final class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}
