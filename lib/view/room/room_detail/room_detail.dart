import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/chautari_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/room/room_detail/room_detail_controller.dart';
import 'package:chautari/widgets/carousel.dart';
import 'package:chautari/widgets/chautari_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      SizedBox(height: ChautariPadding.standard),
                      Text(
                        "Detail",
                        style: ChautariTextStyles().listTitle,
                      ),
                      SizedBox(height: ChautariPadding.small5),
                      // RoomDetailInsight(room: controller.room)
                      detailBlock(controller.roomDetailHashContent.entries
                          .map((e) => _getElement(e.key, e.value))
                          .toList()),
                      SizedBox(height: ChautariPadding.standard),
                      Text(
                        "Water",
                        style: ChautariTextStyles().listTitle,
                      ),
                      SizedBox(height: ChautariPadding.small5),

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

                      SizedBox(height: ChautariPadding.standard),
                      Text(
                        "Parkings",
                        style: ChautariTextStyles().listTitle,
                      ),
                      SizedBox(height: ChautariPadding.small5),
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
                      SizedBox(height: ChautariPadding.standard),

                      Text(
                        "Amenities",
                        style: ChautariTextStyles().listTitle,
                      ),
                      SizedBox(height: ChautariPadding.small5),

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
                      SizedBox(height: ChautariPadding.standard),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
