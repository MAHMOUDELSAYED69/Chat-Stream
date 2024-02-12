import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hambolah_chat_app/data/model/chat_card_model.dart';
import 'package:hambolah_chat_app/logic/chat/add_friend_cubit/add_friend_cubit.dart';

import '../../../core/constant/color.dart';
import '../../widget/custom_chat_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatCardModel> chats = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddFriendCubit>(context).buildAddFriendCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.darkGrey,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: 1,
              onPressed: () => Navigator.pushNamed(context, "/addFriend"),
              backgroundColor: MyColors.purple,
              child: const Icon(
                Icons.add,
                size: 30,
              )),
          const SizedBox(height: 10),
          FloatingActionButton(
              heroTag: 2,
              onPressed: () => Navigator.pushNamed(context, "/request"),
              backgroundColor: MyColors.purple,
              child: const Icon(
                Icons.people_alt_outlined,
                size: 30,
              )),
        ],
      ),
      appBar: AppBar(
        elevation: BorderSide.strokeAlignOutside,
        backgroundColor: MyColors.purple,
        shadowColor: MyColors.darkGrey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        title: const Text("Hambola",
            style:
                TextStyle(fontWeight: FontWeight.w500, color: MyColors.black)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: MyColors.black,
              )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/setting");
              },
              icon: const Icon(
                Icons.settings,
                color: MyColors.black,
              )),
        ],
      ),
      body: BlocBuilder<AddFriendCubit, AddFriendState>(
        builder: (context, state) {
          if (state is AddFriendLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddFriendSuccess) {
            chats = state.data;
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return ChatCard(
                    onTap: () {
                      Navigator.pushNamed(context, "/chat",
                          arguments: chats[index].email);
                    },
                    imagepath: chats[index].image,
                    circleAvatar: chats[index].name![0].toUpperCase(),
                    name: chats[index].name!,
                    lastMessage: chats[index].uid,
                    time: "7.56 AM");
              },
            );
          }
          if (state is AddFriendFailure) {
            return Text('Error: ${state.message}');
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
