part of "injection_container.dart";

Future<void> _initRepository()async{
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl<FirebaseAuthDataSource>()));
  sl.registerLazySingleton<ShopRepository>(() => ShopRepositoryImpl(shopDataSource: sl<ShopDataSource>()));

}