import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import 'package:hambolah_chat_app/core/helper/snackbar.dart';
import 'package:hambolah_chat_app/firebase/functions.dart';
import 'package:hambolah_chat_app/view/screen/setting/edit_profile.dart';
import '../../../logic/setting/change_name_cubit/change_name_cubit.dart';
import '../../../logic/setting/upload_image_cubit/image_cubit.dart';
import '../../widget/setting_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isImageLoading = false;
  String? imageUrl;
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
        title: const Text("Settings",
            style:
                TextStyle(fontWeight: FontWeight.w500, color: MyColors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  BlocConsumer<ImageCubit, ImageState>(
                    listener: (context, state) {
                      if (state is Imageloading) {
                        isImageLoading = true;
                      }
                      if (state is ImageSuccess) {
                        isImageLoading = false;
                        imageUrl = state.imageUrl;
                      }
                      if (state is ImageFailure) {
                        isImageLoading = false;
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
                        child: isImageLoading == true
                            ? const CircleAvatar(
                                radius: 35,
                                child: CircularProgressIndicator(),
                              )
                            : CircleAvatar(
                                radius: 35,
                                backgroundColor: MyColors.darkGrey2,
                                backgroundImage: imageUrl != null
                                    ? FileImage(File(imageUrl!))
                                    : FirebaseAuth.instance.currentUser!
                                                .photoURL !=
                                            null
                                        ? FileImage(File(FirebaseAuth
                                            .instance.currentUser!.photoURL!))
                                        : null,
                                child: imageUrl == null &&
                                        FirebaseAuth.instance.currentUser!
                                                .photoURL ==
                                            null
                                    ? Text(
                                        FirebaseAuth
                                            .instance.currentUser!.displayName
                                            .toString()
                                            .toUpperCase()[0],
                                        style: const TextStyle(
                                            color: MyColors.white,
                                            fontSize: 24),
                                      )
                                    : null, // Replace with your default avatar image
                              ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  BlocBuilder<ChangeNameCubit, ChangeNameState>(
                    builder: (context, state) {
                      return Text(
                        overflow: TextOverflow.clip,
                        FirebaseAuth.instance.currentUser!.displayName
                            .toString(),
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: MyColors.white),
                      );
                    },
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () async {
                        showEditAccountBottomSheet(context);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: MyColors.white,
                      ))
                ],
              ),
            ),
            const Divider(
                color: MyColors.white, thickness: 2, indent: 20, endIndent: 20),
            SettingButton(
                title: "Account",
                icon: Icons.key,
                onTap: () => Navigator.pushNamed(context, "/account")),
            SettingButton(
              title: "Privacy",
              icon: Icons.lock_person_outlined,
              onTap: () {},
            ),
            SettingButton(
              title: "Theme",
              icon: Icons.style_outlined,
              onTap: () {},
            ),
            SettingButton(
              title: "App language",
              icon: Icons.language,
              onTap: () {},
            ),
            SettingButton(
              title: "Help",
              icon: Icons.help_outline,
              onTap: () {},
            ),
            SettingButton(
              title: "Invite a friend",
              icon: Icons.people_alt_sharp,
              onTap: () {},
            ),
            SettingButton(
              title: "Log Out",
              icon: Icons.logout,
              onTap: () {
                FirebaseAuthService.logOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (route) => false);
              },
            ),
            const Spacer(flex: 2),
            const Text("from", style: TextStyle(color: MyColors.lightGrey)),
            const Text(
              "Hambola",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: MyColors.white),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
