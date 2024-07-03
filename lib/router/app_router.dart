import 'package:flutter/material.dart';

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
        return _materialPageRoute(const LoginScreen());
      case RouteManager.register:
        return _materialPageRoute(const RegisterScreen());
      case RouteManager.home:
        return _materialPageRoute(const HomeScreen());
      case RouteManager.chat:
        return _materialPageRoute(const ChatScreen());
      case RouteManager.settings:
        return _materialPageRoute(const SettingScreen());
      case RouteManager.account:
        return _materialPageRoute(const AccountScreen());

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
