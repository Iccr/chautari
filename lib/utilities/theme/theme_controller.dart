import 'package:chautari/utilities/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ThemeController extends GetxController {
  ThemeData _themeData;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _themeData = AppTheme.lightTheme();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  ThemeData get theme => _themeData;

  setTheme() {
    Get.changeTheme(
        Get.isDarkMode ? AppTheme.lightTheme() : AppTheme.darkTheme());
  }
}
