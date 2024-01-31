import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final String parameter = ModalRoute.of(context)!.settings.arguments as String;
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
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              parameter,
              style: const TextStyle(color: MyColors.white),
            )
          ],
        ),
      ),
    );
  }
}
