import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
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
    return GetX<MyRoomsController>(
      init: MyRoomsController(),
      builder: (c) => ProgressHud(
        isLoading: c.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Rents"),
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
              value: controller.statusMessage,
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
                      height: 35,
                      child: Transform.scale(
                        scale: 1.3,
                        child: Switch(
                          activeTrackColor:
                              ChautariColors.primary.withOpacity(0.5),
                          value: controller.availability,
                          onChanged: (value) {
                            print(value);
                            // controller.room
                            controller.updateRoomAvailability(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                    "Note: If switch is turned off, people will not be able to find this property in Chautari basti"),
                ChautariRaisedButton(
                  title: "Update More detail",
                  onPressed: () => Get.toNamed(RouteName.updateRoom,
                      arguments: controller.room),
                ),
                ChautariRaisedButton(
                  title: "Delete",
                  onPressed: () => controller.askForPermissionToDelete(),
                ),
                Text(
                    "Warning: All of the data related with this propery is permanently lost."),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChautariRaisedButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const ChautariRaisedButton({
    this.title,
    this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: RaisedButton(
        color: ChautariColors.primaryColor(),
        onPressed: () => onPressed(),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ChautariPadding.small5)),
          padding: EdgeInsets.all(ChautariPadding.standard),
          child: Text(
            title,
            style: ChautariTextStyles()
                .normal
                .copyWith(color: ChautariColors.white),
          ),
        ),
      ),
    );
  }
}
