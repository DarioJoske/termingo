import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:termingo/firebase_options.dart';
import 'package:termingo/src/app.dart';
import 'package:termingo/src/core/common/cubit/current_user_cubit.dart';
import 'package:termingo/src/core/utils/init_dependencies.dart';
import 'package:termingo/src/features/auth/presentation/bloc/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependecies();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => serviceLocator<AuthBloc>()),
        BlocProvider<CurrentUserCubit>(create: (context) => serviceLocator<CurrentUserCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}
