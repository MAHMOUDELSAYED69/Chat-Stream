import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/view/widget/custom_button.dart';
import '../constant/color.dart';

//! custom snackBar
void customSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Center(
        child: Text(
          message,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      )));
}

//! custom dialog
Future<void> customDialog(BuildContext context,
    {required String title,
     String? btnTitle,
    TextEditingController? controller,
    void Function()? onPressed,
    TextInputType? keyboardType,
    bool isobscure = false,
    String? hintText,
    Widget? textWidget,
    Widget? widget}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: const BeveledRectangleBorder(
          side: BorderSide(color: MyColors.darkGrey),
          borderRadius: BorderRadius.all(Radius.circular(2))),
      backgroundColor: Colors.grey[50],
      title: textWidget ??
          Text(
            title,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: MyColors.black),
            textAlign: TextAlign.center,
          ),
      content: widget ??
          TextField(
            keyboardType: keyboardType,
            obscureText: isobscure,
            controller: controller,
            cursorColor: MyColors.black,
            decoration: InputDecoration(
              hintText: hintText ?? "Password",
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: MyColors.black)),
            ),
          ),
      actions: [
        Center(
          child: CustomButton(
            onPressed: onPressed,
            height: 50,
            width: 200,
            title: btnTitle,
          ),
        )
      ],
    ),
  );
}
