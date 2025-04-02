part of 'current_user_cubit.dart';

sealed class CurrentUserState {
  const CurrentUserState();
}

final class CurrentUserInitial extends CurrentUserState {}

final class CurrentUserLoaded extends CurrentUserState {
  final User user;

  const CurrentUserLoaded({required this.user});
}
