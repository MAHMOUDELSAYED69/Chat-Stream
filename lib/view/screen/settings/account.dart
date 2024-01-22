import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import 'package:hambolah_chat_app/view/widget/setting_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.darkGrey,
      appBar: AppBar(
        elevation: BorderSide.strokeAlignOutside,
        backgroundColor: MyColors.purple,
        shadowColor: MyColors.darkGrey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        title: const Text("Account",
            style:
                TextStyle(fontWeight: FontWeight.w500, color: MyColors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SettingButton(
              title: "Change password",
              icon: Icons.lock,
              onTap: () {
                customDialog(context, title: "New Password", onPressed: () {});
              },
            ),
            SettingButton(
              title: "Change Email address",
              icon: Icons.email,
              onTap: () {
                customDialog(context, title: "New Email", onPressed: () {});
              },
            ),
            SettingButton(
              title: "Delete account",
              icon: Icons.delete,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> customDialog(BuildContext context,
      {required String title,
      TextEditingController? controller,
      void Function()? onPressed}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const BeveledRectangleBorder(
            side: BorderSide(color: MyColors.darkGrey),
            borderRadius: BorderRadius.all(Radius.circular(2))),
        backgroundColor: Colors.grey[50],
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w500, color: MyColors.black),
          textAlign: TextAlign.center,
        ),
        content: TextField(
          controller: controller,
          cursorColor: MyColors.black,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyColors.black)),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel,
                size: 35,
                color: MyColors.red,
              )),
          IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.check_circle,
                size: 35,
                color: MyColors.green,
              )),
        ],
      ),
    );
  }
}
