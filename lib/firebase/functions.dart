import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  //! REGISTER
  static Future<void> register(
      {required String email,
      required String password,
      required String userName}) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'name': userName,
      'emailVerify': false,
    });

    FirebaseService.emailVerify();
  }

//! LOGIN
  static Future<void> logIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user?.emailVerified == true) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .update({
          'emailVerify': true,
        });
      }
    } catch (err) {
      log(err.toString());
    }
  }

  //! RESET PASSWORD
  static Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  //! LOG OUT
  static Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //! EMAIL VERIFY
  static Future<void> emailVerify() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (err) {
      log(err.message.toString());
    }
  }

  //! DELETE USER
  static Future<void> deleteUser(
      {required String email, required String password}) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final User? user = firebaseAuth.currentUser;
    if (user != null) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );

        await user.reauthenticateWithCredential(credential);
        await user.delete();
        log('User account deleted successfully.');
      } catch (e) {
        log('An error occurred while deleting the user account: $e');
      }
    } else {
      log('No user is currently signed in.');
    }
  }

//! CHANGE EMAIL
  static Future<void> changeEmail(String newEmail) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      if (!user.emailVerified) {
        log("Please verify the new email before changing email.");
        return;
      }

      await user.updateEmail(newEmail);
      log("Email address updated successfully");
    } catch (error) {
      log("Error updating email: $error");
    }
  }

//! CHANGE EMAIL WITH REAUTH
  static Future<void> updateEmailWithReauth(
      {required String newEmail, required String password}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: password);
        await user.reauthenticateWithCredential(credential);

        await user.updateEmail(newEmail);
        log("Email updated successfully to $newEmail");
      } else {
        log("User not signed in.");
      }
    } catch (e) {
      log("Error updating email: $e]");
    }
  }

  static Future<void> updateUserDisplayName({String? name}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'name': name});
    log(FirebaseAuth.instance.currentUser!.displayName.toString());
  }

  // static Future<void> friendRequest(dynamic user) async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user)
  //       .update({'isFriend': 1});
  //   log('done');
  // }
}
