import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hambolah_chat_app/logic/auth/forget_password_cubit/forget_password_cubit.dart';
import 'package:hambolah_chat_app/logic/setting/delete_account_cubit/delete_account_cubit.dart';
import '../../logic/auth/login_cubit/login_cubit.dart';
import '../../logic/auth/register_cubit/register_cubit.dart';
import '../../logic/setting/change_name_cubit/change_name_cubit.dart';
import '../../logic/setting/upload_image_cubit/image_cubit.dart';
import '../screen/auth/forget_password.dart';
import '../screen/home/home.dart';
import '../screen/auth/login.dart';
import '../screen/auth/register.dart';
import '../screen/setting/account.dart';
import '../screen/setting/setting.dart';
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
        BlocProvider(
          create: (context) => ImageCubit(),
        ),
        BlocProvider(
          create: (context) => ChangeNameCubit(),
        ),
        BlocProvider(
          create: (context) => ForgetPasswordCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteAccountCubit(),
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
          "/setting": (context) => const SettingScreen(),
          "/account": (context) => const AccountScreen(),
        },
      ),
    );
  }
}
