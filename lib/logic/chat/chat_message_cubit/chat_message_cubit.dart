import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hambolah_chat_app/data/model/message_model.dart';
import 'package:meta/meta.dart';

part 'chat_message_state.dart';

class ChatMessageCubit extends Cubit<ChatMessageState> {
  ChatMessageCubit() : super(ChatMessageInitial());
  User user = FirebaseAuth.instance.currentUser!;

  Future<void> sedMessage({
    required String receiverId,
    required String message,
  }) async {
    emit(ChatMessageLoading());
    try {
      MessageModel messageModel = MessageModel(
          senderEmail: user.email!,
          senderId: user.uid,
          receiverId: receiverId,
          message: message,
          timeTamp: DateTime.now().toString());
      List<String> ids = [user.uid, receiverId];
      ids.sort();
      String chatRoomId = ids.join("_");
      await FirebaseFirestore.instance
          .collection('chat_room')
          .doc(chatRoomId)
          .collection('messages')
          .add(messageModel.toJson());

      emit(ChatSenderMessageSuccess());
    } on FirebaseException catch (err) {
      emit(ChatMessageFailure(message: err.toString()));
      log(err.toString());
    }
  }

  void recivedMessage({required String receiverId}) {
    emit(ChatMessageLoading());
    try {
      List<String> ids = [user.uid, receiverId];
      ids.sort();
      String chatRoomId = ids.join("_");
      List<MessageModel> messageModel = [];
      FirebaseFirestore.instance
          .collection('chat_room')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timeTamp', descending: false)
          .snapshots()
          .listen((event) {
        List<MessageModel> messageModel = [];
        for (var doc in event.docs) {
          messageModel.add(MessageModel.fromJson(doc.data()));
        }
        emit(ChatReciverMessageSuccess(data: messageModel));
      });

      emit(ChatReciverMessageSuccess(data: messageModel));
    } on FirebaseException catch (err) {
      emit(ChatMessageFailure(message: err.toString()));
      log(err.toString());
    }
  }
}
