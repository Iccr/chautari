import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/explore/explore_view.dart';
import 'package:chautari/view/map/rooms_map.dart';
import 'package:chautari/view/profile/profile_view.dart';
import 'package:chautari/view/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Tabbar extends StatefulWidget {
  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions(TextStyle optionStyle) =>
      <Widget>[Exploreview(), RoomsMap(), ProfileView(), SettingView()];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child:
            _widgetOptions(theme.textTheme.headline4).elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: theme.primaryColor, boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: ChautariColors.black.withOpacity(.1),
          )
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 3,
                activeColor: ChautariColors.white,
                iconSize: 20,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                duration: Duration(milliseconds: 0),
                tabBackgroundColor:
                    ChautariColors.blackAndSearchcolor().withAlpha(100),
                tabs: [
                  GButton(
                      text: 'Explore',
                      icon: Icons.search,
                      iconSize: 20,
                      textStyle: ChautariTextStyles().listSubtitle
                      // leading: Icon(Icons.search),
                      ),
                  GButton(
                    // leading: Icon(LineIcons.map),
                    icon: LineIcons.map,
                    text: 'Map',
                    textStyle: ChautariTextStyles().listSubtitle,
                  ),
                  GButton(
                    // leading: Icon(LineIcons.user),
                    icon: LineIcons.user,
                    text: 'Profile',
                    textStyle: ChautariTextStyles().listSubtitle,
                  ),
                  GButton(
                    // leading: Icon(LineIcons.gears),
                    icon: LineIcons.gears,
                    text: 'Setting',
                    textStyle: ChautariTextStyles().listSubtitle,
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                    // middleware.isRoomMapViewInScreen.add(index == 1);
                  });
                }),
          ),
        ),
      ),
    );
  }
}
