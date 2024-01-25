import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import 'package:hambolah_chat_app/core/helper/responsive.dart';
import 'package:hambolah_chat_app/firebase/functions.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../core/helper/snackbar.dart';
import '../../../logic/change_name_cubit/change_name_cubit.dart';
import '../../../logic/image/image_cubit.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? userName;
  String? imageUrl;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 19),
              width: 145,
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(74),
                  color: MyColors.lightGrey),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.viewInsetsOf(context).bottom,
                    top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocConsumer<ImageCubit, ImageState>(
                      listener: (context, state) {
                        if (state is Imageloading) {
                          isLoading = true;
                        }
                        if (state is ImageSuccess) {
                          isLoading = false;
                          FirebaseAuthService.updateUserImage(
                              urlImage: state.imageUrl);
                          imageUrl = state.imageUrl;
                        }
                        if (state is ImageFailure) {
                          isLoading = false;
                          customSnackBar(context,
                              "There was an error please try again later!");
                          log(state.message);
                        }
                      },
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            BlocProvider.of<ImageCubit>(context)
                                .pickImageFromGallery();
                          },
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: MyColors.darkGrey2,
                            backgroundImage: imageUrl != null
                                ? FileImage(File(imageUrl!))
                                : FirebaseAuth.instance.currentUser!.photoURL !=
                                        null
                                    ? FileImage(File(FirebaseAuth
                                        .instance.currentUser!.photoURL!))
                                    : null,
                            child: imageUrl == null &&
                                    FirebaseAuth
                                            .instance.currentUser!.photoURL ==
                                        null
                                ? Text(
                                    FirebaseAuth
                                        .instance.currentUser!.displayName
                                        .toString()
                                        .toUpperCase()[0],
                                    style: const TextStyle(
                                        color: MyColors.white, fontSize: 24),
                                  )
                                : null, // Replace with your default avatar image
                          ),
                        );
                      },
                    ),
                    BlocConsumer<ChangeNameCubit, ChangeNameState>(
                      listener: (context, state) {
                        if (state is ChangeNameLoading) {
                          isLoading = true;
                        }
                        if (state is ChangeNameSuccess) {
                          isLoading = false;
                        }
                        if (state is ChangeNameFailure) {
                          isLoading = false;
                          customSnackBar(context,
                              "There was an error please try again later!");
                          log(state.message);
                        }
                      },
                      builder: (context, state) {
                        return CustomTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (data) {
                            userName = data;
                          },
                          title: "Change Name",
                          titleTextStyle: const TextStyle(
                              color: MyColors.lightGrey,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        );
                      },
                    ),
                    SizedBox(height: 0.0288208 * ScreenSize.height),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            color: MyColors.red,
                            title: "Cancle",
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: CustomButton(
                            title: "Save",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                BlocProvider.of<ChangeNameCubit>(context)
                                    .changeDisplayName(name: userName!);
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showEditAccountBottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), topLeft: Radius.circular(35))),
    backgroundColor: MyColors.darkGrey,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const EditAccount();
    },
  );
}
