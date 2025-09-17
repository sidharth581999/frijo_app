import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarStyler extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final List<Color>? gradient;

  const StatusBarStyler({
    super.key,
    required this.child,
    required this.backgroundColor,
    this.gradient
  });

  @override
  Widget build(BuildContext context) {
    final Brightness bgBrightness =
    ThemeData.estimateBrightnessForColor(backgroundColor);

    final Brightness iconBrightness =
    bgBrightness == Brightness.dark ? Brightness.light : Brightness.dark;

    final Brightness iosBrightness =
    bgBrightness == Brightness.dark ? Brightness.dark : Brightness.light;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      statusBarIconBrightness: iconBrightness, // Android
      statusBarBrightness: iosBrightness,      // iOS
    ));

    return child;
  }
}
