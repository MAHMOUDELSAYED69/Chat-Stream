import 'package:chat_stream/view/widget/my_loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_stream/model/message_model.dart';
import 'package:chat_stream/logic/chat/chat_message_cubit/chat_message_cubit.dart';
import 'package:chat_stream/view/widget/custom_chat_bubble.dart';

import '../../../helper/constant/color.dart';
import '../../widget/custom_chat_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  late TextEditingController _textEditingController;
  bool _isMessageLoading = false;
  String? _errorMessage;
  List<MessageModel> _messageModel = [];

  void _sendMessage(
    String parameter,
  ) {
    if (_textEditingController.text.isNotEmpty) {
      context.read<ChatMessageCubit>().sendMessage(
            receiverId: parameter,
            message: _textEditingController.text,
          );
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> parameter =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    context.read<ChatMessageCubit>().recivedMessage(receiverId: parameter[0]);
    return Scaffold(
      appBar: AppBar(
        title: Text(parameter[2]),
      ),
      bottomNavigationBar: CustomChatTextField(
        controller: _textEditingController,
        onPressed: () => _sendMessage(parameter[0]),
        onSubmitted: (_) => _sendMessage(parameter[0]),
      ),
      body: BlocConsumer<ChatMessageCubit, ChatMessageState>(
        listener: (context, state) {
          if (state is ChatMessageLoading) {
            _isMessageLoading = true;
          }
          if (state is ChatSenderMessageSuccess) {
            _isMessageLoading = false;
          }
          if (state is ChatReciverMessageSuccess) {
            _isMessageLoading = false;
            _messageModel = state.data;
          }
          if (state is ChatMessageFailure) {
            _isMessageLoading = false;
            _errorMessage = state.message;
          }
        },
        builder: (context, state) {
          if (state is ChatReciverMessageSuccess) {
            _isMessageLoading = false;
            _messageModel = state.data;
          }
          return _isMessageLoading
              ? const Center(
                  child: MyLoadingIndicator(),
                )
              : ListView.builder(
                  reverse: true,
                  // shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _messageModel.length,
                  itemBuilder: (context, index) =>
                      _messageModel[index].senderId !=
                              FirebaseAuth.instance.currentUser!.uid
                          ? ChatBubbleForFriend(
                              message: _messageModel[index].message)
                          : ChatBubbleForCurrentUser(
                              message: _messageModel[index].message));
        },
      ),
    );
  }
}
