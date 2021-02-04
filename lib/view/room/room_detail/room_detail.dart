import 'package:chautari/utilities/loading/progress_hud.dart';

import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/chautari_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/room/room_detail/room_detail_bottom_block.dart';
import 'package:chautari/view/room/room_detail/room_detail_controller.dart';
import 'package:chautari/widgets/Row_with_space_between.dart';
import 'package:chautari/widgets/carousel.dart';
import 'package:chautari/widgets/chautari_list.dart';
import 'package:chautari/widgets/decorated_container_wrapper.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../room_widgets.dart';

class RoomDetail extends StatelessWidget {
  RoomDetailController controller = Get.put(RoomDetailController());

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
                      RoomDetailContent(),
                      RoomDetailBottomBlock()
                      // SizedBox(height: ChautariPadding.standard),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class RoomDetailContent extends StatelessWidget {
  RoomDetailController controller = Get.put(RoomDetailController());
  Widget detailBlock(List<Widget> content) {
    return DecoratedContainerWrapper(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: content,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            .map((e) => RowSpaceBetween(keyValue: e.key, value: e.value))
            .toList()),

        TopDownPaddingWrapper(
          child: Text(
            "Water",
            style: ChautariTextStyles().listTitle,
          ),
        ),

        DecoratedContainerWrapper(
            child: Column(
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
        )),

        TopDownPaddingWrapper(
          child: Text(
            "Parkings",
            style: ChautariTextStyles().listTitle,
          ),
        ),

        DecoratedContainerWrapper(
            child: Column(
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
        )),

        TopDownPaddingWrapper(
          child: Text(
            "Amenities",
            style: ChautariTextStyles().listTitle,
          ),
        ),

        DecoratedContainerWrapper(
            child: Column(
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
        )),
      ],
    );
  }
}
