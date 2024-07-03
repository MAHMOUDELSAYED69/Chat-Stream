import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_stream/helper/constant/color.dart';
import 'package:chat_stream/helper/extentions/extentions.dart';
import 'package:chat_stream/helper/snackbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../logic/auth/register_cubit/register_cubit.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/terms_and_privacy.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _txtController;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _txtController = TextEditingController();
    super.initState();
  }

  String? _email;
  String? _displayName;
  String? _password;
  bool _isLoading = false;

  _register() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      context.read<RegisterCubit>().userRegister(
          email: _email!, password: _password!, userName: _displayName!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          _isLoading = true;
        }
        if (state is RegisterSuccess) {
          FocusScope.of(context).unfocus();
          _isLoading = false;
          customSnackBar(context, "verify your Email and log in");
          Navigator.pop(context);
        }
        if (state is RegisterFailure) {
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
                        SizedBox(height: 30.h),
                        const Icon(
                          Icons.bubble_chart,
                          size: 120,
                          color: ColorManager.purple,
                        ),
                        SizedBox(height: 10.h),
                        Text("Create an account",
                            style: context.textTheme.bodyLarge),
                        SizedBox(height: 20.h),
                        CustomTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          title: "EMAIL",
                          onSaved: (data) {
                            _email = data;
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          keyboardType: TextInputType.name,
                          title: "DISPLAY NAME",
                          onSaved: (data) {
                            _displayName = data;
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          controller: _txtController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          title: "PASSWORD",
                          onSaved: (data) {
                            _password = data;
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          title: "CONFIRM PASSWORD",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please fill out the field!";
                            }
                            if (value != _txtController.text) {
                              return "Wrong password";
                            }
                            return null;
                          },
                          onSaved: (data) {
                            _password = data;
                          },
                        ),
                        SizedBox(height: 40.h),
                        ElevatedButton(
                          onPressed: _register,
                          child: const Text("Register"),
                        ),
                        SizedBox(height: 20.h),
                        const PrivacyAndTerms(),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                "Already have an account?",
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(color: ColorManager.lightBlue),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 25.h),
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
