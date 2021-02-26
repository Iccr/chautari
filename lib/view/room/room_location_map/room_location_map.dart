import 'dart:async';

import 'package:chautari/view/room/room_location_map/show_room_location_map_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowRoomLocationMap extends StatelessWidget {
  final ShowRoomLocationMapController controller =
      Get.put(ShowRoomLocationMapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map")),
      body: Obx(
        () => GoogleMap(
          markers: this.controller.markers.value,
          mapToolbarEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: controller.cameraPosition.value,
          onMapCreated: (GoogleMapController mapController) {
            controller.setMap(mapController);
            // controller.mapController = mapController;
            controller.setMarkers();
            var latLng = LatLng(controller.room.lat, controller.room.long);
            controller.moveCamera(latLng);
          },
          onTap: (latLng) {
            // if (onTapLocation != null) {
            //   onTapLocation(latLng);
            // }
          },
        ),
      ),
    );
  }
}
