import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:termingo/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:termingo/src/core/common/entities/app_user.dart';
import 'package:termingo/src/features/auth/domain/usecases/auth_state_changes.dart';
import 'package:termingo/src/features/auth/domain/usecases/current_user.dart';
import 'package:termingo/src/features/auth/domain/usecases/user_sign_in.dart';
import 'package:termingo/src/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthStateChanges authStateChanges,
    required CurrentUser currentUser,
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required AppUserCubit appUserCubit,
  }) : _currentUser = currentUser,
       _authStateChanges = authStateChanges,
       _userSignUp = userSignUp,
       _userSignIn = userSignIn,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
    on<AuthUserChanged>(_onAuthStateChanged);

    _authSubscription = _authStateChanges.call().listen((user) async {
      if (user == null) {
        // emit(AuthError('User is not logged in'));
        add(AuthUserChanged(user: null));
      } else {
        add(AuthUserChanged(user: user));
        // await _currentUser.call().then((result) {
        //   result.fold(
        //     (failure) => emit(AuthError(failure.errorMessage)),
        //     (response) {
        //       _appUserCubit.updateUser(response);
        //       emit(AuthSuccess(user: response));
        //     }, //
        //   );
        // });
      }
    });
  }

  final AppUserCubit _appUserCubit;
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AuthStateChanges _authStateChanges;

  StreamSubscription<User?>? _authSubscription;

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  void _onAuthStateChanged(AuthUserChanged event, Emitter<AuthState> emit) async {
    if (event.user == null) {
      emit(AuthError('User is not logged in'));
    } else {
      final currentUserResult = await _currentUser.call();
      currentUserResult.fold((failure) => emit(AuthError(failure.errorMessage)), (response) {
        _appUserCubit.updateUser(response);
        emit(AuthSuccess(user: response));
      });
    }
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _userSignUp.call(UserSignUpParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (response) => emit(AuthSuccess(user: response)), //
    );
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _userSignIn.call(UserSignInParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (response) => emit(AuthSuccess(user: response)), //
    );
  }

  void _onAuthIsUserLoggedIn(AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _currentUser.call();
    result.fold((failure) => emit(AuthError(failure.errorMessage)), (response) {
      _appUserCubit.updateUser(response);
      emit(AuthSuccess(user: response));
    });
  }
}
