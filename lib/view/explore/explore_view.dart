import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/explore/explore_controller.dart';
import 'package:chautari/view/room/my_rooms/my_room_viewmodel.dart';
import 'package:chautari/view/room/room_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Exploreview extends StatelessWidget {
  getViewModel() {}

  @override
  Widget build(BuildContext context) {
    final ExploreController c = Get.put(ExploreController());
    return Obx(
      () => ProgressHud(
        isLoading: c.isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Explore"),
          ),
          body: ListRoom(
            rooms: c.models ?? [],
            onTap: (room) => Get.toNamed(RouteName.roomDetail,
                arguments: RoomDetailViewModel(room, isMyRoom: false)),
          ),
        ),
      ),
    );
  }
}
