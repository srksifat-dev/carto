part of "injection_container.dart";

Future<void> _initRepository()async{
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl<FirebaseAuthDataSource>()));

}