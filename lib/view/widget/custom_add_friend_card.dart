import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/view/widget/custom_button.dart';

import '../../core/constant/color.dart';

class AddFriendCard extends StatefulWidget {
  const AddFriendCard({
    super.key,
    this.onTap,
    required this.circleAvatar,
    required this.name,
  });
  final void Function()? onTap;
  final String circleAvatar;
  final String name;

  @override
  State<AddFriendCard> createState() => _AddFriendCardState();
}

class _AddFriendCardState extends State<AddFriendCard> {
  bool isTap = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 170,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: MyColors.darkGrey2,
            border: Border.symmetric(
                horizontal: BorderSide(width: 2, color: MyColors.black))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: MyColors.darkGrey,
              child: Text(
                widget.circleAvatar,
                style: const TextStyle(fontSize: 20, color: MyColors.white),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 24,
                  color: MyColors.white,
                  fontWeight: FontWeight.w500),
            ),
            CustomButton(
              color: isTap ? MyColors.lightGrey : MyColors.purple,
              height: 45,
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
      ),
    );
  }
}
