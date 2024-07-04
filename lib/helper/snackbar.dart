import 'package:flutter/material.dart';
import 'package:chat_stream/helper/extentions/extentions.dart';
import 'constant/colors.dart';

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
    required String btnTitle,
    TextEditingController? controller,
    void Function()? onPressed,
    bool isobscure = false,
    String? hintText,
    Widget? textWidget,
    Widget? widget,
    Color? titleColor}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))),
      backgroundColor: context.theme.scaffoldBackgroundColor,
      title: textWidget ??
          Text(
            title,
            style: context.textTheme.bodyLarge?.copyWith(color: titleColor),
            textAlign: TextAlign.center,
          ),
      content: widget ??
          TextField(
            style: context.textTheme.bodyMedium
                ?.copyWith(color: ColorManager.white),
            keyboardType: TextInputType.visiblePassword,
            obscureText: isobscure,
            controller: controller,
            decoration: InputDecoration(
              hintText: "Password",
              hintStyle: context.textTheme.bodyMedium,
              filled: false,
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.white)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.white)),
            ),
          ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(btnTitle),
          ),
        )
      ],
    ),
  );
}
