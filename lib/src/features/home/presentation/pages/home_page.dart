import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:termingo/src/core/common/widgets/app_drawer.dart';
import 'package:termingo/src/core/common/widgets/termingo_app_bar.dart';
import 'package:termingo/src/core/utils/init_dependencies.dart';
import 'package:termingo/src/features/teams/presentation/bloc/teams_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeamsBloc(getTeams: serviceLocator(), createTeam: serviceLocator()),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(),
        appBar: TermingoAppBar(scaffoldKey: _scaffoldKey),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Text('Welcome to the Home Page!')],
          ),
        ),
      ),
    );
  }
}
