// lib/data/datasources/firebase_auth_data_source.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  FirebaseAuthDataSource(this.firebaseAuth, this.firestore);

  Future<UserModel> register(String email, String password, String name, String avatarUrl) async {
 final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userId = userCredential.user!.uid;

    final userJson = {
      'id': userId,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
    };
    await firestore.collection('users').doc(userId).set(userJson);
return UserModel.fromFirebaseUser(userCredential.user!);
  }

  Future<UserModel> login(String email, String password) async {
final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userId = userCredential.user!.uid;

    final userDoc = await firestore.collection('users').doc(userId).get();
return UserModel.fromMap(userDoc.data()!);
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  Stream<UserModel?> get authStateChanges =>
      firebaseAuth.authStateChanges().map((user) => user != null ? UserModel.fromFirebaseUser(user) : null);

  Future<UserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }
}
