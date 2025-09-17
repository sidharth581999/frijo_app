import 'package:flutter/material.dart';

class DeviceSize {
  static late bool isTablet;
  static late double scaleFactor;

  static void init(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    isTablet = shortestSide >= 600;
    scaleFactor = isTablet ? 1.5 : 1.0; // adjust scale for tablets
  }

  static double scale(double size) => size * scaleFactor;
}
