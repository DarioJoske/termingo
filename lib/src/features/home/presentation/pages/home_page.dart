import 'package:flutter/material.dart';
import 'package:termingo/src/core/common/widgets/app_drawer.dart';
import 'package:termingo/src/core/common/widgets/termingo_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: TermingoAppBar(scaffoldKey: _scaffoldKey),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('Welcome to the Home Page!')]),
      ),
    );
  }
}
