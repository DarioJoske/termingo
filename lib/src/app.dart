import 'package:flutter/material.dart';
import 'package:termingo/src/core/router/app_router.dart';
import 'package:termingo/theme.dart';
import 'package:termingo/util.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, 'Roboto', 'Roboto');

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      title: 'Termingo',
      theme: theme.lightMediumContrast(),
      routerConfig: AppRouter.router, //
    );
  }
}
