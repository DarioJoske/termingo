import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:termingo/src/features/teams/presentation/bloc/teams_bloc.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key, required this.teamId});

  final String teamId;

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsBloc, TeamsState>(
      builder: (context, state) {
        if (state is TeamsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TeamsLoaded) {
          final team = state.teams.firstWhere((team) => team.id == widget.teamId);
          return Scaffold(
            appBar: AppBar(title: Text(team.name)),
            body: Column(
              children: [
                Center(child: Text('Team ID: ${team.id}')),
                Text('Team Name: ${team.name}'),
                Text('Team Members: ${team.members.length}'),
                Text('Team Admins: ${team.admins.length}'),
                const SizedBox(height: 16),
              ],
            ),
          );
        } else if (state is TeamsError) {
          return Center(child: Text(state.message));
        }
        return SizedBox.shrink();
      },
    );
  }
}
