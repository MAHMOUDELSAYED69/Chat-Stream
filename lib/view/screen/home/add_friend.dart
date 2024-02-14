import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hambolah_chat_app/data/model/add_friend_model.dart';
import 'package:hambolah_chat_app/logic/chat/add_friend_cubit/add_friend_cubit.dart';
import 'package:hambolah_chat_app/view/widget/custom_add_friend_card.dart';

import '../../../core/constant/color.dart';
import '../../../firebase/functions.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  List<AddFriendModel> chats = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddFriendCubit>(context).buildAddFriendCard();
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
        body: BlocBuilder<AddFriendCubit, AddFriendState>(
          builder: (context, state) {
            if (state is AddFriendLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AddFriendSuccess) {
              chats = state.data;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: chats.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => AddFriendCard(
                  onTap: () {
                    BlocProvider.of<AddFriendCubit>(context)
                        .addFriend(chats[index].uid);
                  },
                  circleAvatar: chats[index].name![0].toUpperCase(),
                  name: chats[index].name!,
                  imagePath: chats[index].image,
                ),
              );
            }
            if (state is AddFriendFailure) {
              return Text('Error: ${state.message}');
            } else {
              return Container();
            }
          },
        ));
  }
}
