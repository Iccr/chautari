import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class MapController extends GetxController {


  final _cameraPosition = CameraPosition(
    target: LatLng(27.7172, 85.3240),
    zoom: 14.4746,
  );


@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    var currentPosition = 
  }

}
