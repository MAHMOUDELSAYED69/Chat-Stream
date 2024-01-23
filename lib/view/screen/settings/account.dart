import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import 'package:hambolah_chat_app/firebase/functions.dart';
import 'package:hambolah_chat_app/view/widget/setting_button.dart';

import '../../../core/cache/cache_functions.dart';
import '../../../core/helper/snackbar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController deleteController = TextEditingController();
  Future<void> delete() async {
    await FirebaseAuthService.deleteUser(
        email: FirebaseAuth.instance.currentUser!.email.toString(),
        password: deleteController.text);
  }

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
                  FirebaseAuthService.resetPassword(
                      email:
                          FirebaseAuth.instance.currentUser!.email.toString());
                  Navigator.pop(context);
                  customSnackBar(context, "Check your E-mail and login again!");
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/login", (route) => false);
                  FirebaseAuthService.logOut();
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
                    keyboardType: TextInputType.emailAddress,
                    btnTitle: "Change",
                    title: "New Email",
                    hintText: "Email",
                    controller: emailController, onPressed: () {
                  if (emailController.text.isNotEmpty) {
                    FirebaseAuthService.changeEmail(emailController.text);
                  }
                });
              },
            ),
            SettingButton(
              title: "Delete account",
              icon: Icons.delete,
              onTap: () {
                customDialog(
                  context,
                  keyboardType: TextInputType.visiblePassword,
                  btnTitle: "DELETE",
                  title: "Warrning",
                  controller: deleteController,
                  isobscure: true,
                  onPressed: () async {
                    try {
                      if (deleteController.text.isNotEmpty &&
                          deleteController.text.length >= 6) {
                        await delete();
                        deleteController.clear();
                        if (FirebaseAuth.instance.currentUser == null) {
                          CacheData.clearData(clearData: true);
                          // ignore: use_build_context_synchronously
                          customSnackBar(
                              context, "User account deleted successfully.");
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/login", (route) => false);
                        }
                      }
                    } on Exception catch (err) {
                      log(err.toString());
                      // ignore: use_build_context_synchronously
                      customSnackBar(context,
                          "there was an error please try again later!");
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
