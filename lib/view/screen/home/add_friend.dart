import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/view/widget/custom_add_friend_card.dart';

import '../../../core/constant/color.dart';

class AddFriend extends StatelessWidget {
  const AddFriend({super.key});

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
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: 20,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              const AddFriendCard(circleAvatar: "M", name: "Mahmoud El Sayed"),
        ));
  }
}
