import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hambolah_chat_app/data/model/message_model.dart';
import 'package:meta/meta.dart';

part 'chat_message_state.dart';

class ChatMessageCubit extends Cubit<ChatMessageState> {
  ChatMessageCubit() : super(ChatMessageInitial());
  CollectionReference messageRef =
      FirebaseFirestore.instance.collection('message');
  String user = FirebaseAuth.instance.currentUser!.email!;

  Future<void> sedMessage({
    required String senderEmail,
    required String senderId,
    required String receiverId,
    required String message,
    required DateTime timeTamp,
  }) async {
    emit(ChatMessageLoading());
    try {
      await messageRef.doc(user).set({
        MessageModel(
                senderEmail: senderEmail,
                senderId: senderId,
                receiverId: receiverId,
                message: message,
                timeTamp: timeTamp.toString())
            .toJson()
      });
      emit(ChatSenderMessageSuccess());
    } on FirebaseException catch (err) {
      emit(ChatMessageFailure(message: err.toString()));
      log(err.toString());
    }
  }

  void recivedMessage({required String senderId, required String receiverId}) {
    try {
      emit(ChatMessageLoading());
      messageRef
          .where('senderId', isEqualTo: senderId)
          .where('receiverId', isEqualTo: receiverId)
          .orderBy('timeTamp', descending: true)
          .snapshots()
          .listen((event) {
        List<MessageModel> messageModel = [];
        for (var doc in event.docs) {
          messageModel.add(MessageModel.fromJson(doc.data()));
        }
        emit(ChatReciverMessageSuccess(data: messageModel));
      });
    } on FirebaseException catch (err) {
      emit(ChatMessageFailure(message: err.toString()));
      log(err.toString());
    }
  }
}
