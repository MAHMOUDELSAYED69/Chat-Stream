import 'dart:developer';

import 'package:flutter/material.dart';
import '../../core/helper/responsive.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    animation = Tween<double>(begin: .2, end: 1).animate(animationController!)
      ..addListener(() {
        setState(() {});
      });
    animationController?.repeat(reverse: true);
    getToNewScreen();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset("assets/image/splash_bg.png",
              width: double.infinity, fit: BoxFit.fill),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text("Welcome to",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      )),
                  AnimatedBuilder(
                      animation: animation!,
                      builder: (context, _) => Opacity(
                          opacity: animation?.value,
                          child: Image.asset(
                            "assets/image/hambola.png",
                            width: 160,
                            height: 110,
                          ))),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text("start chatting with your friends",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                  ),
                  const Spacer(),
                  const Text("V 0.0.01",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void getToNewScreen() {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        log("height: ${ScreenSize.height}");
        log("width: ${ScreenSize.width}");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LogInScreen()));
      },
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}
