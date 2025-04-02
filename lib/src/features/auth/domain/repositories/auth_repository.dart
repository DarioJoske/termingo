import 'package:firebase_auth/firebase_auth.dart';
import 'package:termingo/src/core/utils/typedefs.dart';

abstract interface class AuthRepository {
  ResultFuture<User> signInWithEmailAndPassword({required String email, required String password});
  ResultFuture<User> signUpWithEmailAndPassword({required String email, required String password});
  Stream<User?> authStateChanges();
}
