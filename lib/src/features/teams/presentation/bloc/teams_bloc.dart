import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:termingo/src/features/teams/domain/entities/team_entity.dart';
import 'package:termingo/src/features/teams/domain/usecases/create_team.dart';
import 'package:termingo/src/features/teams/domain/usecases/get_teams.dart';

part 'teams_event.dart';
part 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc({
    // required String currentUserId,
    required GetTeamsUsecase getTeams,
    required CreateTeamUsecase createTeam, //
  }) : _createTeam = createTeam,
       _getTeams = getTeams,
       //  _currentUserId = currentUserId,
       super(TeamsInitial()) {
    on<CreateTeam>(_onCreateTeam);
    on<TeamsChanged>(_onTeamsChanged);

    _teamsSubscription = _getTeams.call(GetTeamsParams(userId: FirebaseAuth.instance.currentUser!.uid)).listen((teams) {
      add(TeamsChanged(teams: teams));
    });
  }

  // final String _currentUserId;
  final GetTeamsUsecase _getTeams;
  final CreateTeamUsecase _createTeam;

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
}
