import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/view/screen/forget_password.dart';
import 'package:hambolah_chat_app/view/screen/home.dart';
import 'package:hambolah_chat_app/view/screen/login.dart';
import 'package:hambolah_chat_app/view/screen/register.dart';
import '../screen/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/login": (context) => const LogInScreen(),
        "/register": (context) => const RegisterScreen(),
        "/home": (context) => const HomeScreen(),
        "/forget": (context) => const ForgetPassword(),
      },
    );
  }
}
