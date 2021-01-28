import 'package:chautari/widgets/map/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return GetX<MapController>(
      init: MapController(),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text("Map"),
        ),
        body: GoogleMap(
          markers: c.marker,
          myLocationEnabled: true,
          mapType: MapType.hybrid,
          initialCameraPosition: c.cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            mapController.setMap(controller);
          },
          onTap: (latLng) => c.onTapLocation(latLng),
        ),
      ),
    );
  }
}
