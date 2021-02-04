import 'package:chautari/utilities/loading/progress_hud.dart';

import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/view/room/my_rooms/my_room.dart';
import 'package:chautari/view/room/room_detail/room_detail_bottom_block.dart';
import 'package:chautari/view/room/room_detail/room_detail_content.dart';
import 'package:chautari/view/room/room_detail/room_detail_controller.dart';
import 'package:chautari/widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomDetail extends StatelessWidget {
  RoomDetailController controller = Get.put(RoomDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text("Detail"),
          ),
          body: ProgressHud(
            isLoading: controller.isLoading,
            child: ListView(
              children: [
                CarouselWithIndicator(controller.room),
                Container(
                  padding: EdgeInsets.all(ChautariPadding.standard),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoomDetailContent(),
                      if (!controller.isMyRoomDetail) RoomDetailBottomBlock(),
                      if (controller.isMyRoomDetail) MyRoomDetailBottomBlock()

                      // SizedBox(height: ChautariPadding.standard),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
