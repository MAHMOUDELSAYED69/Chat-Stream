import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_stream/helper/constant/color.dart';
import 'package:chat_stream/helper/extentions/extentions.dart';
import 'package:chat_stream/logic/auth/forget_password_cubit/forget_password_cubit.dart';
import '../../../helper/snackbar.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/my_loading_indicator.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<ForgetPasswordCubit>().resetPassword(email: _email!);
    }
  }

  String? _email;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordLoading) {
            _isLoading = true;
          }
          if (state is ForgetPasswordSuccess) {
            _isLoading = false;
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
            customSnackBar(context, "Check your E-mail",
                color: ColorManager.purple);
          }
          if (state is ForgetPasswordFailure) {
            _isLoading = false;
            customSnackBar(
                context, "There was an Error please try agin later!");
            log(state.message);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: MediaQuery.viewInsetsOf(context).bottom,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Forgot Password",
                          style: context.textTheme.bodyLarge,
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "Please enter your email, and we will send you a confirmation link to reset your password.",
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyMedium,
                        ),
                        SizedBox(height: 15.h),
                        CustomTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (data) {
                            _email = data;
                          },
                          title: "EMAIL",
                        ),
                        SizedBox(height: 20.h),
                        ElevatedButton(
                          onPressed: _resetPassword,
                          child: _isLoading == true
                              ? const MyLoadingIndicator()
                              : const Text("Send link"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void showForgetPasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20))),
    backgroundColor: ColorManager.darkGrey,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const ForgetPassword();
    },
  );
}
