import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import 'package:hambolah_chat_app/view/widget/custom_button.dart';

import '../widget/custom_text_field.dart';
import '../widget/terms_and_privacy.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? displayName;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.darkGrey,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  const SizedBox(height: 40),
                  const Text("Create an account",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: MyColors.white)),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    title: "EMAIL",
                    onSaved: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    title: "DISPLAY NAME",
                    onSaved: (data) {
                      displayName = data;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    title: "PASSWORD",
                    onSaved: (data) {
                      password = data;
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        formKey.currentState!.save();
                        log(email!);
                        log(displayName!);
                        log(password!);
                      }
                    },
                    color: MyColors.purple,
                    title: "Register",
                  ),
                  const SizedBox(height: 30),
                  PrivacyAndTerms(onPrivacyPress: () {}, onTermsPress: () {}),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      InkWell(
                        splashColor: MyColors.darkGrey,
                        onTap: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: const Text(
                          "Already have an account?",
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
    );
  }
}
