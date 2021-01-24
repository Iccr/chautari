import 'package:chautari/utilities/theme/theme.dart';
import 'package:chautari/view/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'setting screen';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GetBuilder<SettingController>(
        init: SettingController(),
        builder: (c) => ListView(
          children: <Widget>[
            ListTile(
              title: Text('dark theme'),
              onTap: () => {
                c.setTheme(AppTheme.darkTheme()),
              },
            ),
            ListTile(
              title: Text('light theme'),
              onTap: () => {
                c.setTheme(AppTheme.lightTheme()),
              },
            ),
            ListTile(
              title: Text('nepali lang'),
              onTap: () => {
                print("nepali lang"),
              },
            ),
          ],
        ),
      ),
    );
  }
}
