import 'package:carto/core/base/resources/data_state.dart';
import 'package:carto/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data_sources/firebase_auth_data_source.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource;

  AuthRepositoryImpl(this.firebaseAuthDataSource);

  @override
  Future<DataState<UserEntity?>> register({
    required String email,
    required String password,
    required String name,
    required String avatarUrl,
  }) async {
    try {
      final user = await firebaseAuthDataSource.register(
          email, password, name, avatarUrl);
      return DataSuccess(user);
    } on FirebaseAuthException catch (error) {
      return DataFailed(error.toString());
    }
  }

  @override
  Future<DataState<UserEntity?>> login({required String email,required String password}) async {
    try {
      final user = await firebaseAuthDataSource.login(email, password);
      return DataSuccess(user);
    } on FirebaseAuthException catch (error) {
      return DataFailed(error.toString());
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuthDataSource.logout();
  }

  Stream<UserEntity?> get authStateChanges =>
      firebaseAuthDataSource.authStateChanges;

  @override
  Future<DataState<UserEntity?>> getCurrentUser() async {
    try {
      final user = await firebaseAuthDataSource.getCurrentUser();
      return DataSuccess(user);
    } on FirebaseAuthException catch (error) {
      return DataFailed(error.toString());
    }
  }
}
