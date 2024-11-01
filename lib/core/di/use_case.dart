// part of "injection_container.dart";
//
// Future<void> _initUseCase()async{
//   sl.registerLazySingleton(() => LoginUseCase(repository:  sl<AuthRepository>()));
//   sl.registerLazySingleton(() => RegisterUseCase(sl<AuthRepository>()));
//   sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));
//
// }