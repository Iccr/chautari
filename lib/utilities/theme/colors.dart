import 'package:chautari/utilities/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChautariColors {
  ThemeMode _mode;
  ChautariColors() {
    ThemeController theme = Get.find();
    _mode = theme.mode;
  }

  Color blackAndWhitecolor() {
    return _mode == ThemeMode.dark ? Colors.white70 : Colors.black;
  }
}
