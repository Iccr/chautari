import 'package:chautari/model/login_model.dart';
import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/chautari_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/room/room_detail/room_detail_controller.dart';
import 'package:chautari/widgets/carousel.dart';
import 'package:chautari/widgets/chautari_list.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../room_widgets.dart';

class RoomDetail extends StatelessWidget {
  RoomDetailController controller = Get.put(RoomDetailController());

  Widget _getElement(String key, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(key),
            Spacer(),
            Spacer(),
            Text(
              value,
              textAlign: TextAlign.left,
            ),
          ],
        ),
        SizedBox(
          height: ChautariPadding.standard,
        )
      ],
    );
  }

  Widget detailBlock(List<Widget> content) {
    return wrapWithDecoratedContainer(
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: content,
      ),
    );
  }

  Widget wrapWithDecoratedContainer(Widget child) {
    return Container(
      padding: EdgeInsets.all(ChautariPadding.small5),
      decoration: BoxDecoration(
        color: ChautariColors.blackWithOpacityAndWhitecolor(),
        borderRadius: BorderRadius.circular(
          ChautariPadding.small5,
        ),
        boxShadow: [ChautariDecoration().standardBoxShadow],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text("Detail"),
          ),
          body: ProgressHud(
            isLoading: controller.isLoading,
            child: ListView(
              children: [
                CarouselWithIndicator(controller.room),
                Container(
                  padding: EdgeInsets.all(ChautariPadding.standard),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            ChautariPadding.small5,
                          ),
                          boxShadow: [ChautariDecoration().standardBoxShadow],
                        ),
                        child: RoomsInsight(room: controller.room),
                      ),
                      SizedBox(height: ChautariPadding.standard),
                      ChautariList().getSeperator(),

                      TopDownPaddingWrapper(
                        child: Text(
                          "Detail",
                          style: ChautariTextStyles().listTitle,
                        ),
                      ),

                      // RoomDetailInsight(room: controller.room)
                      detailBlock(controller.roomDetailHashContent.entries
                          .map((e) => _getElement(e.key, e.value))
                          .toList()),

                      TopDownPaddingWrapper(
                        child: Text(
                          "Water",
                          style: ChautariTextStyles().listTitle,
                        ),
                      ),

                      wrapWithDecoratedContainer(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: controller.water.map((e) {
                            print(e);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e),
                                SizedBox(
                                  height: ChautariPadding.standard,
                                )
                              ],
                            );
                          }).toList(),
                        ),
                      ),

                      TopDownPaddingWrapper(
                        child: Text(
                          "Parkings",
                          style: ChautariTextStyles().listTitle,
                        ),
                      ),

                      wrapWithDecoratedContainer(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: controller.parkings.map((e) {
                            print(e);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.name),
                                SizedBox(
                                  height: ChautariPadding.standard,
                                )
                              ],
                            );
                          }).toList(),
                        ),
                      ),

                      TopDownPaddingWrapper(
                        child: Text(
                          "Amenities",
                          style: ChautariTextStyles().listTitle,
                        ),
                      ),

                      wrapWithDecoratedContainer(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: controller.amenities.map((e) {
                            print(e);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.name),
                                SizedBox(
                                  height: ChautariPadding.standard,
                                )
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      // SizedBox(height: ChautariPadding.standard),

                      TopDownPaddingWrapper(
                        child: Text(
                          "Contact",
                          style: ChautariTextStyles().listTitle,
                        ),
                      ),

                      detailBlock(
                        [
                          _getElement(
                              "Added By", controller.room.user?.name ?? ""),
                          if (controller.room.phone_visibility ?? false)
                            _getElement("phone", controller.room.phone ?? ""),
                          TopDownPaddingWrapper(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                          ChautariPadding.small5),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(Get.width),
                                        border: Border.all(width: 0.5),
                                      ),
                                      child: IconButton(
                                          icon: Icon(
                                            LineIcons.phone,
                                            color: ChautariColors
                                                .primaryDarkAndWhite900color(),
                                          ),
                                          onPressed: () {}),
                                    ),
                                    Text("Call")
                                  ],
                                ),
                                SizedBox(
                                  width: ChautariPadding.standard,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                          ChautariPadding.small5),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(Get.width),
                                        border: Border.all(width: 0.5),
                                      ),
                                      child: IconButton(
                                          icon: Icon(
                                            LineIcons.comments_o,
                                            color: ChautariColors
                                                .primaryDarkAndWhite900color(),
                                          ),
                                          onPressed: () {}),
                                    ),
                                    Text("Chat")
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
