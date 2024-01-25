import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../firebase/functions.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  Future<void> resetPassword({required String email}) async {
    emit(ForgetPasswordLoading());
    try {
      await FirebaseAuthService.resetPassword(email: email);
      emit(ForgetPasswordSuccess());
    } on FirebaseAuthException catch (err) {
      emit(ForgetPasswordFailure(message: err.code));
    } catch (err) {
      emit(ForgetPasswordFailure(message: err.toString()));
    }
  }
}
