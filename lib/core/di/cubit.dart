part of "injection_container.dart";

Future<void> _initCubit()async{
  sl.registerFactory(() => AuthCubit(authRepository: sl<AuthRepository>()
  ));
}