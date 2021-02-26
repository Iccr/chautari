import 'dart:async';

import 'package:chautari/view/room/room_location_map/show_room_location_map_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowRoomLocationMap extends StatelessWidget {
  final ShowRoomLocationMapController controller =
      Get.put(ShowRoomLocationMapController());

  GoogleMapController mapController;

  var _zoom = 14.4746.obs;
  var _cameraPosition =
      CameraPosition(target: LatLng(27.7172, 85.3240), zoom: 14).obs;

  moveCamera(LatLng latLng) {
    CameraPosition cameraPosition =
        CameraPosition(target: latLng, zoom: this._zoom.value);
    this.mapController.moveCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        );
    // (
    //       CameraUpdate.newCameraPosition(cameraPosition),
    //     );
  }

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
          initialCameraPosition: this._cameraPosition.value,
          onMapCreated: (GoogleMapController mapController) {
            this.mapController = mapController;
            this.controller.setMarkers();
            var latLng = LatLng(controller.room.lat, controller.room.long);
            this.moveCamera(latLng);
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
