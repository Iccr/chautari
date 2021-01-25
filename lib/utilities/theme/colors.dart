import 'package:chautari/utilities/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChautariColors {
  ThemeMode _mode;
  final Color _primary = Colors.teal;
  final Color _white = Colors.white;
  final Color _black = Colors.black;
  final Color _green = Colors.green;
  final Color _red = Colors.red;
  final MaterialColor _grey = Colors.grey;

  final Color tabBarActiveBackgroundColor = Colors.grey[800];

  Color get black => _black;

  Color get white => _white;
  Color get green => _green;
  Color get red => _red;
  MaterialColor get grey => _grey;

  ChautariColors() {
    ThemeController theme = Get.find();
    _mode = theme.mode;
  }

  // black and white => lightmode black, dark mode white

  Color blackAndWhitecolor() {
    return _mode == ThemeMode.dark ? _black : _white;
  }

// black and primary => lightmode black, dark mode theme.primaryColor

  Color blackAndPrimarycolor() {
    return _mode == ThemeMode.dark ? _black : _primary;
  }

  Color primaryColor() {
    return _primary;
  }

// primary and white => lightmode primary, dark mode white
  Color primaryAndWhitecolor() {
    return _mode == ThemeMode.dark ? _white : _primary;
  }
}
