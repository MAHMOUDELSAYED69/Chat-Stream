import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hambolah_chat_app/data/model/message_model.dart';
import 'package:hambolah_chat_app/logic/chat/chat_message_cubit/chat_message_cubit.dart';
import 'package:hambolah_chat_app/view/widget/custom_chat_bubble.dart';

import '../../../core/constant/color.dart';
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
  void chat(
    String parameter,
  ) {
    if (textEditingController.text.isNotEmpty) {
      BlocProvider.of<ChatMessageCubit>(context).sedMessage(
        receiverId: parameter,
        message: textEditingController.text,
      );
      textEditingController.clear();
    }
  }

  List<MessageModel> messageModel = [];
  @override
  Widget build(BuildContext context) {
    final List<String> parameter =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    BlocProvider.of<ChatMessageCubit>(context)
        .recivedMessage(receiverId: parameter[0]);
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
        title: Text(parameter[2],
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: MyColors.black)),
      ),
      bottomNavigationBar: CustomChatTextField(
        controller: textEditingController,
        onPressed: () => chat(parameter[0]),
        onSubmitted: (_) => chat(parameter[0]),
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
          if (state is ChatReciverMessageSuccess) {
            isMessageLoading = false;
            messageModel = state.data;
          }
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
                      messageModel[index].senderId !=
                              FirebaseAuth.instance.currentUser!.uid
                          ? ChatBubbleForCurrentUser(
                              message: messageModel[index].message)
                          : ChatBubbleForFriend(
                              message: messageModel[index].message));
        },
      ),
    );
  }
}
