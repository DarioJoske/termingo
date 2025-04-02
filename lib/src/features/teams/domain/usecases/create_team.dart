import 'package:termingo/src/core/usecases/usecases.dart';
import 'package:termingo/src/core/utils/typedefs.dart';
import 'package:termingo/src/features/teams/domain/entities/team_entity.dart';
import 'package:termingo/src/features/teams/domain/repositories/team_repository.dart';

class CreateTeamUsecase implements UsecaseWithParams<Team, CreateTeamParams> {
  final TeamRepository teamRepository;

  CreateTeamUsecase({required this.teamRepository});

  @override
  ResultFuture<Team> call(params) {
    return teamRepository.createTeam(teamName: params.name, userId: params.userId);
  }
}

class CreateTeamParams {
  final String name;
  final String userId;

  CreateTeamParams({required this.name, required this.userId});
}
