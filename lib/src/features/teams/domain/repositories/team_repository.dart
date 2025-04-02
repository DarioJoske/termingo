import 'package:termingo/src/core/utils/typedefs.dart';
import 'package:termingo/src/features/teams/domain/entities/team_entity.dart';

abstract class TeamRepository {
  ResultFuture<Team> createTeam({required String teamName, required String userId});
  Stream<List<Team>> getTeams({required String userId});
}
