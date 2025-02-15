import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository(this._auth, this._firestore);

  /// **Get current user stream**
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// **Sign in with email & password**
  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();

      if (!userDoc.exists) {
        return null;
      }

      return UserModel.fromFirestore(userDoc);
    } catch (e) {
      throw Exception("Sign-in failed: $e");
    }
  }

  /// **Sign out user**
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserModel?> autoLogin() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return getCurrentUser(); // Fetch user data from Firestore
  }
  return null;
}


  /// **Check if user is logged in**
  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();

    if (!userDoc.exists) return null;

    return UserModel.fromFirestore(userDoc);
  }
}

/// **Auth Repository Provider**
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance);
});
