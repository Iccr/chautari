import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/view/room/add_room/add_room_fourth_page.dart';
import 'package:chautari/view/room/add_room/add_room_second_page.dart';
import 'package:chautari/view/room/add_room/add_room_third_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateRoom extends StatelessWidget {
  AddRoomController controller = Get.put(AddRoomController());
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update room"),
      ),
      body: Column(
        children: [
          NumberOfRoomWidget(controller: controller),

          // price
          PriceWidget(
              pricekey: controller.formKeys.priceKey, controller: controller),

          // mobile visibility
          MobileVisibilityWidget(controller: controller),

          // contact number
          if (controller.contactNumberVisible.value) ...[
            ContactNumberWidget(
                contactKey: controller.formKeys.contactKey,
                controller: controller)
          ],

          // image
          ImageWidget(
              controller: controller, scrollController: _scrollController),
        ],
      ),
    );
  }
}
