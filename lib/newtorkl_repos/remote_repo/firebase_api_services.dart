import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseApiSAuthServices {
  static FirebaseApiSAuthServices instance = FirebaseApiSAuthServices();

  static Future<void> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

      log(credential.user!.email.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //sign in
  static Future<void> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      log(credential.user!.email.toString());
      credential.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }

  //sign out

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //reset password

  static Future<void> resetPassword({required String emailAddress}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
  }

  //verify email

  static Future<void> verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  //update password

  static Future<void> updatePassword({required String newPassword}) async {
    await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
  }

  //google sign in
}
