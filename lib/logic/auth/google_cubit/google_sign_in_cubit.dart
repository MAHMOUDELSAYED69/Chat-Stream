import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit() : super(GoogleSignInInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      log("Google User: $googleUser");

      if (googleUser == null) {
        emit(GoogleSignInFailure(message: "Google sign-in cancelled."));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      log("Credential: $credential");

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      log("User signed in successfully: ${userCredential.user?.displayName}");

      emit(GoogleSignInSuccess(user: userCredential.user));
    } catch (err, stackTrace) {
      log("Error during Google sign-in: $err\n$stackTrace");
      emit(GoogleSignInFailure(message: "Failed to sign in with Google."));
    }
  }
}
