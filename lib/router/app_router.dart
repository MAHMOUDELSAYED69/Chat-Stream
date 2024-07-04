import 'package:chat_stream/logic/auth/forget_password_cubit/forget_password_cubit.dart';
import 'package:chat_stream/logic/auth/login_cubit/login_cubit.dart';
import 'package:chat_stream/logic/auth/register_cubit/register_cubit.dart';
import 'package:chat_stream/logic/chat/chat_card_cubit/chat_card_cubit.dart';
import 'package:chat_stream/logic/chat/chat_message_cubit/chat_message_cubit.dart';
import 'package:chat_stream/logic/setting/change_name_cubit/change_name_cubit.dart';
import 'package:chat_stream/logic/setting/delete_account_cubit/delete_account_cubit.dart';
import 'package:chat_stream/logic/setting/log_out_cubit/log_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view/screen/auth/login.dart';
import '../view/screen/auth/register.dart';
import '../view/screen/home/chat.dart';
import '../view/screen/home/home.dart';
import '../view/screen/setting/account.dart';
import '../view/screen/setting/setting.dart';
import '../view/screen/splash.dart';

abstract class AppRouter {
  const AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.initialRoute:
        return _materialPageRoute(const SplashScreen());
      case RouteManager.login:
        return _materialPageRoute(BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginScreen(),
        ));
      case RouteManager.register:
        return _materialPageRoute(BlocProvider(
          create: (context) => RegisterCubit(),
          child: const RegisterScreen(),
        ));
      case RouteManager.home:
        return _materialPageRoute(MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => ChatCardCubit()..buildChatCard(),
          ),
          BlocProvider(
            create: (context) => ChatMessageCubit(),
          ),
        ], child: const HomeScreen()));
      case RouteManager.chat:
        List<String> chatsList = settings.arguments as List<String>;
        return _materialPageRoute(BlocProvider(
          create: (context) => ChatMessageCubit(),
          child: ChatScreen(parameter: chatsList),
        ));
      case RouteManager.settings:
        return _materialPageRoute(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ChangeNameCubit()..getUserName(),
            ),
            BlocProvider(
              create: (context) => LogOutCubit(),
            )
          ],
          child: const SettingScreen(),
        ));
      case RouteManager.account:
        return _materialPageRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ForgetPasswordCubit(),
              ),
              BlocProvider(
                create: (context) => DeleteAccountCubit(),
              )
            ],
            child: const AccountScreen(),
          ),
        );

      default:
        return null;
    }
  }

  static _materialPageRoute(Widget screen) {
    return MaterialPageRoute(builder: (context) => screen);
  }
}

abstract class RouteManager {
  const RouteManager._();
  static const String initialRoute = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String account = '/account';
  static const String chat = '/chat';
}
