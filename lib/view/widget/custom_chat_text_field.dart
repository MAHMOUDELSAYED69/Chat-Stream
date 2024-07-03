import 'package:flutter/material.dart';

import '../../helper/constant/color.dart';

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
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 5),
        child: TextField(
          cursorColor: foucsColor ? ColorManager.purple : ColorManager.lightGrey,
          controller: widget.controller,
          onTap: () {
            foucsColor = true;
            setState(() {});
          },
          onSubmitted: widget.onSubmitted,
          // onTapOutside: (_) {
          //   foucsColor = false;
          //   setState(() {});
          // },
          style: const TextStyle(color: ColorManager.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorManager.darkGrey2,
            hintText: '  Write your message',
            hintStyle: const TextStyle(color: ColorManager.lightGrey),
            suffixIcon: IconButton(
              onPressed: widget.onPressed,
              icon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.send_rounded,
                  color: foucsColor ? ColorManager.purple : ColorManager.lightGrey,
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
                color: ColorManager.purple,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
