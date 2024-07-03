import 'package:flutter/material.dart';

import '../../helper/constant/color.dart';

class MyLoadingIndicator extends StatelessWidget {
  const MyLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: ColorManager.white,
      strokeCap: StrokeCap.round,
      strokeWidth: 3,
    );
  }
}
