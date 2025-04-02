// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Team extends Equatable {
  final String id;
  final String name;
  final String createdBy;
  final List<String> members;
  final List<String> admins;
  const Team({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.members,
    required this.admins,
  });

  @override
  List<Object?> get props => [
    id, name, members, admins, createdBy, //
  ];
}
