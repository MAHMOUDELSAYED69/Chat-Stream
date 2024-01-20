import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({
    super.key,
    this.onTermsPress,
    this.onPrivacyPress,
  });
  final void Function()? onTermsPress;
  final void Function()? onPrivacyPress;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const Text(
          "By registering, you agree to Hambola's",
          style: TextStyle(
            color: MyColors.lightGrey,
          ),
        ),
        InkWell(
            onTap: onTermsPress,
            child: const Text(
              "Terms of Service",
              style: TextStyle(
                color: MyColors.lightBlue,
              ),
            )),
        const Text(
          " and ",
          style: TextStyle(
            color: MyColors.lightGrey,
          ),
        ),
        InkWell(
            onTap: onPrivacyPress,
            child: const Text(
              "Privacy Policy",
              style: TextStyle(
                color: MyColors.lightBlue,
              ),
            )),
        const Text(
          ".",
          style: TextStyle(
            color: MyColors.lightGrey,
          ),
        ),
      ],
    );
  }
}

