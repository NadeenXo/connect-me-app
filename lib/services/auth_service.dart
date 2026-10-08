import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  //If the user is already signed in, skip the login screen after app restart.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Future<UserCredential> signUp({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     return await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email.trim(),
  //       password: password,
  //     );
  //   } on FirebaseAuthException catch (error) {
  //     throw Exception(_getAuthErrorMessage(error));
  //   }
  // }

  Future<UserCredential> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception('Unable to create the user account.');
      }

      final userModel = UserBuilder()
          .setId(firebaseUser.uid)
          .setFullName(fullName.trim())
          .setEmail(email.trim())
          .build();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .set(userModel.toJson());

      return userCredential;
    } on FirebaseAuthException catch (error) {
      throw Exception(_getAuthErrorMessage(error));
    } catch (_) {
      throw Exception(
        'Account created, but the profile could not be saved. Please try again.',
      );
    }
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw Exception(_getAuthErrorMessage(error));
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (error) {
      throw Exception(_getAuthErrorMessage(error));
    }
  }

  String _getAuthErrorMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account was found with this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'The email or password is incorrect.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Please check your internet connection.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
