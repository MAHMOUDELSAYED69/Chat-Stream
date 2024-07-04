import 'package:chat_stream/helper/extentions/extentions.dart';
import 'package:flutter/material.dart';

import '../../helper/constant/colors.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "By registering, you agree to Chat Stream's ",
          style: context.textTheme.bodySmall,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {},
                child: Text(
                  "Terms of Service",
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: ColorManager.lightBlue),
                )),
            Text(
              " and ",
              style: context.textTheme.bodySmall,
            ),
            InkWell(
                onTap: () {},
                child: Text(
                  "Privacy Policy",
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: ColorManager.lightBlue),
                )),
            Text(
              ".",
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
