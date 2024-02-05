
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hambolah_chat_app/data/model/chat_card_model.dart';
import 'package:hambolah_chat_app/view/widget/custom_add_friend_card.dart';

import '../../../core/constant/color.dart';
import '../../../logic/chat/chat_card_cubit/chat_card_cubit.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  List<ChatCardModel> chats = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatCardCubit>(context).buildChatCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.darkGrey,
        appBar: AppBar(
          elevation: BorderSide.strokeAlignOutside,
          backgroundColor: MyColors.purple,
          shadowColor: MyColors.darkGrey,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          title: const Text("Add Friends",
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: MyColors.black)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: MyColors.black,
                  size: 30,
                )),
          ],
        ),
        body: BlocBuilder<ChatCardCubit, ChatCardState>(
          builder: (context, state) {
            if (state is ChatCardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatCardSuccess) {
              chats = state.data;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: chats.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => AddFriendCard(
                    circleAvatar: chats[index].email[0],
                    name: chats[index].email),
              );
            }
            if (state is ChatCardFailure) {
              return Text('Error: ${state.message}');
            } else {
              return Container();
            }
          },
        ));
  }
}
