import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import '../../core/helper/responsive.dart';

class CustomButton extends StatefulWidget {
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
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 3),
        ),
        backgroundColor: isHover
            ? widget.color?.withOpacity(0.5) ?? MyColors.red.withOpacity(0.5)
            : widget.color ?? MyColors.purple,
        fixedSize: Size(
          widget.width ?? double.maxFinite,
          widget.height ?? ScreenSize.height * 0.07262845849,
        ),
      ),
      onPressed: widget.onPressed,
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      child: widget.widget ??
          Text(
            widget.title ?? "",
            style: TextStyle(
              color: Colors.white,
              fontSize: widget.fontSize ?? 22,
              fontWeight: FontWeight.w600,
            ),
          ),
    );
  }
}
