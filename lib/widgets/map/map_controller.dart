import 'dart:collection';

import 'package:chautari/utilities/theme/colors.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app_settings/app_settings.dart';

class MapController extends GetxController {
  final _cameraPosition = CameraPosition(
    target: LatLng(27.7172, 85.3240),
    zoom: 14.4746,
  ).obs;

  var _marker = HashSet<Marker>().obs;
  var _position = Position().obs;

  CameraPosition get cameraPosition => _cameraPosition.value;

  Position get position => _position.value;

  HashSet<Marker> get marker => _marker.value;

  _showPermissionAlert({String title, String message, String textConfirm}) {
    Get.defaultDialog(
        title: title,
        middleText: message,
        textConfirm: textConfirm,
        confirmTextColor: ChautariColors.blackAndWhitecolor(),
        onConfirm: () async {
          AppSettings.openLocationSettings();
          Get.back();
        },
        onCancel: () => {Get.back()});
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // return Future.error('Location services are disabled.');
      _showPermissionAlert(
        message: "Service disabled. would you like to enable now?",
        textConfirm: "Ok",
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      _showPermissionAlert(
        message: "Service disabled. would you like to enable now?",
        textConfirm: "Ok",
      );
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        _showPermissionAlert(
          message: "Service disabled. would you like to enable now?",
          textConfirm: "Ok",
        );
      }
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Set<Marker> _markers = HashSet<Marker>();
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var position = await _determinePosition();
    _setMarkers(position);

    // var currentPosition =
  }

  _setMarkers(Position position) {
    var marker = Marker(
      markerId: MarkerId("0"),
      position: LatLng(
        position.latitude,
        position.longitude,
      ),
    );
    HashSet<Marker> newSet = HashSet<Marker>();
    newSet.add(marker);
    this._marker.value = newSet;
  }
}
