import 'package:dartz/dartz.dart';
import 'package:termingo/src/core/errors/exceptions.dart';
import 'package:termingo/src/core/errors/failures.dart';
import 'package:termingo/src/core/utils/typedefs.dart';
import 'package:termingo/src/features/teams/data/data_sources/teams_data_source.dart';
import 'package:termingo/src/features/teams/domain/entities/team_entity.dart';
import 'package:termingo/src/features/teams/domain/repositories/team_repository.dart';

class TeamsRepositoryImpl implements TeamRepository {
  final TeamsDataSource _teamsDataSource;
  TeamsRepositoryImpl(this._teamsDataSource);

  @override
  ResultFuture<Team> createTeam({required String teamName, required String userId}) async {
    try {
      final result = await _teamsDataSource.createTeam(teamName: teamName, userId: userId);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Stream<List<Team>> getTeams({required String userId}) {
    try {
      final result = _teamsDataSource.getTeams(userId: userId);

      return result;
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  ResultFuture<void> joinTeam({required String teamId, required String userId}) async {
    try {
      final result = await _teamsDataSource.joinTeam(teamId: teamId, userId: userId);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
