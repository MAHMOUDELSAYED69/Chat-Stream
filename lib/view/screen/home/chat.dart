import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hambolah_chat_app/data/model/message_model.dart';
import 'package:hambolah_chat_app/logic/chat/chat_message_cubit/chat_message_cubit.dart';
import 'package:hambolah_chat_app/view/widget/custom_chat_bubble.dart';

import '../../../core/constant/color.dart';
import '../../../core/helper/responsive.dart';
import '../../widget/custom_chat_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textEditingController = TextEditingController();
  bool isMessageLoading = false;
  String? errorMessage;
  String senderId = FirebaseAuth.instance.currentUser!.uid;
  String senderEmail = FirebaseAuth.instance.currentUser!.email!;
  void chat(
    String parameter,
  ) {
    context.read<ChatMessageCubit>().sedMessage(
        senderEmail: senderEmail,
        senderId: senderId,
        receiverId: parameter,
        message: textEditingController.text,
        timeTamp: DateTime.timestamp());
    textEditingController.clear();
  }

  List<MessageModel> messageModel = [];
  @override
  Widget build(BuildContext context) {
    final String parameter =
        ModalRoute.of(context)!.settings.arguments as String;
    context
        .read<ChatMessageCubit>()
        .recivedMessage(senderId: senderId, receiverId: parameter);
    return Scaffold(
      backgroundColor: MyColors.darkGrey,
      appBar: AppBar(
        centerTitle: true,
        elevation: BorderSide.strokeAlignOutside,
        backgroundColor: MyColors.purple,
        shadowColor: MyColors.darkGrey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        title: const Text("Chat",
            style:
                TextStyle(fontWeight: FontWeight.w500, color: MyColors.black)),
      ),
      bottomNavigationBar: CustomChatTextField(
        controller: textEditingController,
        onPressed: () => chat(parameter),
        onSubmitted: (_) => chat(parameter),
      ),
      body: BlocConsumer<ChatMessageCubit, ChatMessageState>(
        listener: (context, state) {
          if (state is ChatMessageLoading) {
            isMessageLoading = true;
          }
          if (state is ChatSenderMessageSuccess) {
            isMessageLoading = false;
          }
          if (state is ChatReciverMessageSuccess) {
            isMessageLoading = false;
            messageModel = state.data;
          }
          if (state is ChatMessageFailure) {
            isMessageLoading = false;
            errorMessage = state.message;
          }
        },
        builder: (context, state) {
          return isMessageLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  reverse: true,
                  // shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: messageModel.length,
                  itemBuilder: (context, index) =>
                      parameter == messageModel[index].receiverId
                          ? ChatBubbleForFriend(
                              message: messageModel[index].message)
                          : ChatBubbleForCurrentUser(
                              message: messageModel[index].message),
                );
        },
      ),
    );
  }
}
