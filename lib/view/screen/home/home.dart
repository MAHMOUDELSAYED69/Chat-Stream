import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hambolah_chat_app/data/model/chat_card_model.dart';

import '../../../core/constant/color.dart';
import '../../../logic/chat/chat_card_cubit/chat_card_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatCardModel> chats = [];
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
        title: const Text("Hambola",
            style:
                TextStyle(fontWeight: FontWeight.w500, color: MyColors.black)),
        actions: [
          IconButton(
              onPressed: () {
               
              },
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
      body: BlocBuilder<ChatCardCubit, ChatCardState>(
        builder: (context, state) {
          if (state is ChatCardLoading) {
            return const CircularProgressIndicator();
          } else if (state is ChatCardSuccess) {
            chats = state.data;
            log(state.data.toString());
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                log(chats[index].email);
                return ListTile(
                  title: Text(
                    chats[index].email,
                    style: const TextStyle(color: MyColors.white),
                  ),
                  subtitle: Text(
                    chats[index].uid,
                    style: const TextStyle(color: MyColors.white),
                  ),
                );
              },
            );
          } else if (state is ChatCardFailure) {
            return Text('Error: ${state.message}');
          } else {
            return Container();
          }
        },
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       const SizedBox(height: 10),
      //       ChatCard(
      //           onTap: () {},
      //           circleAvatar: "M",
      //           name: "Mahmoud",
      //           lastMessage: "hello every boding",
      //           time: "7.56 AM"),
      //       ChatCard(
      //           onTap: () {},
      //           circleAvatar: "M",
      //           name: "Mahmoud",
      //           lastMessage: "hello every boding",
      //           time: "7.56 AM"),
      //       ChatCard(
      //           onTap: () {},
      //           circleAvatar: "M",
      //           name: "Mahmoud",
      //           lastMessage: "hello every boding",
      //           time: "7.56 AM"),
      //     ],
      //   ),
      // ),
    );
  }
}
