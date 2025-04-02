import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:termingo/src/core/common/cubit/current_user_cubit.dart';
import 'package:termingo/src/features/auth/domain/usecases/auth_state_changes.dart';
import 'package:termingo/src/features/auth/domain/usecases/user_sign_in.dart';
import 'package:termingo/src/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthStateChanges authStateChanges,
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUserCubit currentUserCubit,
    //
  }) : _authStateChanges = authStateChanges,
       _userSignUp = userSignUp,
       _userSignIn = userSignIn,
       _currentUserCubit = currentUserCubit,
       super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthUserChanged>(_onAuthUserChanged);

    _authSubscription = _authStateChanges.call().listen((user) async {
      add(AuthUserChanged(user: user));
    });
  }

  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final AuthStateChanges _authStateChanges;
  final CurrentUserCubit _currentUserCubit;

  StreamSubscription<User?>? _authSubscription;

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  void _onAuthUserChanged(AuthUserChanged event, Emitter<AuthState> emit) async {
    if (event.user == null) {
      emit(AuthUnauthenticated());
    } else {
      _currentUserCubit.loadCurrentUser(event.user);
      emit(AuthAuthenticated(user: event.user!));
    }
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _userSignUp.call(UserSignUpParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (response) => emit(AuthAuthenticated(user: response)), //
    );
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _userSignIn.call(UserSignInParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (response) => emit(AuthAuthenticated(user: response)), //
    );
  }
}
