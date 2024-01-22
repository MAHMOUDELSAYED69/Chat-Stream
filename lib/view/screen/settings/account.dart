import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import 'package:hambolah_chat_app/firebase/functions.dart';
import 'package:hambolah_chat_app/view/widget/setting_button.dart';

import '../../../core/helper/snackbar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController emailController = TextEditingController();
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
                customDialog(context, btnTitle: "Send", title: "Reset Password",
                    onPressed: () {
                  FirebaseFunction.resetPassword(
                      email:
                          FirebaseAuth.instance.currentUser!.email.toString());
                  Navigator.pop(context);
                  customSnackBar(context, "Check your E-mail and login again!");
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/login", (route) => false);
                  FirebaseFunction.logOut();
                },
                    widget: const Text(
                      "Check your Email to reset your Password.",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ));
              },
            ),
            SettingButton(
              title: "Change Email address",
              icon: Icons.email,
              onTap: () {
                customDialog(context,
                    btnTitle: "Change",
                    title: "New Email",
                    controller: emailController, onPressed: () {
                  FirebaseFunction.changeEmail(emailController.text);
                });
              },
            ),
            SettingButton(
              title: "Delete account",
              icon: Icons.delete,
              onTap: () {
                customDialog(context,
                    btnTitle: "",
                    title: "Alert",
                    widget: const Text(
                      "Hambola SAD 😔",
                      textAlign: TextAlign.center,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
