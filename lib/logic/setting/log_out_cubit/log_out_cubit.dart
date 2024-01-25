import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../../core/cache/cache_functions.dart';
import '../../../firebase/functions.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());
  Future<void> logOut() async {
    emit(LogOutLoading());
    try {
      await FirebaseAuthService.logOut();
      CacheData.clearData(clearData: true);
      emit(LogOutSuccess());
    } on FirebaseAuthException catch (err) {
      emit(LogOutFailure(message: err.code));
    } catch (err) {
      emit(LogOutFailure(message: err.toString()));
    }
  }
}
