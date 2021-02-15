import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/explore/explore_controller.dart';
import 'package:chautari/view/explore/filter_view.dart';
import 'package:chautari/view/room/my_rooms/my_room_viewmodel.dart';
import 'package:chautari/view/room/room_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Exploreview extends StatelessWidget {
  ScrollController scrollController = ScrollController();
  getViewModel() {}

  @override
  Widget build(BuildContext context) {
    final ExploreController c = Get.put(ExploreController());

    _goTOLogin({ExploreController controller}) async {}

    return Obx(
      () => ProgressHud(
        isLoading: c.isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Chautari Basti"),
            actions: [
              IconButton(
                  icon: Icon(LineIcons.filter),
                  onPressed: () {
                    Get.toNamed(RouteName.filterRoom);
                    print("filter");
                  }),
            ],
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels / 10 > 5) {
                print(notification.metrics.pixels / 10);
                c.height.value = 0;
              }
              if (notification.metrics.pixels / 10 < -5) {
                print(notification.metrics.pixels / 10);
                c.height.value = 45;
              }
            },
            child: Column(
              children: [
                // Search textfield
                AnimatedContainer(
                  duration: Duration(milliseconds: c.duration.value),
                  height: c.containerHeight,
                  padding: EdgeInsets.all(ChautariPadding.small5),
                  child: TextField(
                    onSubmitted: (value) {
                      c.search(address: value);
                    },
                    style: ChautariTextStyles().listSubtitle,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: "Quick Search",
                      hintStyle: ChautariTextStyles().listSubtitle,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      fillColor:
                          ChautariColors.blackAndSearchcolor().withOpacity(0.6),
                      filled: true,
                      isDense: false,
                    ),
                  ),
                ),
                Expanded(
                  child: ListRoom(
                    // controller: scrollController,
                    rooms: c.models ?? [],
                    onTap: (room) => Get.toNamed(RouteName.roomDetail,
                        arguments: RoomDetailViewModel(room, isMyRoom: false)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
