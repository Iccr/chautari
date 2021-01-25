import 'package:chautari/utilities/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ThemeController extends GetxController {
  var _themeData = AppTheme.lightTheme().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _themeData.value = AppTheme.lightTheme();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  ThemeData get theme => _themeData.value;
  ThemeMode get mode => Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;

  setTheme() {
    Get.changeTheme(
        Get.isDarkMode ? AppTheme.lightTheme() : AppTheme.darkTheme());
    _themeData.value = Get.theme;
  }
}
