import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/room/room_detail/room_detail_controller.dart';
import 'package:chautari/widgets/Row_with_space_between.dart';
import 'package:chautari/widgets/decorated_container_wrapper.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class RoomDetailBottomBlock extends StatelessWidget {
  RoomDetailController controller = Get.find();

  Widget detailBlock(List<Widget> content) {
    return DecoratedContainerWrapper(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: content,
      ),
    );
  }

  _call() async {
    var number = controller.room.phone;
    var url = 'tel://$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        TopDownPaddingWrapper(
          child: Text(
            "Contact",
            style: ChautariTextStyles().listTitle,
          ),
        ),
        detailBlock(
          [
            RowSpaceBetween(
                keyValue: "Added By", value: controller.room.user?.name ?? ""),
            if (controller.room.phoneVisibility ?? false)
              RowSpaceBetween(
                  keyValue: "phone", value: controller.room.phone ?? ""),
            TopDownPaddingWrapper(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (controller.room.phoneVisibility ?? false)
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(ChautariPadding.small5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Get.width),
                            border: Border.all(width: 0.5),
                          ),
                          child: IconButton(
                              icon: Icon(
                                LineIcons.phone,
                                color: ChautariColors
                                    .primaryDarkAndWhite900color(),
                              ),
                              onPressed: () {
                                _call();
                              }),
                        ),
                        Text("Call")
                      ],
                    ),
                  SizedBox(
                    width: ChautariPadding.standard * 2,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(ChautariPadding.small5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Get.width),
                          border: Border.all(width: 0.5),
                        ),
                        child: IconButton(
                            icon: Icon(
                              LineIcons.comments_o,
                              color:
                                  ChautariColors.primaryDarkAndWhite900color(),
                            ),
                            onPressed: () => {}),
                      ),
                      Text("Chat")
                    ],
                  ),
                  SizedBox(
                    width: ChautariPadding.standard * 2,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ChautariPadding.standard * 2,
            )
          ],
        ),
      ],
    );
  }
}
