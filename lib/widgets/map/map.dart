import 'dart:async';

import 'package:chautari/widgets/map/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();

  MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: GoogleMap(
        markers: mapController.marker,
        myLocationEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: mapController.cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
