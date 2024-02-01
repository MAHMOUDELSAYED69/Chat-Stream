import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';

class ChatBubbleForCurrentUser extends StatelessWidget {
  const ChatBubbleForCurrentUser({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 10),
        margin: const EdgeInsets.only(left: 16, top: 8, bottom: 16, right: 100),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          color: MyColors.purple,
        ),
        child: Text(
          message,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 18,
            color: MyColors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);

  // final Message message;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 10),
        margin: const EdgeInsets.only(left: 100, top: 8, bottom: 16, right: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            topLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          color: MyColors.darkGrey,
        ),
        child: Text(
          message,
          // message.message,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
