import 'package:chat_stream/helper/extentions/extentions.dart';
import 'package:flutter/material.dart';

import '../../helper/constant/colors.dart';

class CustomChatTextField extends StatefulWidget {
  const CustomChatTextField({
    super.key,
    this.onSubmitted,
    this.controller,
    this.onPressed,
  });
  final void Function(String)? onSubmitted;

  final void Function()? onPressed;
  final TextEditingController? controller;
  @override
  State<CustomChatTextField> createState() => _CustomChatTextFieldState();
}

class _CustomChatTextFieldState extends State<CustomChatTextField> {
  bool foucsColor = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Padding(
        padding: const EdgeInsets.only(right: 7, left: 7, top: 10, bottom: 5),
        child: TextField(
          keyboardType: TextInputType.text,
          cursorColor:
              foucsColor ? ColorManager.purple : ColorManager.lightGrey,
          controller: widget.controller,
          onTap: () {
            foucsColor = true;
            setState(() {});
          },
          onSubmitted: widget.onSubmitted,
          onTapOutside: (_) {
            foucsColor = false;
            setState(() {});
          },
          style:
              context.textTheme.bodyMedium?.copyWith(color: ColorManager.white),
          decoration: InputDecoration(
            hintText: ' Write your message...',
            hintStyle: context.textTheme.bodyMedium,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: widget.onPressed,
                icon: Icon(
                  Icons.send_rounded,
                  color:
                      foucsColor ? ColorManager.purple : ColorManager.lightGrey,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
