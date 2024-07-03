import 'package:flutter/material.dart';
import 'package:chat_stream/helper/extentions/extentions.dart';
import 'constant/color.dart';

//! custom snackBar
void customSnackBar(BuildContext context, String message,
    {Color? color, int? seconds}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: seconds ?? 3),
      backgroundColor: color ?? ColorManager.red,
      content: Center(
        child: Text(
          message,
          style:
              context.textTheme.bodyMedium?.copyWith(color: ColorManager.white),
        ),
      ),
    ),
  );
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
          side: BorderSide(color: ColorManager.darkGrey),
          borderRadius: BorderRadius.all(Radius.circular(2))),
      backgroundColor: Colors.grey[50],
      title: textWidget ??
          Text(
            title,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: ColorManager.black),
            textAlign: TextAlign.center,
          ),
      content: widget ??
          TextField(
            keyboardType: keyboardType,
            obscureText: isobscure,
            controller: controller,
            cursorColor: ColorManager.black,
            decoration: InputDecoration(
              hintText: hintText ?? "Password",
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.black)),
            ),
          ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(btnTitle.toString()),
          ),
        )
      ],
    ),
  );
}
