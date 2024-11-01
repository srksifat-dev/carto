import 'package:carto/core/base/resources/data_state.dart';
import 'package:carto/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<DataState<UserEntity?>> register(
      {
        required String email,
        required String password,
        required String name,
        required String avatarUrl,
      });
  Future<DataState<UserEntity?>> login({required String email,required String password});
  Future<void> logout();
  Future<DataState<UserEntity?>> getCurrentUser();
}