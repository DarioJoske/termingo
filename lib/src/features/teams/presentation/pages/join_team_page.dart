import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:termingo/src/features/teams/presentation/bloc/teams_bloc.dart';

class JoinTeamPage extends StatefulWidget {
  const JoinTeamPage({super.key, required this.currentUserId});

  final String currentUserId;

  @override
  State<JoinTeamPage> createState() => _JoinTeamPageState();
}

class _JoinTeamPageState extends State<JoinTeamPage> {
  final TextEditingController _teamIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamsBloc, TeamsState>(
      listener: (context, state) {
        if (state is TeamsError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is TeamsJoined) {
          context.pop();
        }
      },
      builder: (context, state) {
        if (state is TeamsLoading) {
          return Scaffold(body: const Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Join Team')),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Enter team ID to join'),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Team ID'),
                    keyboardType: TextInputType.text,
                    controller: _teamIdController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TeamsBloc>().add(
                        JoinTeam(teamId: _teamIdController.text, userId: widget.currentUserId),
                      ); // Replace with actual team ID
                    },
                    child: const Text('Join Team'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
