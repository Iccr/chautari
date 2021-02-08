import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/view/map/rooms_map_controller.dart';
import 'package:chautari/view/room/my_rooms/my_room_viewmodel.dart';
import 'package:chautari/view/room/room_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoomsMap extends StatelessWidget {
  final RoomsMapController controller = Get.put(RoomsMapController());

  Set<Marker> getMarkers() {
    Set<Marker> markers = Set<Marker>();

    controller.models.forEach(
      (e) {
        var latlng = LatLng(e.lat, e.long);
        markers.add(
          Marker(
            markerId: MarkerId(
              e.id.toString(),
            ),
            position: latlng,
            onTap: () {
              controller.onTapMarkerOf(e);
            },
            infoWindow: InfoWindow(
              title: "Rs. ${e.price}",
            ),
          ),
        );
      },
    );
    return markers;
  }

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
        .setMarkers(getMarkers())
        .setchild(getchildWidget())
        .setOnTapLocation((latLng) => controller.clearRoomCard())
        .build();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => getMapWidget());
  }
}
