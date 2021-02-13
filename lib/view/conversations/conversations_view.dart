import 'package:chautari/view/conversations/conversations_controller.dart';
import 'package:chautari/widgets/chautari_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationView extends StatelessWidget {
  ConversationsController controller = Get.put(ConversationsController());

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
                controller.goToChats(index);
              },
              controller.conversationViewModel.elementAt(index),
            );
          },
        ),
      ),
    );
  }
}