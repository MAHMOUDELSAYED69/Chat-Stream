import 'package:flutter/material.dart';
import '../../core/helper/responsive.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.title,
      this.onPressed,
      this.color,
      this.height,
      this.width,
      this.fontSize,
      this.widget,
      this.borderRadius});
  final String? title;
  final void Function()? onPressed;
  final Color? color;
  final double? height;
  final double? width;
  final double? fontSize;
  final Widget? widget;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 15)),
            backgroundColor: color ?? const Color(0xff313131),
            fixedSize: Size(width ?? double.maxFinite,
                height ?? ScreenSize.height * 0.07262845849)),
        onPressed: onPressed,
        child: widget ??
            Text(title ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize ?? 18,
                  fontWeight: FontWeight.w600,
                )));
  }
}
