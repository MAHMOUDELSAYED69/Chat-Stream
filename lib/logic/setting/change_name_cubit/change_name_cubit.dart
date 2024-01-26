import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hambolah_chat_app/firebase/functions.dart';
import 'package:meta/meta.dart';

part 'change_name_state.dart';

class ChangeNameCubit extends Cubit<ChangeNameState> {
  ChangeNameCubit() : super(ChangeNameInitial());
  Future<void> changeDisplayName({required String name}) async {
    emit(ChangeNameLoading());
    try {
      await FirebaseService.updateUserDisplayName(name: name);
      emit(ChangeNameSuccess());
    } on FirebaseAuthException catch (err) {
      emit(ChangeNameFailure(message: err.code));
    } catch (err) {
      emit(ChangeNameFailure(message: err.toString()));
    }
  }
}
