import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class FirendRequestScreen extends StatelessWidget {
  const FirendRequestScreen({super.key});

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
        title: const Text("Friend request",
            style:
                TextStyle(fontWeight: FontWeight.w500, color: MyColors.black)),
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
      body: Column(children: [
        //build friend request card.
      ],),
    );
  }
}
