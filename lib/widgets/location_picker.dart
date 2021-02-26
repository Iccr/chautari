import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/widgets/location_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPicker extends StatelessWidget {
  LocationPickerController mapController = Get.put(LocationPickerController());

  Widget _doneButton() {
    return Positioned.fill(
      bottom: 75,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RaisedButton(
          onPressed: () {
            Get.back(result: mapController.selectedPosition.value);
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pick Location")),
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              markers: this.mapController.markers.value,
              mapToolbarEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: mapController.cameraPosition.value,
              onMapCreated: (GoogleMapController controller) {
                mapController.mapController = controller;
              },
              onTap: (latLng) {
                mapController.onTapLocation(latLng);
              },
            ),
          ),
          _doneButton(),
        ],
      ),
    );
  }
  // return Map(
  //   title: "Pick Location",
  //   controller: mapController,
  // )
  //     .setOnTapLocation((latLng) => this.mapController.onTapLocation(latLng))
  //     .setchild(_doneButton())
  //     .build();
}
