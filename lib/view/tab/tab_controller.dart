import 'package:chautari/view/AddInfo/add_info.dart';
import 'package:chautari/view/explore/explore_view.dart';
import 'package:chautari/view/map/rooms_map.dart';
import 'package:chautari/view/profile/profile_view.dart';
import 'package:chautari/view/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ChautariTabController extends GetxController
    with SingleGetTickerProviderMixin {
  var bottomNavIndex = 0.obs; //default index of first screen
  double tabbarHeight = 50;
  List<Widget> widgetOptions() => <Widget>[
        Exploreview(),
        RoomsMap(),
        AddInfo(),
        ProfileView(),
        SettingView()
      ];

  final iconList = <IconData>[
    Icons.search,
    LineIcons.map,
    LineIcons.money,
    LineIcons.user,
    LineIcons.gears,
  ];

  final titleList = <String>[
    "Explore",
    "Map",
    "Earn",
    "Profile",
    "Setting",
  ];

  Widget get currentScreen => widgetOptions().elementAt(bottomNavIndex.value);

  TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: widgetOptions().length);
  }

  onClose() {
    controller.dispose();

    super.onClose();
  }
}
