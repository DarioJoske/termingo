part of 'teams_bloc.dart';

sealed class TeamsEvent {
  const TeamsEvent();
}

final class CreateTeam extends TeamsEvent {
  final String teamName;
  final String userId;

  const CreateTeam({required this.teamName, required this.userId});
}

final class TeamsChanged extends TeamsEvent {
  final List<Team> teams;

  const TeamsChanged({required this.teams});
}

final class JoinTeam extends TeamsEvent {
  final String teamId;
  final String userId;

  const JoinTeam({required this.teamId, required this.userId});
}
