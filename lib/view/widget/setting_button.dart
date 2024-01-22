import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
        color: MyColors.darkGrey2,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Icon(
                icon,
                color: MyColors.white,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColors.white),
            )
          ],
        ),
      ),
    );
  }
}
