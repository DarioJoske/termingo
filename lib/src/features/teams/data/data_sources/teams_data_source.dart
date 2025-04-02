// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:termingo/src/core/errors/exceptions.dart';
import 'package:termingo/src/features/teams/data/models/team_model.dart';

abstract interface class TeamsDataSource {
  Future<TeamModel> createTeam({required String teamName, required String userId});
  Stream<List<TeamModel>> getTeams({required String userId});
}

class TeamDataSourceImpl implements TeamsDataSource {
  final FirebaseFirestore firebaseFirestore;
  TeamDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<TeamModel> createTeam({required String teamName, required String userId}) async {
    try {
      final response = await firebaseFirestore.collection('teams').add({
        'name': teamName,
        'createdBy': userId,
        'members': [userId],
        'admins': [userId],
      });

      if (response.id.isNotEmpty) {
        await firebaseFirestore.collection('users').doc(userId).update({
          'teams': FieldValue.arrayUnion([response.id]),
        });
      }

      final team = await firebaseFirestore.collection('teams').doc(response.id).get();
      if (team.exists) {
        return TeamModel.fromDocument(team);
      } else {
        throw ServerException(message: 'Team not found', statusCode: '404');
      }
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Something went wron', statusCode: e.code);
    }
  }

  @override
  Stream<List<TeamModel>> getTeams({required String userId}) async* {
    try {
      final snapshot = firebaseFirestore.collection('teams').where('members', arrayContains: userId).snapshots();
      await for (final querySnapshot in snapshot) {
        final teams =
            querySnapshot.docs.map((doc) {
              return TeamModel.fromDocument(doc);
            }).toList();

        yield teams;
      }
    } on FirebaseException catch (e) {
      throw ServerException(message: e.toString(), statusCode: '500');
    }
  }
}
