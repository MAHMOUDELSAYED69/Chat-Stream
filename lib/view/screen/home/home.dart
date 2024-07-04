import 'package:chat_stream/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_stream/model/chat_card_model.dart';
import 'package:chat_stream/logic/chat/chat_message_cubit/chat_message_cubit.dart';
import '../../../logic/chat/chat_card_cubit/chat_card_cubit.dart';
import '../../widget/custom_chat_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatCardModel> _chatsList = [];

  void _goToChat(int index) {
    Navigator.pushNamed(context, RouteManager.chat, arguments: [
      _chatsList[index].uid,
      _chatsList[index].email,
      _chatsList[index].name ?? ""
    ]);

    context
        .read<ChatMessageCubit>()
        .recivedMessage(receiverId: _chatsList[index].uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Stream"),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, RouteManager.settings),
              icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: BlocBuilder<ChatCardCubit, ChatCardState>(
        builder: (context, state) {
          if (state is ChatCardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatCardSuccess) {
            _chatsList = state.data;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _chatsList.length,
              itemBuilder: (context, index) {
                return ChatCard(
                    onTap: () => _goToChat(index),
                    name: _chatsList[index].name!,
                    lastMessage: _chatsList[index].email,
                    time: "");
              },
            );
          }
          if (state is ChatCardFailure) {
            return Text('Error: ${state.message}');
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
