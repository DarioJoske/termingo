import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:termingo/src/core/common/cubit/current_user_cubit.dart';
import 'package:termingo/src/features/teams/presentation/bloc/teams_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          BlocBuilder<CurrentUserCubit, CurrentUserState>(
            bloc: context.read<CurrentUserCubit>(),
            builder: (context, state) {
              if (state is CurrentUserLoaded) {
                return UserAccountsDrawerHeader(
                  accountName: Text(state.user.displayName ?? 'No Name'),
                  accountEmail: Text(state.user.email ?? 'No Email'),
                  currentAccountPicture: CircleAvatar(backgroundColor: Colors.grey),
                );
              } else {
                return const UserAccountsDrawerHeader(
                  accountName: Text('Guest'),
                  accountEmail: Text('No Email'),
                  currentAccountPicture: CircleAvatar(backgroundColor: Colors.grey),
                );
              }
            },
          ),
          BlocBuilder<TeamsBloc, TeamsState>(
            builder: (context, state) {
              if (state is TeamsLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    ListView.builder(
                      itemCount: state.teams.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final team = state.teams[index];
                        return ListTile(
                          leading: const Icon(Icons.group),
                          title: Text(team.name),
                          subtitle: Text('Id: ${team.id}'),
                          onTap: () {
                            // context.pop();
                            context.pushNamed('team', pathParameters: {'teamId': team.id});
                          },
                        );
                      },
                    ),
                  ],
                );
              }
              return const Expanded(child: Center(child: Text('No teams available')));
            },
          ),
        ],
      ),
    );
  }
}
