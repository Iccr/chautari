import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/AddInfo/add_info.dart';
import 'package:chautari/view/explore/explore_view.dart';
import 'package:chautari/view/map/rooms_map.dart';
import 'package:chautari/view/profile/profile_view.dart';
import 'package:chautari/view/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class NewTabView extends StatefulWidget {
  NewTabView({Key key}) : super(key: key);

  @override
  _NewTabViewState createState() => _NewTabViewState();
}

class _NewTabViewState extends State<NewTabView>
    with SingleTickerProviderStateMixin {
  var _bottomNavIndex = 0; //default index of first screen

  List<Widget> _widgetOptions() => <Widget>[
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _widgetOptions().elementAt(_bottomNavIndex), // main tab controllers
      floatingActionButton: null,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: 50,
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = Get.isDarkMode
              ? (isActive)
                  ? ChautariColors.tabYellow
                  : ChautariColors.white
              : (isActive)
                  ? ChautariColors.white
                  : ChautariColors.black;
          return Container(
            padding: EdgeInsets.only(top: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 24,
                  color: color,
                ),
                const SizedBox(height: 0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    titleList.elementAt(index),
                    maxLines: 1,
                    style: ChautariTextStyles()
                        .listSubtitle
                        .copyWith(color: color, fontSize: 14),
                  ),
                )
              ],
            ),
          );
        },
        backgroundColor: ChautariColors.taBackgroundColor(),
        activeIndex: _bottomNavIndex,
        splashSpeedInMilliseconds: 0,
        gapLocation: GapLocation.none,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
