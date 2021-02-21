import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChautariColors extends GetxController {
  static Color primary = Colors.teal;
  static Color white = Colors.white;
  static Color black = Colors.black87;
  static Color green = Colors.green;
  static Color red = Colors.red;
  static Color yellow = Colors.yellow;
  static Color purple = Colors.purple;
  static Color indigo = Colors.indigo;
  static Color brown = Colors.brown;
  static Color blueGrey = Colors.blueGrey;
  static Color teal = Colors.teal;
  static Color cyan = Colors.cyan;

  static MaterialColor grey = Colors.grey;

  static Color tabBarActiveBackgroundColor = Colors.grey[800];

  // black and white => dark black, light mode white

  static Color blackAndWhitecolor() {
    var mode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return mode == ThemeMode.dark ? black : white;
  }

  static Color blackWithOpacityAndWhitecolor() {
    var mode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return mode == ThemeMode.dark ? black.withOpacity(0.7) : white;
  }

  // black and white => dark mode white, light mode black

  static Color whiteAndBlackcolor() {
    var mode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return mode == ThemeMode.dark ? white : black;
  }

// primary and black  => dark mode black, lightmode theme.primaryColor,

  static Color blackAndPrimarycolor() {
    var mode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return mode == ThemeMode.dark ? black : primary;
  }

  static Color blackAndSearchcolor() {
    var mode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return mode == ThemeMode.dark
        ? black
        : ChautariColors.primaryColor().shade100;
  }

  static MaterialColor primaryColor() {
    return primary;
  }

// primary and white => dark mode white lightmode primary,
  static Color whiteAndPrimarycolor() {
    var mode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return mode == ThemeMode.dark ? white : primary;
  }

// dark mode white, lightmode , primary with shade900
  static Color primaryDarkAndWhite900color() {
    var mode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return mode == ThemeMode.dark ? white : primaryColor().shade900;
  }

  static Color shades900AndPrimaryColor() {
    var mode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return mode == ThemeMode.dark ? primaryColor().shade900 : primary;
  }

  static get orangeLike => Color(0xfff5a623);
  static get blueLike => Color(0xff203152);
}
