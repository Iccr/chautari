import 'package:chautari/model/rooms_model.dart';
import 'package:flutter/material.dart';

class RoomListWidget extends StatelessWidget {
  final List<RoomsModel> rooms;
  RoomListWidget({@required this.rooms});

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

class RoomWidget extends StatelessWidget {
  final RoomsModel room;
  RoomWidget({@required this.room});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Container(
            height: 300,
          ),
          ImageCarousel(room: room),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              child: RoomsInsight(room: this.room),
            ),
          )
        ],
      ),
    );
  }
}

// "address": "satdobato",
//             "amenity_count": 3,
//             "available": true,
//             "district_name": "Arghakhanchi",
//             "id": 1,
//             "lat": "27.7172",
//             "long": "85.3240",
//             "number_of_rooms": 1,
//             "parking_count": 1,
//             "price": "3000",
//             "state": 5,
//             "water": "Enough for small family"

class RoomsInsight extends StatelessWidget {
  final RoomsModel room;
  RoomsInsight({@required this.room});

  double vgap = 2;
  double hgap = 10;

  double padding = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        padding: EdgeInsets.all(padding),
        margin: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${room.address}, ${room.districtName}, state: ${room.state}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            SizedBox(height: vgap),
            Text(
              "Rs ${room.price} / month",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: vgap),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("${room.numberOfRooms}" +
                    " rooms, ${room.parkingCount}" +
                    " parking, ${room.amenityCount} facilities avalable"),
              ],
            ),
            SizedBox(height: vgap),
            Row(
              children: [
                Text("water ${room.water}"),
              ],
            ),
            SizedBox(height: vgap),
            Text("3 days ago", style: TextStyle(color: Colors.grey)),
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
      height: 200,
      color: Colors.yellow,
    );
  }
}
