import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'change_name_state.dart';

class ChangeNameCubit extends Cubit<ChangeNameState> {
  ChangeNameCubit() : super(ChangeNameInitial());
  String? userName;

  Future<void> changeDisplayName({required String name}) async {
    emit(ChangeNameLoading());
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'name': name});
      await getUserName();
      emit(ChangeNameSuccess());
    } on FirebaseAuthException catch (err) {
      emit(ChangeNameFailure(message: err.code));
    } catch (err) {
      emit(ChangeNameFailure(message: err.toString()));
    }
  }

  Future<void> getUserName() async {
    emit(ChangeNameLoading());
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (doc.exists && doc.data()!.containsKey('name')) {
        userName = doc['name'];
        emit(ChangeNameSuccess());
      } else {
        userName = "Unknown User";
      }
    } on FirebaseException catch (err) {
      log('Failed to get user name: $err');
    }
  }
}
