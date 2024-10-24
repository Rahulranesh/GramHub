import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/app_user.dart';
import 'package:socialmedia/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  // Fixed class name typo
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // Create user
      AppUser user =
          AppUser(uid: userCredential.user!.uid, email: email, name: '');

      // Return user
      return user;
    } catch (e) {
      debugPrint('Login failed: $e'); // Log the error
      return null; // Gracefully handle the error
    }
  }

  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Create user
      AppUser user =
          AppUser(uid: userCredential.user!.uid, email: email, name: name);

      //save user data to db
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(user.toJson());

      // Return user
      return user;
    } catch (e) {
      debugPrint('Registration failed: $e'); // Log the error
      return null; // Gracefully handle the error
    }
  }

  Future<AppUser?> logout() async {
    await firebaseAuth.signOut(); // Await sign out
    return null; // Indicate user has been logged out
  }

  Future<AppUser?> getCurrentUser() async {
    final firebaseuser = firebaseAuth.currentUser;
    if (firebaseuser == null) {
      return null;
    } else {
      return AppUser(
          uid: firebaseuser.uid, email: firebaseuser.email!, name: '');
    }
  }
}
