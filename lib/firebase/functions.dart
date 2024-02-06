import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/cache/cache_functions.dart';

class FirebaseService {
  //! REGISTER
  static Future<void> register(
      {required String email, required String password}) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseAuth.instance.currentUser!
        .updateDisplayName(CacheData.getdata(key: "displayName"));
    FirebaseService.emailVerify();
    FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.uid,
      'name': userCredential.user!.displayName,
      'image': userCredential.user?.photoURL
    });
  }

//! LOGIN
  static Future<void> logIn(
      {required String email, required String password}) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'name': userCredential.user!.displayName,
      'image': userCredential.user?.photoURL
    }, SetOptions(merge: true));
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
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
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

  static Future<void> updateUserImage({String? urlImage}) async {
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(urlImage);
    log(FirebaseAuth.instance.currentUser!.photoURL.toString());
  }

  static Future<void> updateUserDisplayName({String? name}) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    log(FirebaseAuth.instance.currentUser!.displayName.toString());
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
}
