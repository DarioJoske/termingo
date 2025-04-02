import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  CurrentUserCubit() : super(CurrentUserInitial());

  void loadCurrentUser(User? user) {
    if (user != null) {
      emit(CurrentUserLoaded(user: user));
    } else {
      emit(CurrentUserInitial());
    }
  }
}
