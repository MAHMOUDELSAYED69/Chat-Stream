import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_stream/helper/constant/color.dart';
import 'package:chat_stream/helper/extentions/extentions.dart';
import 'package:chat_stream/helper/snackbar.dart';
import 'package:chat_stream/firebase/functions.dart';
import 'package:chat_stream/logic/auth/login_cubit/login_cubit.dart';
import 'package:chat_stream/router/app_router.dart';
import 'package:chat_stream/view/screen/auth/forget_password.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../widget/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> _formKey;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  String? _email;
  String? _password;
  bool _isLoading = false;
  _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context
          .read<LoginCubit>()
          .userLogin(email: _email!, password: _password!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          _isLoading = true;
        }
        if (state is LoginSuccess) {
          _isLoading = false;
          FocusScope.of(context).unfocus();
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (route) => false);
          } else {
            customSnackBar(context, "Please verify your Email");
            FirebaseService.emailVerify();
          }
        }
        if (state is LoginFailure) {
          _isLoading = false;
          customSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Scaffold(
            body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.bubble_chart,
                          size: 120,
                          color: ColorManager.purple,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Welcome back!",
                          style: context.textTheme.bodyLarge,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "We're so excited to see you again!",
                          style: context.textTheme.bodyMedium,
                        ),
                        SizedBox(height: 40.h),
                        CustomTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (data) {
                            _email = data;
                          },
                          title: "EMAIL",
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          isVisible: true,
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (data) {
                            _password = data;
                          },
                          title: "PASSWORD",
                        ),
                        SizedBox(height: 5.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            splashColor: ColorManager.darkGrey,
                            onTap: () => showForgetPasswordBottomSheet(context),
                            child: Text(
                              "Forget your password?",
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: ColorManager.lightBlue),
                            ),
                          ),
                        ),
                        SizedBox(height: 60.h),
                        ElevatedButton(
                          onPressed: _login,
                          child: const Text("Log In"),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Text(
                              "Need an account? ",
                              style: context.textTheme.bodyMedium,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, RouteManager.register),
                              child: Text(
                                "Register",
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(color: ColorManager.lightBlue),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
