import 'package:chautari/utilities/loading/progress_hud.dart';

import 'package:chautari/view/room/my_rooms/my_room_controller.dart';
import 'package:chautari/view/room/room_widgets.dart';
import 'package:flutter/material.dart';
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
          ),
        ),
      ),
    );
  }
}
