import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_stream/logic/chat/chat_card_cubit/chat_card_cubit.dart';
import 'package:chat_stream/logic/chat/chat_message_cubit/chat_message_cubit.dart';
import 'package:chat_stream/theme/app_theme.dart';
import 'logic/auth/forget_password_cubit/forget_password_cubit.dart';
import 'logic/auth/login_cubit/login_cubit.dart';
import 'logic/auth/register_cubit/register_cubit.dart';
import 'logic/setting/change_name_cubit/change_name_cubit.dart';
import 'logic/setting/delete_account_cubit/delete_account_cubit.dart';
import 'logic/setting/log_out_cubit/log_out_cubit.dart';
import 'view/screen/auth/forget_password.dart';
import 'view/screen/home/chat.dart';
import 'view/screen/home/home.dart';
import 'view/screen/auth/login.dart';
import 'view/screen/auth/register.dart';
import 'view/screen/setting/account.dart';
import 'view/screen/setting/setting.dart';
import 'view/screen/splash.dart';

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
          create: (context) => ChangeNameCubit(),
        ),
        BlocProvider(
          create: (context) => ForgetPasswordCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteAccountCubit(),
        ),
        BlocProvider(
          create: (context) => LogOutCubit(),
        ),
        BlocProvider(
          create: (context) => ChatMessageCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCardCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => MaterialApp(
          builder: (context, widget) {
            final mediaQueryData = MediaQuery.of(context);
            final scaledMediaQueryData = mediaQueryData.copyWith(
              textScaler: TextScaler.noScaling,
            );
            return MediaQuery(
              data: scaledMediaQueryData,
              child: widget!,
            );
          },
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {
            "/": (context) => const SplashScreen(),
            "/login": (context) => const LoginScreen(),
            "/register": (context) => const RegisterScreen(),
            "/home": (context) => const HomeScreen(),
            "/forget": (context) => const ForgetPassword(),
            "/settings": (context) => const SettingScreen(),
            "/account": (context) => const AccountScreen(),
            "/chat": (context) => const ChatScreen(),
          },
        ),
      ),
    );
  }
}
