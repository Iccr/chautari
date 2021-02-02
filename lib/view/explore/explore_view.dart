import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/explore/explore_controller.dart';
import 'package:chautari/view/room/room_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Exploreview extends StatelessWidget {
  final ExploreController c = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ProgressHud(
        isLoading: c.isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Explore"),
          ),
          body: ListRoom(
            rooms: c.models ?? [],
            onTap: (room) {
              print("open room detail");
              Get.toNamed(RouteName.roomDetail, arguments: room);
            },
          ),
        ),
      ),
    );
  }
}
