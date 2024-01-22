import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import 'package:hambolah_chat_app/firebase/functions.dart';
import '../../widget/setting_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: MyColors.darkGrey2,
                    child: Text(
                      "M",
                      style: TextStyle(color: MyColors.white, fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "mahmoud elsayed",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: MyColors.white),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_drop_down_circle_outlined,
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
                FirebaseFunction.logOut();
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
