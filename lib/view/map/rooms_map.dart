import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/map/rooms_map_controller.dart';
import 'package:chautari/view/room/my_rooms/my_room_viewmodel.dart';
import 'package:chautari/view/room/room_widgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RoomsMap extends StatelessWidget {
  final RoomsMapController controller = Get.put(RoomsMapController());

  getchildWidget() {
    return controller.selectedRoom == null
        ? null
        : Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    left: ChautariPadding.small5,
                    right: ChautariPadding.small5),
                child: RoomWidget(
                  room: controller.selectedRoom,
                  onTap: (room) => Get.toNamed(RouteName.roomDetail,
                      arguments: RoomDetailViewModel(room, isMyRoom: false)),
                ),
              ),
            ),
          );
  }

  Widget getMapWidget() {
    return controller.map
        .setMarkers(controller.markers.value)
        .setchild(
          getchildWidget(),
        )
        .setOnTapLocation((latLng) => controller.clearRoomCard())
        .build();
  }

  @override
  Widget build(BuildContext context) {
    // // appartment
    // return ChautariColors.green;
    // break;
    // // room
    // return ChautariColors.indigo;
    // break;
    // // flat
    // return ChautariColors.yellow;
    // break;
    // // hostel
    // return ChautariColors.teal;
    // break;
    // // shutter
    // return ChautariColors.brown;
    // break;
    // // office
    // return ChautariColors.purple;
    // break;
    // // commercial
    // return ChautariColors.blueGrey;
    // break;

    // // others
    // return ChautariColors.cyan;

    // %RoomTypes{name: "Appartment", value: 0},
    //   %RoomTypes{name: "Room", value: 1},
    //   %RoomTypes{name: "Flat", value: 2},
    //   %RoomTypes{name: "Hostel", value: 3},
    //   %RoomTypes{name: "Shutter", value: 4},
    //   %RoomTypes{name: "Office", value: 5},
    //   %RoomTypes{name: "Commercial", value: 6}

    return Obx(() => VisibilityDetector(
          key: GlobalKey(),
          onVisibilityChanged: (VisibilityInfo info) {
            if (info.visibleFraction == 1.0) {
              print(info.visibleFraction);
              if (!controller.renderingDone) {
                controller.getMarkers();
              }
            }
          },
          child: SafeArea(
            child: Stack(
              children: [
                ...controller.iconsWidgets,
                getMapWidget(),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    color: Colors.blueGrey.withAlpha(40),
                    padding: EdgeInsets.all(ChautariPadding.small5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.getInsightText(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
