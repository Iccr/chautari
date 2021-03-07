import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/tab/tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<ChautariTabController>(
      init: Get.put(ChautariTabController()),
      builder: (controller) => Scaffold(
        extendBody: true,
        body: controller.currentScreen, // main tab controllers
        floatingActionButton: null,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          height: controller.tabbarHeight,
          itemCount: controller.iconList.length,
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
                    controller.iconList[index],
                    size: 24,
                    color: color,
                  ),
                  const SizedBox(height: 0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      controller.titleList.elementAt(index),
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
          activeIndex: controller.bottomNavIndex.value,
          splashSpeedInMilliseconds: 0,
          gapLocation: GapLocation.none,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          onTap: (index) {
            controller.bottomNavIndex.value = index;
          },
        ),
      ),
    );
  }
}
