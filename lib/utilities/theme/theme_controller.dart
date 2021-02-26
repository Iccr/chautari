import 'package:chautari/utilities/constants.dart';
import 'package:chautari/utilities/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final GetStorage box = GetStorage();

  var themeChanged = true.obs;
  @override
  void onInit() {
    super.onInit();
    String theme = box.read(AppConstant.themeKey);
    if (theme == null) {
      theme = AppConstant.lighttheme;
      _changeTheme(
        _getThemeData(theme),
      );
    } else {
      _changeTheme(
        _getThemeData(theme),
      );
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  ThemeMode get mode => Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;

  setTheme(String theme) {
    box.write(AppConstant.themeKey, theme);
    _changeTheme(
      _getThemeData(theme),
    );
  }

  ThemeData _getThemeData(String theme) {
    return theme == AppConstant.darktheme
        ? AppTheme.darkTheme()
        : AppTheme.lightTheme();
  }

  _changeTheme(ThemeData theme) {
    Get.changeTheme(theme);
    themeChanged.refresh();
  }
}
