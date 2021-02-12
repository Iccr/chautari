import 'package:chautari/view/conversations/conversations_controller.dart';
import 'package:chautari/view/setting/setting_controller.dart';
import 'package:chautari/view/setting/theme_selection_view.dart';
import 'package:chautari/widgets/chautari_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ConversationView extends StatelessWidget {
  ConversationsController controller = Get.put(ConversationsController());
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

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Obx(
        () => ListView.separated(
          separatorBuilder: (context, index) => ChautariList().getSeperator(),
          itemCount: controller.conversations.length,
          itemBuilder: (context, index) {
            return ChautariList().getListTile(
              () {
                _showThemeSelectionView(context);
              },
              controller.conversationViewModel.elementAt(index),
            );
          },
        ),
      ),
    );
  }
}
