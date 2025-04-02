import 'package:termingo/src/core/usecases/usecases.dart';
import 'package:termingo/src/features/teams/domain/entities/team_entity.dart';
import 'package:termingo/src/features/teams/domain/repositories/team_repository.dart';

class GetTeamsUsecase implements StreamUsecaseWithParams<List<Team>, GetTeamsParams> {
  final TeamRepository teamRepository;
  const GetTeamsUsecase({required this.teamRepository});

  @override
  Stream<List<Team>> call(GetTeamsParams params) {
    return teamRepository.getTeams(userId: params.userId);
  }
}

class GetTeamsParams {
  final String userId;

  GetTeamsParams({required this.userId});
}
