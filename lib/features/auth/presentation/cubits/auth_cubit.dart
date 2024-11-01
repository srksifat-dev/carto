import 'package:carto/features/auth/data/models/user_model.dart';
import 'package:carto/features/auth/domain/entities/user_entity.dart';
import 'package:carto/features/auth/domain/repositories/auth_repository.dart';
import 'package:carto/features/auth/presentation/cubits/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  UserEntity? currentUser;

  AuthCubit({
    required this.authRepository,
  }) : super(AuthInitial());

  void checkAuth() async {
    final userdataState = await authRepository.getCurrentUser();
    final user = userdataState.data;
    if (user != null) {
      currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      final userDataState =
          await authRepository.login(email: email, password: password);
      final user = userDataState.data;
      if (user != null) {
        currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String avatarUrl,
  }) async {
    try {
      emit(AuthLoading());
      final userDataState = await authRepository.register(
        email: email,
        password: password,
        name: name,
        avatarUrl: avatarUrl,
      );
      final user = userDataState.data;
      if (user != null) {
        currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void>logout()async{
    authRepository.logout();
    emit(Unauthenticated());
  }
}
