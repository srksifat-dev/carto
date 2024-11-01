part of "injection_container.dart";

Future<void> _initDataSources()async{
  sl.registerLazySingleton<FirebaseAuthDataSource>(
          () => FirebaseAuthDataSource(sl<FirebaseAuth>(), sl<FirebaseFirestore>()));

}