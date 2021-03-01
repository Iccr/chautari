import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/explore/explore_view.dart';
import 'package:chautari/view/map/rooms_map.dart';
import 'package:chautari/view/profile/profile_view.dart';
import 'package:chautari/view/setting/setting_view.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class NewTabView extends StatefulWidget {
  NewTabView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NewTabViewState createState() => _NewTabViewState();
}

class _NewTabViewState extends State<NewTabView>
    with SingleTickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of first screen

  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  double position = 0.0;
  double sensitivityFactor = 60.0;

  List<Widget> _widgetOptions() =>
      <Widget>[Exploreview(), RoomsMap(), ProfileView(), SettingView()];

  final iconList = <IconData>[
    Icons.search,
    LineIcons.map,
    LineIcons.user,
    LineIcons.gears,
  ];

  final titleList = <String>[
    "Explore",
    "Map",
    "Profile",
    "Setting",
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(milliseconds: 100),
      () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels < 0) {
          _animationController.forward();
          return;
        }
        if (scrollInfo.metrics.pixels - position >= sensitivityFactor) {
          print('Axis Scroll Direction : Up');
          position = scrollInfo.metrics.pixels;
          // _animationController.reset();
          _animationController.reverse();
        }
        if (position - scrollInfo.metrics.pixels >= sensitivityFactor) {
          print('Axis Scroll Direction : Down');
          position = scrollInfo.metrics.pixels;
          _animationController.forward();
        }
        // if (notification.metrics.pixels > 10) {
        //   print(notification.metrics.pixels);
        //   _animationController.forward();
        // } else if (notification.metrics.pixels < -10) {
        //   print(notification.metrics.pixels);
        //   _animationController.reset();
        // }
      },
      child: Scaffold(
        extendBody: true,
        body:
            _widgetOptions().elementAt(_bottomNavIndex), // main tab controllers
        floatingActionButton: ScaleTransition(
          scale: animation,
          child: FloatingActionButton(
            mini: true,
            elevation: 8,
            backgroundColor: ChautariColors.taBFabColor(),
            // yello color
            child: Icon(
              Icons.home_work,
              color: ChautariColors.tabBlack, // dark model black color
            ),

            onPressed: () async {
              var _ = await Get.toNamed(RouteName.addRoom);

              _animationController.reset();
              _animationController.forward();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
            return Column(
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
                        .copyWith(color: color, fontSize: 12),
                  ),
                )
              ],
            );
          },
          backgroundColor: ChautariColors.taBackgroundColor(),
          activeIndex: _bottomNavIndex,
          notchMargin: 0,
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 0,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          onTap: (index) => setState(() => _bottomNavIndex = index),
        ),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final IconData iconData;

  NavigationScreen(this.iconData) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 333),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 333),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ChautariColors.white,
      child: Center(
        child: CircularRevealAnimation(
          animation: animation,
          centerOffset: Offset(80, 80),
          maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
          child: Icon(
            widget.iconData,
            color: ChautariColors.tabYellow,
            size: 160,
          ),
        ),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
