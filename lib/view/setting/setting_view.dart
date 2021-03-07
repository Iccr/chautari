import 'package:chautari/view/setting/setting_controller.dart';
import 'package:chautari/view/setting/theme_selection_view.dart';
import 'package:chautari/widgets/chautari_list.dart';
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
    final title = 'Setting';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GetBuilder<SettingController>(
        init: SettingController(),
        builder: (c) => Stack(
          children: [
            Container(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    ChautariList().getSeperator(),
                itemCount: c.menu.length,
                itemBuilder: (context, index) {
                  return ChautariList().getListTile(
                    () {
                      _showThemeSelectionView(context);
                    },
                    c.menu.elementAt(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
