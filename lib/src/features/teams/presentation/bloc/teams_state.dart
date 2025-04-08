part of 'teams_bloc.dart';

sealed class TeamsState {
  const TeamsState();
}

final class TeamsInitial extends TeamsState {}

final class TeamsLoading extends TeamsState {}

final class TeamsLoaded extends TeamsState {
  final List<Team> teams;
  const TeamsLoaded({required this.teams});
}

final class TeamsCreated extends TeamsState {
  final Team team;
  const TeamsCreated({required this.team});
}

final class TeamsJoined extends TeamsState {}

final class TeamsError extends TeamsState {
  final String message;
  const TeamsError({required this.message});
}
