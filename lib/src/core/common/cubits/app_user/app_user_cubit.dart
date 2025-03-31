import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:termingo/src/core/common/entities/app_user.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(AppUser? user) {
    if (user == null) {
      emit(AppUserInitial());
      return;
    } else {
      emit(AppUserLoggedIn(user: user));
    }
  }
}
