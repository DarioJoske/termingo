import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:termingo/src/core/common/cubit/current_user_cubit.dart';
import 'package:termingo/src/features/auth/data/data_sources/firestore_auth_data_source.dart';
import 'package:termingo/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:termingo/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:termingo/src/features/auth/domain/usecases/auth_state_changes.dart';
import 'package:termingo/src/features/auth/domain/usecases/user_sign_in.dart';
import 'package:termingo/src/features/auth/domain/usecases/user_sign_up.dart';
import 'package:termingo/src/features/auth/presentation/bloc/auth/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependecies() async {
  _initAuth();

  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
}

void _initAuth() {
  serviceLocator.registerFactory<FirestoreAuthDataSource>(
    () => RemoteAuthDataSourceImpl(firebaseAuth: serviceLocator(), firebaseFirestore: serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory<UserSignUp>(() => UserSignUp(authRepository: serviceLocator()));
  serviceLocator.registerFactory<UserSignIn>(() => UserSignIn(authRepository: serviceLocator()));
  serviceLocator.registerFactory<AuthStateChanges>(() => AuthStateChanges(authRepository: serviceLocator()));
  serviceLocator.registerLazySingleton<CurrentUserCubit>(() => CurrentUserCubit());
  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      currentUserCubit: serviceLocator(),
      authStateChanges: serviceLocator(),
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(), //
    ),
  );
}
