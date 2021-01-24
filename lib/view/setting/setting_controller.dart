import 'package:chautari/utilities/theme/theme.dart';
import 'package:chautari/utilities/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SettingController extends GetxController {
  ThemeData _themeData;
  ThemeController themeController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    themeController = Get.find();
    _themeData = AppTheme.lightTheme();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  setTheme(ThemeData theme) {
    themeController.setTheme();
  }
}
