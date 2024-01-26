import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    this.onTap,
    required this.circleAvatar,
    required this.name,
    required this.lastMessage,
    required this.time,
  });
  final void Function()? onTap;
  final String circleAvatar;
  final String name;
  final String lastMessage;
  final String time;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: MyColors.darkGrey2,
            border: Border.symmetric(
                horizontal: BorderSide(width: 2, color: MyColors.black))),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: MyColors.darkGrey,
              child: Text(
                circleAvatar,
                style: const TextStyle(fontSize: 20, color: MyColors.white),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 24,
                      color: MyColors.white,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  lastMessage,
                  style:
                      const TextStyle(fontSize: 16, color: MyColors.lightGrey),
                ),
              ],
            ),
            const Spacer(),
            Text(time,
                style: const TextStyle(fontSize: 16, color: MyColors.lightGrey))
          ],
        ),
      ),
    );
  }
}
