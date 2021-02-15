import 'package:chautari/model/room_model.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/chautari_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/widgets/carousel.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  final RoomModel room;
  final Function onTap;
  RoomWidget({@required this.room, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(ChautariPadding.small5),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => {
            if (onTap != null)
              {
                onTap(
                  room,
                ),
              }
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ChautariPadding.small5),
              boxShadow: [ChautariDecoration().standardBoxShadow],
            ),
            child: Row(
              children: [
                Container(
                  child: CarouselWithIndicator(
                    room,
                    showWaterMark: false,
                    onImageTapped: () => {
                      if (onTap != null)
                        {
                          onTap(
                            room,
                          ),
                        }
                    },
                  ),
                ),
                Expanded(
                  child: RoomsInsight(room: this.room),
                ),
              ],
            ),
          ),
        ));
  }
}

class RoomsInsight extends StatelessWidget {
  final RoomModel room;
  RoomsInsight({@required this.room});

  final double vgap = 1;
  final double hgap = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ChautariColors.blackWithOpacityAndWhitecolor(),
        ),
        padding: EdgeInsets.all(ChautariPadding.small5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${room.address}",
                  style: ChautariTextStyles().listTitle,
                  textAlign: TextAlign.left,
                ),
                Text("${room.districtName}-${room.state}")
              ],
            ),
            SizedBox(height: vgap),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${room?.typeName ?? "a"}",
                  textAlign: TextAlign.left,
                  style: ChautariTextStyles()
                      .listSubtitle
                      .copyWith(color: ChautariColors.primary),
                ),
                Text(
                  "${room.numberOfRooms}" +
                      " rooms, ${room.parkingCount}" +
                      " parking + ${room.amenityCount} more",
                ),
              ],
            ),
            SizedBox(height: vgap),
            Row(
              children: [
                Text("date: "),
                Text(room.postedOn ?? "n/a",
                    style: TextStyle(color: ChautariColors.grey)),
              ],
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Rs. ${room.formattedPrice()}",
                  textAlign: TextAlign.right,
                  style: ChautariTextStyles().listTitle,
                ),
                Text(
                  " /month",
                  textAlign: TextAlign.right,
                  style: ChautariTextStyles().listSubtitle,
                ),
              ],
            ),
          ],
        ));
  }
}

class ImageCarousel extends StatelessWidget {
  final RoomModel room;
  ImageCarousel({@required this.room});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
    );
  }
}

class ListRoom extends StatelessWidget {
  final List<RoomModel> rooms;
  final Function(RoomModel) onTap;
  final ScrollController controller;
  ListRoom({@required this.rooms, this.onTap, this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: controller,
        separatorBuilder: (context, index) {
          return Container(
            height: 0,
          );
        },
        itemCount: rooms.length,
        itemBuilder: (BuildContext context, index) {
          return RoomWidget(
            room: this.rooms.elementAt(index),
            onTap: this.onTap,
          );
        });
  }
}
