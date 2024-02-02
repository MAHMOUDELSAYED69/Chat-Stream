import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/helper/responsive.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
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
      bottomNavigationBar: const CustomChatTextField(),
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

class CustomChatTextField extends StatefulWidget {
  const CustomChatTextField({
    super.key,
  });

  @override
  State<CustomChatTextField> createState() => _CustomChatTextFieldState();
}

class _CustomChatTextFieldState extends State<CustomChatTextField> {
  final TextEditingController writeMessageController = TextEditingController();
  bool foucsColor = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 5),
        child: TextField(
          cursorColor: foucsColor ? MyColors.purple : MyColors.lightGrey,
          controller: writeMessageController,
          onTap: () {
            foucsColor = true;
            setState(() {});
          },
          onSubmitted: (_) {},
          onTapOutside: (_) {
            foucsColor = false;
            setState(() {});
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: MyColors.darkGrey2,
            hintText: '  Write your message',
            hintStyle: const TextStyle(color: MyColors.lightGrey),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.send_rounded,
                  color: foucsColor ? MyColors.purple : MyColors.lightGrey,
                  size: 30,
                ),
              ),
            ),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.grey,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: MyColors.purple,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
