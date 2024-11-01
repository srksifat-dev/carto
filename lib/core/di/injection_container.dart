import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/data_sources/firebase_auth_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/cubits/auth_cubit.dart';

part 'cubit.dart';
part 'data_source.dart';
part 'firebase.dart';
part 'repository.dart';

final sl = GetIt.instance;

Future<void> init()async{
  await _initFirebase();
  await _initDataSources();
  await _initCubit();
  await _initRepository();
}