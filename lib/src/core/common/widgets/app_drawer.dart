import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:termingo/src/core/common/cubit/current_user_cubit.dart';

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
                  currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(state.user.photoURL ?? '')),
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
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: const Text('Team 1'),
                onTap: () {
                  // Handle item tap
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Team 2'),
                onTap: () {
                  // Handle item tap
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
