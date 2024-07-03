import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../helper/cache/cache_functions.dart';
import '../../../firebase/functions.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());
  Future<void> deleteAccount({required String password}) async {
    emit(DeleteAccountLoading());
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .delete();
        await FirebaseService.deleteUser(
            email: FirebaseAuth.instance.currentUser!.email.toString(),
            password: password);
        await CacheData.clearData(clearData: true);
        emit(DeleteAccountSuccess());
      }
    } on FirebaseAuthException catch (err) {
      emit(DeleteAccountFailure(message: err.code));
    } catch (err) {
      emit(DeleteAccountFailure(message: err.toString()));
    }
  }
}
