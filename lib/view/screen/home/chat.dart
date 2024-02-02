import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/helper/responsive.dart';
import '../../widget/custom_chat_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String parameter =
        ModalRoute.of(context)!.settings.arguments as String;

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
      bottomNavigationBar: CustomChatTextField(
        controller: textEditingController,
        onPressed: () => textEditingController.text,
        onSubmitted: (_) => textEditingController.text,
      ),
      body: Container(
        alignment: Alignment.center,
        width: ScreenSize.width,
        child: Column(
          children: [
            Text(
              parameter,
              style: const TextStyle(color: MyColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
