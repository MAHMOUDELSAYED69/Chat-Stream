import 'package:chat_stream/helper/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:chat_stream/helper/constant/color.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
    this.bgColor,
    this.foColor,
  });
  final String title;
  final IconData? icon;
  final void Function()? onTap;
  final Color? bgColor;
  final Color? foColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: onTap ?? () {},
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2))),
          color: bgColor ?? ColorManager.darkGrey2,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  icon,
                  color: foColor ?? ColorManager.lightGrey,
                ),
              ),
              Text(
                title,
                style: context.textTheme.bodyMedium?.copyWith(color: foColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
