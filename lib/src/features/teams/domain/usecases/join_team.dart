import 'package:termingo/src/core/usecases/usecases.dart';
import 'package:termingo/src/core/utils/typedefs.dart';
import 'package:termingo/src/features/teams/domain/repositories/team_repository.dart';

class JoinTeamUsecase implements UsecaseWithParams<void, JoinTeamParams> {
  final TeamRepository teamRepository;

  const JoinTeamUsecase({required this.teamRepository});

  @override
  ResultFuture<void> call(JoinTeamParams params) {
    return teamRepository.joinTeam(teamId: params.teamId, userId: params.userId);
  }
}

class JoinTeamParams {
  final String teamId;
  final String userId;

  const JoinTeamParams({required this.teamId, required this.userId});
}
