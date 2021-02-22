import 'package:chautari/view/room/room_location_map/show_room_location_map_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowRoomLocationMap extends StatelessWidget {
  final ShowRoomLocationMapController controller =
      Get.put(ShowRoomLocationMapController());

  Widget getMapWidget() {
    return controller.map.build();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pick Location")),
      body: getMapWidget(),
    );
  }
}
