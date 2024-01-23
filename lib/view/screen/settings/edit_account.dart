import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import 'package:hambolah_chat_app/core/helper/responsive.dart';
import 'package:hambolah_chat_app/firebase/functions.dart';
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
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
                  const CircleAvatar(
                    radius: 70,
                  ),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (data) {
                      userName = data;
                    },
                    title: "Change Name",
                    titleTextStyle: const TextStyle(
                        color: MyColors.lightGrey,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
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
                              FirebaseAuthService.updateUserProfile(
                                  name: userName);
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
