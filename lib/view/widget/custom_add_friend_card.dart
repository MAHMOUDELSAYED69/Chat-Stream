import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/view/widget/custom_button.dart';

import '../../core/constant/color.dart';

class AddFriendCard extends StatefulWidget {
  const AddFriendCard({
    super.key,
    this.onTap,
    required this.circleAvatar,
    required this.name,
    this.imagePath,
  });
  final void Function()? onTap;
  final String circleAvatar;
  final String name;
  final String? imagePath;

  @override
  State<AddFriendCard> createState() => _AddFriendCardState();
}

class _AddFriendCardState extends State<AddFriendCard> {
  bool isTap = false;
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
            backgroundImage: widget.imagePath != null
                ? FileImage(File(widget.imagePath!))
                : null,
            child: widget.imagePath == null
                ? Text(
                    widget.circleAvatar,
                    style: const TextStyle(fontSize: 20, color: MyColors.white),
                  )
                : null,
          ),
          const SizedBox(height: 10),
          Text(
            widget.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 18,
                color: MyColors.white,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          CustomButton(
            color: isTap ? MyColors.lightGrey : MyColors.purple,
            height: 40,
            widget: isTap
                ? const Text(
                    "Send",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : const Text(
                    "Add Friend",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            fontSize: 18,
            onPressed: () {
              isTap = !isTap;
              setState(() {});
              widget.onTap;
            },
          )
        ],
      ),
    );
  }
}
