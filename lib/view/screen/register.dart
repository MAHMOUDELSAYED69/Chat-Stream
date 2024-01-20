import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import 'package:hambolah_chat_app/core/helper/snackbar.dart';
import 'package:hambolah_chat_app/logic/auth/register_cubit.dart';
import 'package:hambolah_chat_app/view/widget/custom_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../core/helper/responsive.dart';
import '../widget/custom_text_field.dart';
import '../widget/terms_and_privacy.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtController = TextEditingController();
  String? email;
  String? displayName;
  String? password;
  bool isLoading = false;
  register() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      BlocProvider.of<RegisterCubit>(context)
          .userRegister(email: email!, password: password!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        }
        if (state is RegisterSuccess) {
          FocusScope.of(context).unfocus();
          isLoading = false;
          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        }
        if (state is RegisterFailure) {
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
                        SizedBox(height: 0.0345849 * ScreenSize.height), //30
                        const Icon(
                          Icons.chat,
                          size: 90,
                          color: MyColors.white,
                        ),
                        SizedBox(height: 0.0461133 * ScreenSize.height), //40
                        const Text("Create an account",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: MyColors.white)),
                        SizedBox(height: 0.0115283 * ScreenSize.height), //10
                        CustomTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          title: "EMAIL",
                          onSaved: (data) {
                            email = data;
                          },
                        ),
                        SizedBox(height: 0.01729249 * ScreenSize.height), //15
                        CustomTextFormField(
                          keyboardType: TextInputType.name,
                          title: "DISPLAY NAME",
                          onSaved: (data) {
                            displayName = data;
                          },
                        ),
                        SizedBox(height: 0.01729249 * ScreenSize.height), //15
                        CustomTextFormField(
                          controller: txtController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          title: "PASSWORD",
                          onSaved: (data) {
                            password = data;
                          },
                        ),
                        SizedBox(height: 0.01729249 * ScreenSize.height), //15
                        CustomTextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          title: "CONFIRM PASSWORD",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please fill out the field!";
                            }
                            if (value != txtController.text) {
                              return "Wrong password";
                            }
                            return null;
                          },
                          onSaved: (data) {
                            password = data;
                          },
                        ),
                        SizedBox(height: 0.0461133 * ScreenSize.height), //40
                        CustomButton(
                          onPressed: register,
                          color: MyColors.purple,
                          title: "Register",
                        ),
                        SizedBox(height: 0.0345849 * ScreenSize.height), //30
                        PrivacyAndTerms(
                            onPrivacyPress: () {}, onTermsPress: () {}),
                        SizedBox(height: 0.0345849 * ScreenSize.height), //30
                        Row(
                          children: [
                            InkWell(
                              splashColor: MyColors.darkGrey,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Already have an account?",
                                style: TextStyle(
                                    fontSize: 18, color: MyColors.lightBlue),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 0.0345849 * ScreenSize.height), //30
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
