import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String teamId;
  final String name;
  final String description;
  final String createdBy;
  final String date;
  final String time;
  final String location;
  final List<String> participants;

  const Event({
    required this.id,
    required this.name,
    required this.description,
    required this.teamId,
    required this.createdBy,
    required this.date,
    required this.time,
    required this.location,
    required this.participants,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    date,
    time,
    location,
    participants,
    teamId,
    createdBy, //
  ];
}
