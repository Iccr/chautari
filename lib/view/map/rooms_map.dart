import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/view/map/rooms_map_controller.dart';
import 'package:chautari/view/room/my_rooms/my_room_viewmodel.dart';
import 'package:chautari/view/room/room_widgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RoomsMap extends StatelessWidget {
  final RoomsMapController controller = Get.put(RoomsMapController());

  Widget getchildWidget() {
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

  @override
  Widget build(BuildContext context) {
    return GetX<RoomsMapController>(
      init: Get.put(RoomsMapController()),
      builder: (_) => VisibilityDetector(
        key: GlobalKey(),
        onVisibilityChanged: (VisibilityInfo info) {
          if (info.visibleFraction == 1.0) {
            print(info.visibleFraction);
            if (!controller.renderingDone.value) {
              controller.getMarkers();
            }
          }
        },
        child: SafeArea(
          child: Stack(
            children: [
              ...controller.iconsWidgets,
              controller.map
                  .setMarkers(controller.markers.value)
                  .setchild(
                    Obx(() => getchildWidget() ?? Container()),
                  )
                  .setOnTapLocation((latLng) => controller.clearRoomCard())
                  .build(),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey.withAlpha(80),
                      borderRadius: BorderRadius.only(
                          bottomRight:
                              Radius.circular(ChautariPadding.small5))),
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
      ),
    );
  }
}
