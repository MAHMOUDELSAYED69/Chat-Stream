import 'dart:io';

import 'package:flutter/material.dart';
import '../../core/constant/color.dart';

class FriendRequestCard extends StatelessWidget {
  const FriendRequestCard({
    super.key,
    required this.circleAvatar,
    required this.name,
    this.imagePath,
    this.onPressedFalse,
    this.onPressedTrue,
  });
  final void Function()? onPressedFalse;
  final void Function()? onPressedTrue;
  final String circleAvatar;
  final String name;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: MyColors.darkGrey2,
          border: Border.symmetric(
              horizontal: BorderSide(width: 2, color: MyColors.black))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: MyColors.darkGrey,
            backgroundImage:
                imagePath != null ? FileImage(File(imagePath!)) : null,
            child: imagePath == null
                ? Text(
                    circleAvatar,
                    style: const TextStyle(fontSize: 20, color: MyColors.white),
                  )
                : null,
          ),
          const SizedBox(height: 10),
          Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 18,
                color: MyColors.white,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: onPressedTrue,
                  icon: const Icon(
                    Icons.check_circle_outline,
                    size: 35,
                    color: MyColors.green,
                  )),
              IconButton(
                  onPressed: onPressedFalse,
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: 35,
                    color: MyColors.red,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
