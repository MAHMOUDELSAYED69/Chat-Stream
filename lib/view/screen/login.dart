import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import 'package:hambolah_chat_app/core/helper/responsive.dart';
import 'package:hambolah_chat_app/core/helper/snackbar.dart';
import 'package:hambolah_chat_app/logic/auth/google_cubit/google_sign_in_cubit.dart';
import 'package:hambolah_chat_app/logic/auth/login_cubit/login_cubit.dart';
import 'package:hambolah_chat_app/view/screen/forget_password.dart';
import 'package:hambolah_chat_app/view/widget/custom_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widget/custom_text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isLoading = false;
  login() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      BlocProvider.of<LoginCubit>(context)
          .userLogin(email: email!, password: password!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        }
        if (state is LoginSuccess) {
          isLoading = false;
          FocusScope.of(context).unfocus();
          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        }
        if (state is LoginFailure) {
          isLoading = false;
          scaffoldSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: MyColors.darkGrey,
            body: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.04861 * ScreenSize.width), //20
                alignment: Alignment.center,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.chat,
                          size: 90,
                          color: MyColors.white,
                        ),
                        SizedBox(height: 0.0461133 * ScreenSize.height), //40
                        const Text("Welcome back!",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: MyColors.white)),
                        SizedBox(height: 0.0115283 * ScreenSize.height), //10
                        const Text("We're so excited to see you again!",
                            style: TextStyle(
                                fontSize: 18, color: MyColors.lightGrey)),
                        CustomTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (data) {
                            email = data;
                          },
                          title: "EMAIL",
                        ),
                        SizedBox(height: 0.01729249 * ScreenSize.height), //15
                        CustomTextFormField(
                          isVisible: true,
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (data) {
                            password = data;
                          },
                          title: "PASSWORD",
                        ),
                        SizedBox(height: 0.005764 * ScreenSize.height), //5
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            splashColor: MyColors.darkGrey,
                            onTap: () => showForgetPasswordBottomSheet(context),
                            child: const Text(
                              "Forget your password?",
                              style: TextStyle(
                                  fontSize: 18, color: MyColors.lightBlue),
                            ),
                          ),
                        ),
                        SizedBox(height: 0.0345849 * ScreenSize.height), //30
                        CustomButton(
                          onPressed: login,
                          color: MyColors.purple,
                          title: "Log In",
                        ),
                        SizedBox(height: 0.0345849 * ScreenSize.height), //30
                        Row(
                          children: [
                            const Text(
                              "Need an account? ",
                              style: TextStyle(
                                  fontSize: 16, color: MyColors.lightGrey),
                            ),
                            InkWell(
                              splashColor: MyColors.darkGrey,
                              onTap: () {
                                Navigator.pushNamed(context, "/register");
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 18, color: MyColors.lightBlue),
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
