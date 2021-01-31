import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/widgets/carousel.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  final RoomsModel room;
  RoomWidget({@required this.room});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ChautariColors.white,
      ),
      child: Column(
        children: [
          CarouselWithIndicator(room),
          RoomsInsight(room: this.room),
        ],
      ),
    );
  }
}

class RoomsInsight extends StatelessWidget {
  final RoomsModel room;
  RoomsInsight({@required this.room});

  final double vgap = 2;
  final double hgap = 10;

  final double padding = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ChautariColors.blackAndWhitecolor(),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: ChautariColors.black.withOpacity(0.24),
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${room.address}, ${room.districtName}, Province: ${room.state}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${room.numberOfRooms}" +
                      " rooms, ${room.parkingCount}" +
                      " parking + ${room.amenityCount} more facilities avalable",
                ),
              ],
            ),
            SizedBox(height: vgap),
            Row(
              children: [
                Row(
                  children: [
                    Text("water: "),
                    Text("${room.water}"),
                  ],
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
  ListRoom({@required this.rooms});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Container(
            height: 5,
          );
        },
        itemCount: rooms.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            child: RoomWidget(
              room: this.rooms.elementAt(index),
            ),
          );
        });
  }
}
