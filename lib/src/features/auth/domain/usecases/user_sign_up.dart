import 'package:firebase_auth/firebase_auth.dart';
import 'package:termingo/src/core/usecases/usecases.dart';
import 'package:termingo/src/core/utils/typedefs.dart';
import 'package:termingo/src/features/auth/domain/repositories/auth_repository.dart';

class UserSignUp implements UsecaseWithParams<User, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp({required this.authRepository});

  @override
  ResultFuture<User> call(params) async {
    return await authRepository.signUpWithEmailAndPassword(email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String email;
  final String password;

  UserSignUpParams({required this.email, required this.password});
}
