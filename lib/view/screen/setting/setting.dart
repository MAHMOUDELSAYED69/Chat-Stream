import 'package:chat_stream/helper/extentions/extentions.dart';
import 'package:chat_stream/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_stream/helper/constant/color.dart';
import 'package:chat_stream/helper/snackbar.dart';
import 'package:chat_stream/view/screen/setting/edit_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../logic/setting/change_name_cubit/change_name_cubit.dart';
import '../../../logic/setting/log_out_cubit/log_out_cubit.dart';
import '../../widget/setting_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  _logout() {
    context.read<LogOutCubit>().logOut();
  }

  bool isLogOutLoading = false;
  @override
  Widget build(BuildContext context) {
    const kDivider = Divider(
      color: ColorManager.lightGrey,
      thickness: 2,
      endIndent: 16,
      indent: 16,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<ChangeNameCubit, ChangeNameState>(
                    builder: (context, state) {
                      return Text(
                        context.read<ChangeNameCubit>().userName ?? "",
                        overflow: TextOverflow.clip,
                        style:
                            context.textTheme.bodyLarge?.copyWith(fontSize: 22),
                      );
                    },
                  ),
                  IconButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(ColorManager.darkGrey2)),
                    onPressed: () => showEditAccountBottomSheet(context),
                    icon: const Icon(
                      Icons.mode_edit_outline_outlined,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
            ),
            kDivider,
            SettingButton(
                title: "Account",
                foColor: ColorManager.white,
                icon: Icons.key,
                onTap: () =>
                    Navigator.pushNamed(context, RouteManager.account)),
            const SettingButton(
              title: "Privacy",
              icon: Icons.lock_person_outlined,
            ),
            const SettingButton(
              title: "Theme",
              icon: Icons.style_outlined,
            ),
            const SettingButton(
              title: "App language",
              icon: Icons.language,
            ),
            const SettingButton(
              title: "Help",
              icon: Icons.help_outline,
            ),
            const SettingButton(
              title: "Invite a friend",
              icon: Icons.people_alt_sharp,
            ),
            BlocListener<LogOutCubit, LogOutState>(
              listener: (context, state) {
                if (state == LogOutState.success) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/login", (route) => false);
                  customSnackBar(context, "Logout Successfully!");
                }
                if (state == LogOutState.failure) {
                  customSnackBar(context, "There was an error");
                }
              },
              child: SettingButton(
                foColor: ColorManager.red,
                title: "Log Out",
                icon: Icons.logout,
                onTap: _logout,
              ),
            ),
            kDivider,
            SizedBox(height: 50.h),
            Text("from", style: context.textTheme.bodyMedium),
            Text(
              "Chat Stream",
              style: context.textTheme.bodyLarge?.copyWith(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
