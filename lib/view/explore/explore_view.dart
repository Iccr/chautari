import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/view/explore/explore_controller.dart';
import 'package:chautari/view/room/room_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Exploreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreController>(
      init: ExploreController(),
      builder: (c) => ProgressHud(
        isLoading: c.isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Explore"),
          ),
          body: ListRoom(
            rooms: c.models ?? [],
            onTap: () {
              print("open room detail");
            },
          ),
        ),
      ),
    );
  }
}
