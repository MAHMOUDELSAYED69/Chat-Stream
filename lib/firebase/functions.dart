import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunction {
  //! RESET PASSWORD
  static Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  //! LOG OUT
  static Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

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
}