import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_style.dart';

import 'package:chautari/view/room/my_rooms/my_room_controller.dart';
import 'package:chautari/view/room/my_rooms/my_room_viewmodel.dart';

import 'package:chautari/view/room/room_detail/room_detail_controller.dart';
import 'package:chautari/view/room/room_widgets.dart';
import 'package:chautari/widgets/Row_with_space_between.dart';
import 'package:chautari/widgets/decorated_container_wrapper.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MyRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyRoomsController>(
      init: MyRoomsController(),
      builder: (c) => ProgressHud(
        isLoading: c.isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Rooms"),
          ),
          body: ListRoom(
            rooms: c.models ?? [],
            onTap: (room) {
              print("open room detail");
              Get.toNamed(RouteName.roomDetail,
                  arguments: RoomDetailViewModel(room, isMyRoom: true));
            },
          ),
        ),
      ),
    );
  }
}

class MyRoomDetailBottomBlock extends StatelessWidget {
  final RoomDetailController controller = Get.find();
  MyRoomDetailBottomBlock({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: DecoratedContainerWrapper(
        child: Column(
          children: [
            RowSpaceBetween(
              keyValue: "Status",
              value: "Available for rent",
              valueStyle: ChautariTextStyles()
                  .listSubtitle
                  .copyWith(color: ChautariColors.primary),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Update status"),
                    Spacer(),
                    Container(
                      width: 65,
                      child: Switch(
                        activeTrackColor:
                            ChautariColors.primary.withOpacity(0.5),
                        value: controller.room.available ?? false,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                Text(
                    "Note: If turned off, people will not be able to find this property in chautari basti"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
