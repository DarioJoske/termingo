import 'package:firebase_auth/firebase_auth.dart';
import 'package:termingo/src/core/usecases/usecases.dart';
import 'package:termingo/src/features/auth/domain/repositories/auth_repository.dart';

class AuthStateChanges implements StreamUsecaseWithoutParams<User?> {
  final AuthRepository authRepository;
  const AuthStateChanges({required this.authRepository});

  @override
  Stream<User?> call() {
    return authRepository.authStateChanges();
  }
}
