// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStyles {
  static Color bgBlack = Colors.black87;
  static Color bgGray = Color(0xFF87898E);
  static Color bgGray4 = Colors.grey.shade400;
  static Color bgBlue = Color(0xFF5079FA);
  static Color bgPrimary = Color.fromARGB(255, 7, 8, 97);
  static Color bgPrimaryLight = Color.fromARGB(255, 7, 8, 97).withOpacity(0.08);
  static Color bgPrimaryBackground = Color(0xFFE1E6FF);
  static Color bgWhite = Color(0xFFFFFFFF);
  static Color bgBrightRed = Color(0xFFFF0000);
  static Color bgPurpleDark = Color(0xFF140152);
}

class AppLayout {
  static getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static getScreenHeight() {
    return Get.height;
  }

  static getScreenWidth() {
    return Get.width;
  }

  static getHeight(double pixels) {
    double x = getScreenHeight() / pixels;

    return getScreenHeight() / x;
  }

  static getWidth(double pixels) {
    double x = getScreenWidth() / pixels;

    return getScreenWidth() / x;
  }
}

extension PercentSized on double {
  double get hp => (Get.height * (this / 100));
  double get wp => (Get.width * (this / 100));
}

extension ResponsiveText on double {
  double get sp => Get.width / 100 * (this / 3);
}

double constructFontSize(BuildContext context, double baseFontSize) {
  final screenWidth = MediaQuery.of(context).size.width;
  double scaleFactor;

  if (screenWidth < 400) {
    scaleFactor = 0.002;
  } else if (screenWidth >= 400 && screenWidth < 600) {
    scaleFactor = 0.003;
  } else {
    scaleFactor = 0.004;
  }

  // Calculate the scaled font size
  final scaledFontSize = screenWidth * scaleFactor + baseFontSize;

  return scaledFontSize;
}
