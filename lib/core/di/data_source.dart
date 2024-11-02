part of "injection_container.dart";

Future<void> _initDataSources()async{
  sl.registerSingleton<Dio>(Dio());
  sl.registerLazySingleton<FirebaseAuthDataSource>(
          () => FirebaseAuthDataSource(sl<FirebaseAuth>(), sl<FirebaseFirestore>()));
sl.registerLazySingleton<ShopDataSource>(
          () => ShopDataSource());
sl.registerLazySingleton<CartDataSource>(
          () => CartDataSource(firebaseFirestore: sl<FirebaseFirestore>()));

}