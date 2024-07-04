import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_stream/helper/extentions/extentions.dart';
import 'package:chat_stream/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../helper/constant/colors.dart';
import '../../helper/constant/images.dart';

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
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      final routeName = FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified
          ? RouteManager.home
          : RouteManager.login;
      Navigator.pushReplacementNamed(context, routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 6),
            Image.asset(
              ImageManager.splash,
              color: ColorManager.purple,
              width: context.width / 2,
              height: context.width / 2,
            ),
            _buildAnimatedText(),
            const Spacer(flex: 4),
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
          '   Chat Stream',
          textStyle: context.textTheme.bodyLarge
              ?.copyWith(fontSize: 32, color: ColorManager.purple),
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
    return Text(
      "start chatting with your friends",
      style: context.textTheme.bodyMedium?.copyWith(color: ColorManager.purple),
    );
  }
}
