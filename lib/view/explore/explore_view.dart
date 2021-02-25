import 'dart:io';

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
    var searchFocusNode = FocusNode();

    return Obx(
      () => ProgressHud(
        isLoading: c.isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Container(
              // duration: Duration(milliseconds: c.duration.value),
              height: c.containerHeight,
              padding: EdgeInsets.all(ChautariPadding.small5),
              child: TextField(
                focusNode: searchFocusNode,
                maxLines: 1,
                maxLength: 25,
                buildCounter: (BuildContext context,
                        {int currentLength, int maxLength, bool isFocused}) =>
                    null,
                onSubmitted: (value) {
                  c.search(address: value);
                },
                style: ChautariTextStyles().listSubtitle,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: "Quick Search",
                  hintStyle: ChautariTextStyles().listSubtitle,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  fillColor:
                      ChautariColors.blackAndSearchcolor().withAlpha(153),
                  filled: true,
                  isDense: false,
                ),
              ),
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                      icon: Icon(LineIcons.filter),
                      onPressed: () {
                        Get.toNamed(RouteName.filterRoom);
                        print("filter");
                      }),
                  if (c.filterCount.value != 0)
                    Positioned(
                      left: 10,
                      top: 5,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ChautariColors.cyan,
                        ),
                        child: Center(
                            child: Text(
                          "${c.filterCount.value}",
                          style: ChautariTextStyles().listSubtitle.copyWith(
                              fontSize: 10, color: ChautariColors.black),
                        )),
                      ),
                    ),
                ],
              ),
            ],
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels > 10) {
                if (searchFocusNode.hasFocus) {
                  searchFocusNode.unfocus();
                }
              }
            },
            child: c.models.isEmpty
                ? NoDataView()
                : Column(
                    children: [
                      Expanded(
                        child: ListRoom(
                          // controller: scrollController,
                          rooms: c.models ?? [],
                          onTap: (room) => Get.toNamed(RouteName.roomDetail,
                              arguments: RoomDetailViewModel(room,
                                  isMyRoom: room.id == false)),
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

class NoDataView extends StatelessWidget {
  const NoDataView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            child: Image.asset("images/No_data.png"),
          ),
          Text(
            "There is not much to show you",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
