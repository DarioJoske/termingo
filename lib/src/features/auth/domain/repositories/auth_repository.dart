import 'package:firebase_auth/firebase_auth.dart';
import 'package:termingo/src/core/common/entities/app_user.dart';
import 'package:termingo/src/core/utils/typedefs.dart';

abstract interface class AuthRepository {
  ResultFuture<AppUser> signInWithEmailAndPassword({required String email, required String password});
  ResultFuture<AppUser> signUpWithEmailAndPassword({required String email, required String password});
  ResultFuture<AppUser> currentUser();
  Stream<User?> authStateChanges();
}
