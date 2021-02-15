import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/explore/explore_controller.dart';
import 'package:chautari/view/room/my_rooms/my_room_viewmodel.dart';
import 'package:chautari/view/room/room_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class Exploreview extends StatelessWidget {
  ScrollController scrollController = ScrollController();
  getViewModel() {}

  @override
  Widget build(BuildContext context) {
    final ExploreController c = Get.put(ExploreController());

    return Obx(
      () => ProgressHud(
        isLoading: c.isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Chautari Basti"),
            actions: [
              // IconButton(
              //   icon: Icon(Icons.search),
              //   onPressed: () => c.isSearching.toggle(),
              // ),
              IconButton(icon: Icon(LineIcons.filter), onPressed: null),
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
                c.height.value = 40;
              }

              // if (notification is UserScrollNotification &&
              //     notification.direction == ScrollDirection.reverse) {
              //   print(notification.metrics.pixels);
              //   print("animate");
              // }
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
                      print(value);
                    },
                    style: ChautariTextStyles().listTitle,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: "Quick Search",
                      hintStyle: ChautariTextStyles().listSubtitle,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      fillColor:
                          ChautariColors.blackAndSearchcolor().withOpacity(0.6),
                      filled: true,
                      isDense: true,
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
