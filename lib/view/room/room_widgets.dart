import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/widgets/carousel.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  final RoomsModel room;
  Function onTap;
  RoomWidget({@required this.room, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ChautariPadding.small5),
        boxShadow: [
          BoxShadow(
              color: ChautariColors.whiteAndBlackcolor().withOpacity(0.24),
              offset: Offset(0.0, 1.4), //(x,y)
              blurRadius: 2.5,
              spreadRadius: 0.5),
        ],
      ),
      child: Row(
        children: [
          Container(
            child: CarouselWithIndicator(
              room,
              showWaterMark: false,
              onImageTapped: this.onTap,
            ),
          ),
          Expanded(
            child: RoomsInsight(room: this.room),
          ),
        ],
      ),
    );
  }
}

class RoomsInsight extends StatelessWidget {
  final RoomsModel room;
  RoomsInsight({@required this.room});

  final double vgap = 1;
  final double hgap = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ChautariColors.blackAndWhitecolor(),
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
                  "Rs. ${room.price}",
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
  final RoomsModel room;
  ImageCarousel({@required this.room});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
    );
  }
}

class ListRoom extends StatelessWidget {
  final List<RoomsModel> rooms;
  Function onTap;
  ListRoom({@required this.rooms, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Container(
            height: 0,
          );
        },
        itemCount: rooms.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            padding: EdgeInsets.all(ChautariPadding.medium),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (onTap != null) {
                  onTap();
                }
              },
              child: RoomWidget(
                room: this.rooms.elementAt(index),
                onTap: this.onTap,
              ),
            ),
          );
        });
  }
}
