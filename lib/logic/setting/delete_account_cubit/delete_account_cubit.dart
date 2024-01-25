import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../core/cache/cache_functions.dart';
import '../../../firebase/functions.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());
  Future<void> deleteAccount({required String password}) async {
    emit(DeleteAccountLoading());
    try {
      await FirebaseAuthService.deleteUser(
          email: FirebaseAuth.instance.currentUser!.email.toString(),
          password: password);
      if (FirebaseAuth.instance.currentUser == null) {
        CacheData.clearData(clearData: true);
        emit(DeleteAccountSuccess());
      }
    } on FirebaseAuthException catch (err) {
      emit(DeleteAccountFailure(message: err.code));
    } catch (err) {
      emit(DeleteAccountFailure(message: err.toString()));
    }
  }
}
