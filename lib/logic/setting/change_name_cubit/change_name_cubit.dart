import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'name': name}, SetOptions(merge: true));
      emit(ChangeNameSuccess());
    } on FirebaseAuthException catch (err) {
      emit(ChangeNameFailure(message: err.code));
    } catch (err) {
      emit(ChangeNameFailure(message: err.toString()));
    }
  }
}
