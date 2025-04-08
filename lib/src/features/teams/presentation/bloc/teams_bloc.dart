import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:termingo/src/core/utils/init_dependencies.dart';
import 'package:termingo/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:termingo/src/features/teams/domain/entities/team_entity.dart';
import 'package:termingo/src/features/teams/domain/usecases/create_team.dart';
import 'package:termingo/src/features/teams/domain/usecases/get_teams.dart';
import 'package:termingo/src/features/teams/domain/usecases/join_team.dart';

part 'teams_event.dart';
part 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc({
    required GetTeamsUsecase getTeams,
    required JoinTeamUsecase joinTeam,
    required CreateTeamUsecase createTeam, //
  }) : _createTeam = createTeam,
       _getTeams = getTeams,
       _joinTeam = joinTeam,

       super(TeamsInitial()) {
    on<CreateTeam>(_onCreateTeam);
    on<TeamsChanged>(_onTeamsChanged);
    on<JoinTeam>(_onJoinTeam);

    _teamsSubscription = _getTeams
        .call(GetTeamsParams(userId: serviceLocator<AuthRepository>().currentUser!.uid))
        .listen((teams) {
          add(TeamsChanged(teams: teams));
        });
  }

  final GetTeamsUsecase _getTeams;
  final CreateTeamUsecase _createTeam;
  final JoinTeamUsecase _joinTeam;

  StreamSubscription<List<Team>>? _teamsSubscription;

  @override
  Future<void> close() {
    _teamsSubscription?.cancel();
    return super.close();
  }

  void _onCreateTeam(CreateTeam event, Emitter<TeamsState> emit) async {
    emit(TeamsLoading());
    final result = await _createTeam.call(CreateTeamParams(name: event.teamName, userId: event.userId));

    result.fold(
      (failure) => emit(TeamsError(message: failure.errorMessage)),
      (team) {
        emit(TeamsCreated(team: team));
      }, //
    );
  }

  void _onTeamsChanged(TeamsChanged event, Emitter<TeamsState> emit) {
    emit(TeamsLoaded(teams: event.teams));
  }

  void _onJoinTeam(JoinTeam event, Emitter<TeamsState> emit) async {
    emit(TeamsLoading());
    final result = await _joinTeam.call(JoinTeamParams(teamId: event.teamId, userId: event.userId));

    result.fold((failure) => emit(TeamsError(message: failure.errorMessage)), (_) {
      emit(TeamsJoined());
    });
  }
}
