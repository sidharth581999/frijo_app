

import 'package:flutter/material.dart';
import 'package:frijo/application/core/utils/logger.dart';
import 'package:frijo/presentation/screens/home/home.dart';
import 'package:frijo/presentation/screens/login/login_screen.dart';
import 'package:frijo/presentation/screens/splash/splash_screen.dart';
import 'package:page_transition/page_transition.dart';


class AppRoute {
  // Define all route names here
  static const String splash = '/splash';
  // static const String settings = '/settings';
  static const String login = '/login';
  static const String home = '/home';
  // static const String register = '/register';
  // static const String pdfScreen = '/pdfScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Logger.logWarning(
      'Route Name: ${settings.name},  Arguments: ${settings.arguments}, ArgumentType: ${settings.arguments.runtimeType}',
    );

    // final arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case splash:
        return _pushRoute(settings, const SplashScreen());

      case login:
        return _pushRoute(settings, LoginScreen());

      case home:
        return _pushRoute(settings, HomeScreen());

      // case register:
      //   return _pushRoute(settings, RegisterScreen());

      // case pdfScreen:
      //   return _pushRoute(settings, PdfScreen());

      default:
        return _pushRoute(
          settings,
          const Scaffold(
            body: Center(
              child: Text('404 - Page not found'),
            ),
          ),
        );
    }
  }

  static Route<dynamic> _pushRoute(RouteSettings settings, Widget screen) {
    return PageTransition(
      settings: settings,
      child: screen,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 400),
      type: PageTransitionType.rightToLeft,
    );
  }
}
