import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hambolah_chat_app/core/cache/cache_functions.dart';
import 'package:hambolah_chat_app/firebase/functions.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> userRegister(
      {required String email, required String password}) async {
    try {
      emit(RegisterLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(CacheData.getdata(key: "displayName"));
      FirebaseAuthService.emailVerify();
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (err) {
      emit(RegisterFailure(message: err.code));
    } catch (err) {
      emit(RegisterFailure(message: err.toString()));
    }
  }
}
