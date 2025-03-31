import 'package:termingo/src/core/common/entities/app_user.dart';
import 'package:termingo/src/core/usecases/usecases.dart';
import 'package:termingo/src/core/utils/typedefs.dart';
import 'package:termingo/src/features/auth/domain/repositories/auth_repository.dart';

class UserSignIn implements UsecaseWithParams<AppUser, UserSignInParams> {
  final AuthRepository authRepository;
  UserSignIn({required this.authRepository});

  @override
  ResultFuture<AppUser> call(params) async {
    return await authRepository.signInWithEmailAndPassword(email: params.email, password: params.password);
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}
