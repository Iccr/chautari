import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/utilities/theme/theme.dart';
import 'package:chautari/view/setting/setting_controller.dart';
import 'package:chautari/view/setting/theme_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SettingView extends StatelessWidget {
  _showThemeSelectionView(BuildContext context) async {
    await showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ThemeSelectionView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = 'setting screen';

    _selectedIndex(int index, SettingController c) {
      switch (index) {
        case 0:
          // _showThemeSelectionView();
          break;
        case 1:
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GetBuilder<SettingController>(
        init: SettingController(),
        builder: (c) => ListView.separated(
          separatorBuilder: (context, index) => Container(
            padding: EdgeInsets.only(left: 10, right: 100),
            height: 0.5,
            child: Container(
              color: ChautariColors.primaryAndWhitecolor().withOpacity(0.5),
            ),
          ),
          itemCount: c.menu.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => {_showThemeSelectionView(context)},
              child: Container(
                padding: EdgeInsets.only(left: ChautariPadding.standard),
                height: 60,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        c.menu.elementAt(index).title,
                        style: ChautariTextStyles().listTitle,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        c.menu.elementAt(index).subtitle,
                        style: ChautariTextStyles().listSubtitle,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
