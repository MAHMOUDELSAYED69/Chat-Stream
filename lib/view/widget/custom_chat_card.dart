import 'package:chat_stream/helper/extentions/extentions.dart';
import 'package:flutter/material.dart';

import '../../helper/constant/colors.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    this.onTap,
    required this.name,
    required this.lastMessage,
    required this.time,
  });
  final void Function()? onTap;
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
          color: ColorManager.darkGrey2,
          border: Border.symmetric(
            horizontal: BorderSide(width: 2, color: ColorManager.black),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
                radius: 30,
                backgroundColor: ColorManager.darkGrey,
                child: Text(
                  name[0].toUpperCase(),
                  style: context.textTheme.bodyLarge,
                )),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.width / 2,
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyLarge?.copyWith(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    lastMessage,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(time, style: context.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
