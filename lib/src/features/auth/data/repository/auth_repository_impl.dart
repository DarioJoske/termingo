import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:termingo/src/core/errors/failures.dart';
import 'package:termingo/src/core/utils/typedefs.dart';
import 'package:termingo/src/features/auth/data/data_sources/firestore_auth_data_source.dart';
import 'package:termingo/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirestoreAuthDataSource _remoteDataSource;

  const AuthRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<User> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      final result = await _remoteDataSource.signUpWithEmailAndPassword(email: email, password: password);

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: '500'));
    }
  }

  @override
  ResultFuture<User> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final result = await _remoteDataSource.signInWithEmailAndPassword(email: email, password: password);

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: '500'));
    }
  }

  @override
  Stream<User?> authStateChanges() {
    try {
      return _remoteDataSource.authStateChanges;
    } catch (e) {
      throw ServerFailure(message: e.toString(), statusCode: '500');
    }
  }
}
