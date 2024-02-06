import 'dart:io';

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
    this.imagepath,
  });
  final void Function()? onTap;
  final String circleAvatar;
  final String name;
  final String lastMessage;
  final String time;
  final String? imagepath;

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
              backgroundImage:
                  imagepath != null ? FileImage(File(imagepath!)) : null,
              child: imagepath == null
                  ? Text(
                      circleAvatar,
                      style:
                          const TextStyle(fontSize: 20, color: MyColors.white),
                    )
                  : null,
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 24,
                        color: MyColors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    lastMessage,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, color: MyColors.lightGrey),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(time,
                style:
                    const TextStyle(fontSize: 16, color: MyColors.lightGrey)),
          ],
        ),
      ),
    );
  }
}
