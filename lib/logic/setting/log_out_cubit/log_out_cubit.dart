import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../../helper/cache/cache_functions.dart';
import '../../../firebase/functions.dart';

enum LogOutState { initial, loading, success, failure }

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutState.initial);
  Future<void> logOut() async {
    emit(LogOutState.loading);
    try {
      await FirebaseService.logOut();
      CacheData.clearData(clearData: true);
      emit(LogOutState.success);
    } catch (err) {
      log(err.toString());
      emit(LogOutState.success);
    }
  }
}
