import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_stream/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helper/constant/color.dart';
import '../../helper/responsive.dart';
import '../../logic/setting/change_name_cubit/change_name_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.emailVerified) {
      context.read<ChangeNameCubit>().getUserName();
    }
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      final routeName = FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified
          ? RouteManager.home
          :  RouteManager.login;
      Navigator.pushReplacementNamed(context, routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 6),
            _buildAnimatedText(),
            const Spacer(flex: 5),
            _buildSubtitle(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedText() {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          'Chat Stream',
          textStyle: const TextStyle(
            color: ColorManager.purple,
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      isRepeatingAnimation: false,
      pause: const Duration(milliseconds: 1000),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      "start chatting with your friends",
      style: TextStyle(
        fontSize: 16,
        color: ColorManager.purple,
      ),
    );
  }
}
