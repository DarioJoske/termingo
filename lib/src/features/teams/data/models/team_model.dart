import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:termingo/src/features/teams/domain/entities/team_entity.dart';

class TeamModel extends Team {
  const TeamModel({
    required super.id,
    required super.name,
    required super.createdBy,
    required super.members,
    required super.admins,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] as String,
      name: json['name'] as String,
      createdBy: json['createdBy'] as String,
      members: List<String>.from(json['members'] as List),
      admins: List<String>.from(json['admins'] as List),
    );
  }

  factory TeamModel.fromDocument(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return TeamModel(
      id: snapshot.id,
      name: data['name'] as String,
      createdBy: data['createdBy'] as String,
      members: List<String>.from(data['members'] as List),
      admins: List<String>.from(data['admins'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'createdBy': createdBy, 'members': members, 'admins': admins};
  }
}
