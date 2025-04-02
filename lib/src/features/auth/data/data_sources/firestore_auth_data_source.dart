import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:termingo/src/core/errors/exceptions.dart';

abstract interface class FirestoreAuthDataSource {
  Stream<User?> get authStateChanges;
  Future<User> signUpWithEmailAndPassword({required String email, required String password});
  Future<User> signInWithEmailAndPassword({required String email, required String password});
  Future<void> signOut();
}

class RemoteAuthDataSourceImpl implements FirestoreAuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  RemoteAuthDataSourceImpl({required this.firebaseAuth, required this.firebaseFirestore});

  @override
  Future<User> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final UserCredential response = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (response.user == null) {
        throw ServerException(message: 'User not found', statusCode: '404');
      }
      return response.user!;
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? '', statusCode: e.code);
    }
  }

  @override
  Future<User> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      final UserCredential response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException(message: 'User not found', statusCode: '404');
      }

      // create user in firestore
      await firebaseFirestore.collection('users').doc(response.user!.uid).set({
        'id': response.user!.uid,
        'email': response.user!.email,
        'name': response.user!.displayName ?? 'Name',
      });

      return response.user!;
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? '', statusCode: e.code);
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? '', statusCode: e.code);
    }
  }

  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();
}
