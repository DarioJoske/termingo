import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:termingo/src/core/errors/exceptions.dart';
import 'package:termingo/src/features/auth/data/models/app_user_model.dart';

abstract interface class FirestoreAuthDataSource {
  User? get currentUser;
  Stream<User?> get authStateChanges;
  Future<AppUserModel> signUpWithEmailAndPassword({required String email, required String password});
  Future<AppUserModel> signInWithEmailAndPassword({required String email, required String password});
  Future<void> signOut();
  Future<AppUserModel?> getCurrentUserData();
}

class RemoteAuthDataSourceImpl implements FirestoreAuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  RemoteAuthDataSourceImpl({required this.firebaseAuth, required this.firebaseFirestore});

  @override
  Future<AppUserModel> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final UserCredential response = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (response.user == null) {
        throw ServerException(message: 'User not found', statusCode: '404');
      }
      return AppUserModel.fromJson({
        'id': response.user!.uid,
        'email': response.user!.email,
        'name': response.user!.displayName ?? 'Name',
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? '', statusCode: e.code);
    }
  }

  @override
  Future<AppUserModel> signUpWithEmailAndPassword({required String email, required String password}) async {
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

      return AppUserModel.fromJson({
        'id': response.user!.uid,
        'email': response.user!.email,
        'name': response.user!.displayName ?? 'Name',
      });

      // response.user?.sendEmailVerification();
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
  Future<AppUserModel?> getCurrentUserData() async {
    try {
      final User? user = firebaseAuth.currentUser;
      if (user == null) {
        return null;
      }

      final userDoc = await firebaseFirestore.collection('users').doc(user.uid).get();
      if (!userDoc.exists) {
        return null;
      }
      final userData = userDoc.data();

      if (userData == null) {
        return null;
      }

      return AppUserModel.fromJson({'id': user.uid, 'email': user.email, 'name': user.displayName ?? 'Name'});
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? '', statusCode: e.code);
    } catch (e) {
      ServerException(message: e.toString(), statusCode: '500');
    }
    return null;
  }

  @override
  User? get currentUser => firebaseAuth.currentUser;

  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();
}
