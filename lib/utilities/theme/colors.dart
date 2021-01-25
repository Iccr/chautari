import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChautariColors extends GetxController {
  ThemeMode _mode;
  static Color primary = Colors.teal;
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color green = Colors.green;
  static Color red = Colors.red;
  static MaterialColor grey = Colors.grey;

  static Color tabBarActiveBackgroundColor = Colors.grey[800];

  // black and white => lightmode black, dark mode white

  static Color blackAndWhitecolor() {
    var mode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return mode == ThemeMode.dark ? black : white;
  }

// black and primary => lightmode black, dark mode theme.primaryColor

  static Color blackAndPrimarycolor() {
    var mode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return mode == ThemeMode.dark ? black : primary;
  }

  static Color primaryColor() {
    return primary;
  }

// primary and white => lightmode primary, dark mode white
  static Color primaryAndWhitecolor() {
    var mode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return mode == ThemeMode.dark ? white : primary;
  }
}
