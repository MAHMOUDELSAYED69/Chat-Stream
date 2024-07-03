import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../model/chat_card_model.dart';

part 'chat_card_state.dart';

class ChatCardCubit extends Cubit<ChatCardState> {
  ChatCardCubit() : super(ChatCardInitial());
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  Future<void> buildChatCard() async {
    emit(ChatCardLoading());
    try {
      usersCollection.snapshots().listen((event) {
        List<ChatCardModel> chatCardList = [];
        for (var doc in event.docs) {
          if (doc['uid'] != FirebaseAuth.instance.currentUser?.uid) {
            if (doc['emailVerify'] ==true) {
              chatCardList.add(ChatCardModel.fromJson(doc));
            }
          }
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
