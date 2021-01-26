import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/constants.dart';
import 'package:chautari/utilities/theme/theme.dart';
import 'package:chautari/utilities/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SettingController extends GetxController {
  ThemeData _themeData;
  ThemeController themeController;

  List<MenuItem> _settingsMenu = [
    MenuItem(
        title: "Theme",
        index: 0,
        subtitle: "Customize app appeareance of Chautari Basti"),
    MenuItem(
        title: "Lanugate",
        index: 1,
        subtitle: "Use Chautari Basit in your prefered language"),
  ];

  var _themeMenu = [
    MenuItem(
        title: AppConstant.darktheme,
        index: 0,
        subtitle: "abc",
        selected: true),
    MenuItem(title: AppConstant.lighttheme, index: 1)
  ].obs;

  List<MenuItem> get menu => _settingsMenu;
  List<MenuItem> get themes => _themeMenu.value;

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

  setTheme(MenuItem item) {
    var new_theme = themes.map(
      (e) {
        e.selected = item.index == e.index;
        return e;
      },
    ).toList();

    _themeMenu.assignAll(new_theme);
    themeController.setTheme(item.title);
  }

  selectedIndex(int index) {
    MenuItem selectedItem = menu.elementAt(index);
    print("selected item:${selectedItem.title}");

    switch (selectedItem.index) {
      case 0:
        break;
      case 1:
        break;
      default:
    }
  }
}
