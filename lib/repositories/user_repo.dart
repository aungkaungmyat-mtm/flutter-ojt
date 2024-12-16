import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ojt_project/config/config.dart';
import 'package:ojt_project/entities/user_data.dart';

import '../entities/entities.dart';

abstract class BaseUserRepository {
  String get generateNewId;
  Stream<auth.User?> authUserStream();
  Future<User?> getUserFuture({required String userId});
  Future<void> create(String authUserId);
  Future<void> signOut();
  Future<void> googleSignIn();
  Future<void> registerUser(String email, String password);
  Future<void> logIn(String email, String password);
}

class UserRepositoryImpl implements BaseUserRepository {
  final _auth = auth.FirebaseAuth.instance;
  final _userCollection = FirebaseFirestore.instance.collection('users');
  final _storage = FirebaseStorage.instance;

  @override
  Future<void> create(String authUserId) async {
    final currentUser = _auth.currentUser;

    if (currentUser == null) return;

    final userData = UserData(
      id: currentUser.providerData.first.uid!,
      name: currentUser.displayName ?? '',
      email: currentUser.email!,
      signInMethod: currentUser.providerData.first.providerId,
      photoUrl: currentUser.photoURL ?? '',
    );

    final newUser = User(
      id: authUserId,
      userData: [userData],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _userCollection.doc(authUserId).set(newUser.toJson());
  }

  @override
  String get generateNewId => _userCollection.doc().id;

  @override
  Stream<auth.User?> authUserStream() {
    return _auth.authStateChanges();
  }

  @override
  Future<User?> getUserFuture({required String userId}) async {
    final doc = await _userCollection.doc(userId).get();
    if (doc.exists) {
      return User.fromJson(doc.data()!);
    } else {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      logger.e('⚡ ERROR in signOut: $e');
      rethrow;
    }
  }

  @override
  Future<void> googleSignIn() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = auth.GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        await _auth.signInWithCredential(credential);
        logger.i('User Successfully Registered');
      } else {
        throw auth.FirebaseException(
          plugin: 'firebase_auth',
          code: 'select_one',
        );
      }
    } on auth.FirebaseAuthException catch (e) {
      logger.e('⚡ ERROR: $e');
      rethrow;
    }
  }

  @override
  Future<void> registerUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      logger.i('User Successfully Registered');
    } on auth.FirebaseAuthException catch (e) {
      logger.e('error during sign up: ${e.message}');
    }
  }

  @override
  Future<void> logIn(String email, String password) async {
    try {
      await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      logger.i('User Successfully Logged In');
    } on auth.FirebaseAuthException catch (e) {
      logger.e('error during sign in: ${e.message}');
    }
  }
}

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  return UserRepositoryImpl();
});
