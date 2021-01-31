import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';

import 'package:chautari/widgets/map/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  MapController mapController = Get.put(MapController());
  final AddRoomController addController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetX<MapController>(
      init: MapController(),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text("Map"),
        ),
        body: Stack(
          children: [
            GoogleMap(
              markers: c.marker,
              myLocationEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: c.cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                mapController.setMap(controller);
              },
              onTap: (latLng) => c.onTapLocation(latLng),
            ),
            Positioned.fill(
              bottom: 75,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Done",
                    style: ChautariTextStyles()
                        .listTitle
                        .copyWith(color: ChautariColors.white),
                  ),
                  color: ChautariColors.primaryColor(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
