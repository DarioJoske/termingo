part of 'auth_bloc.dart';

enum AuthStatus { initial, authenticated, unauthenticated, loading, error }

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final AppUser user;

  const AuthSuccess({required this.user});
}

final class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}
