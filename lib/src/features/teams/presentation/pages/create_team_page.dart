import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:termingo/src/features/teams/presentation/bloc/teams_bloc.dart';

class CreateTeamPage extends StatefulWidget {
  const CreateTeamPage({super.key, required this.currentUserId});

  final String currentUserId;

  @override
  State<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  final TextEditingController _teamNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeamsBloc, TeamsState>(
      listener: (context, state) {
        if (state is TeamsCreated) {
          context.pop();
        } else if (state is TeamsError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Team')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(controller: _teamNameController, decoration: const InputDecoration(labelText: 'Team Name')),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_teamNameController.text.isEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Please enter a team name')));
                    return;
                  }
                  context.read<TeamsBloc>().add(
                    CreateTeam(teamName: _teamNameController.text, userId: widget.currentUserId),
                  );
                },
                child: const Text('Create Team'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
