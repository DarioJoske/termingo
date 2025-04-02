import 'package:firebase_auth/firebase_auth.dart';
import 'package:termingo/src/core/usecases/usecases.dart';
import 'package:termingo/src/core/utils/typedefs.dart';
import 'package:termingo/src/features/auth/domain/repositories/auth_repository.dart';

class UserSignIn implements UsecaseWithParams<User, UserSignInParams> {
  final AuthRepository authRepository;
  UserSignIn({required this.authRepository});

  @override
  ResultFuture<User> call(params) async {
    return await authRepository.signInWithEmailAndPassword(email: params.email, password: params.password);
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}
