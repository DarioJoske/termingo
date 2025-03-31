import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:termingo/firebase_options.dart';
import 'package:termingo/src/app.dart';
import 'package:termingo/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:termingo/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:termingo/src/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependecies();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (context) => serviceLocator<AppUserCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}
