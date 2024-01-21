import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/auth/google_cubit/google_sign_in_cubit.dart';
import '../../logic/auth/login_cubit/login_cubit.dart';
import '../../logic/auth/register_cubit/register_cubit.dart';
import '../screen/forget_password.dart';
import '../screen/home.dart';
import '../screen/login.dart';
import '../screen/register.dart';
import '../screen/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const SplashScreen(),
          "/login": (context) => const LogInScreen(),
          "/register": (context) => const RegisterScreen(),
          "/home": (context) => const HomeScreen(),
          "/forget": (context) => const ForgetPassword(),
        },
      ),
    );
  }
}
