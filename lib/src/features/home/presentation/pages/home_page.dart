import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:termingo/src/core/common/cubit/current_user_cubit.dart';
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
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        return BlocProvider(
          create:
              (context) =>
                  TeamsBloc(joinTeam: serviceLocator(), getTeams: serviceLocator(), createTeam: serviceLocator()),
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
      },
    );
  }
}

class MyCalendarEvents extends CalendarDataSource {
  MyCalendarEvents(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}

class Meeting {
  Meeting({required this.eventName, required this.from, required this.to, required this.background});

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
}
