import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../../../data/model/chat_card_model.dart';
part 'chat_card_state.dart';

class ChatCardCubit extends Cubit<ChatCardState> {
  ChatCardCubit() : super(ChatCardInitial());

  Future<void> buildChatCard() async {
    emit(ChatCardLoading());
    try {
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      log(usersCollection.toString());

      usersCollection.snapshots().listen((event) {
        List<ChatCardModel> chatCardList = [];
        for (var doc in event.docs) {
          chatCardList.add(ChatCardModel.fromJson(doc));
        }
        emit(ChatCardSuccess(data: chatCardList));
      });
    } on FirebaseFirestore catch (err) {
      emit(ChatCardFailure(message: err.toString()));
    } catch (err) {
      emit(ChatCardFailure(message: err.toString()));
    }
  }
}
