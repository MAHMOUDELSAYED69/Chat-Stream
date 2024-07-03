import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_stream/firebase/functions.dart';
import 'package:chat_stream/logic/auth/forget_password_cubit/forget_password_cubit.dart';
import 'package:chat_stream/logic/setting/delete_account_cubit/delete_account_cubit.dart';
import 'package:chat_stream/view/widget/setting_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helper/snackbar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    _emailController = TextEditingController();
    _deleteController = TextEditingController();
    super.initState();
  }

  late TextEditingController _emailController;
  late TextEditingController _deleteController;
  _resetPassword() {
    BlocProvider.of<ForgetPasswordCubit>(context).resetPassword(
        email: FirebaseAuth.instance.currentUser!.email.toString());
  }

  _deleteAccount() {
    if (_deleteController.text.isNotEmpty &&
        _deleteController.text.length >= 5) {
      BlocProvider.of<DeleteAccountCubit>(context)
          .deleteAccount(password: _deleteController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state is ForgetPasswordSuccess) {
                Navigator.pop(context);
                customSnackBar(context, "Check your E-mail and login again!");
                FirebaseService.logOut();
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
                    onPressed: _resetPassword,
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
            onTap: () {},
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
                  controller: _deleteController,
                  isobscure: true,
                  onPressed: _deleteAccount,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
