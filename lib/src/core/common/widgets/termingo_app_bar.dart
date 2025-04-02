import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:termingo/src/core/router/routes.dart';

class TermingoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TermingoAppBar({super.key, required GlobalKey<ScaffoldState> scaffoldKey}) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person_rounded),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return BottomSheet(
                  onClosing: () {},
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('Hello, Dario', style: Theme.of(context).textTheme.headlineSmall),
                          ),
                          // SizedBox(height: 24),
                          ListTile(
                            leading: const Icon(Icons.groups),
                            title: const Text('Create a new team'),
                            onTap: () {
                              context.push(
                                Routes.createTeamRoute,
                                extra: {'userId': FirebaseAuth.instance.currentUser?.uid},
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text('Profile'),
                            onTap: () {
                              // Navigate to profile page
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.settings),
                            title: const Text('Settings'),
                            onTap: () {
                              // Navigate to settings page
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text('Sign out'),
                            onTap: () {
                              //TODO: Implement sign out functionality
                              FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
