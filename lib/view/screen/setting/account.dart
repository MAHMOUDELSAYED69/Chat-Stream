import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import 'package:hambolah_chat_app/firebase/functions.dart';
import 'package:hambolah_chat_app/logic/auth/forget_password_cubit/forget_password_cubit.dart';
import 'package:hambolah_chat_app/logic/setting/delete_account_cubit/delete_account_cubit.dart';
import 'package:hambolah_chat_app/view/widget/setting_button.dart';
import '../../../core/helper/snackbar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController deleteController = TextEditingController();
  resetPassword() {
    BlocProvider.of<ForgetPasswordCubit>(context).resetPassword(
        email: FirebaseAuth.instance.currentUser!.email.toString());
  }

  deleteAccount() {
    if (deleteController.text.isNotEmpty && deleteController.text.length >= 5) {
      BlocProvider.of<DeleteAccountCubit>(context)
          .deleteAccount(password: deleteController.text);
    }
  }

  changeEmail() {
    if (emailController.text.isNotEmpty) {
      FirebaseAuthService.changeEmail(emailController.text);
    }
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
            BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordSuccess) {
                  Navigator.pop(context);
                  customSnackBar(context, "Check your E-mail and login again!");
                  FirebaseAuthService.logOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/login", (route) => false);
                }
                if (state is ForgetPasswordFailure) {
                  customSnackBar(context, "There was an error!");
                }
              },
              child: SettingButton(
                title: "Change password",
                icon: Icons.lock,
                onTap: () {
                  customDialog(context,
                      btnTitle: "Send",
                      title: "Reset Password",
                      onPressed: resetPassword,
                      widget: const Text(
                        "Check your Email to reset your Password.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ));
                },
              ),
            ),
            SettingButton(
              title: "Change Email address",
              icon: Icons.email,
              onTap: () {
                customDialog(
                  context,
                  keyboardType: TextInputType.emailAddress,
                  btnTitle: "Change",
                  title: "New Email",
                  hintText: "Email",
                  controller: emailController,
                  onPressed: changeEmail,
                );
              },
            ),
            BlocListener<DeleteAccountCubit, DeleteAccountState>(
              listener: (context, state) {
                if (state is DeleteAccountSuccess) {
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                  customSnackBar(context, "User account deleted successfully!");
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/login", (route) => false);
                }
                if (state is DeleteAccountFailure) {
                  customSnackBar(context, "There was an error!");
                  log(state.message);
                }
              },
              child: SettingButton(
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
                    onPressed: deleteAccount,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
