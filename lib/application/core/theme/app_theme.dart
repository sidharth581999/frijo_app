
import 'package:flutter/material.dart';
import 'package:frijo/application/core/theme/colors.dart';
import 'package:frijo/application/core/utils/enums.dart';

class AppTheme {
  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorResources.blackBG, // light background
    // primarySwatch: ColorResources.blackBG,
    appBarTheme:  AppBarTheme(
      backgroundColor: ColorResources.blackBG,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorResources.blackBG, // dark background
    // primarySwatch: Colors.blue,
    // appBarTheme: const AppBarTheme(
    //   backgroundColor: Colors.black,
    //   foregroundColor: Colors.white,
    //   elevation: 0,
    // ),
  );

  static ThemeData getTheme(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.dark:
        return _darkTheme;
      case AppThemeMode.light:
        return _lightTheme;
    }
  }
}
