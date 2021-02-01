import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/widgets/map/map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationPicker extends StatelessWidget {
  ChautariMapFunctions mapController = Get.put(ChautariMapController());

  Widget _doneButton() {
    return Positioned.fill(
      bottom: 75,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RaisedButton(
          onPressed: () {
            Get.back(result: mapController.selectedPosition);
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
    return Map(
      title: "Pick Location",
      controller: mapController,
    )
        .setOnTapLocation((latLng) => this.mapController.onTapLocation(latLng))
        .setchild(_doneButton())
        .build();
  }
}
