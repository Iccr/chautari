import 'dart:collection';

import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/view/add_property/add_property_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';
import 'package:app_settings/app_settings.dart';

class MapController extends GetxController {
  AddPropertyController addController = Get.find();

  GoogleMapController mapController;
  final double zoom = 14.4746;

  // observables

  var _address = "".obs;
  Rx<CameraPosition> _cameraPosition;
  var _marker = HashSet<Marker>().obs;
  var _position = Position().obs;

  var _shouldShowAddressWidget = false.obs;

// getters
  CameraPosition get cameraPosition => _cameraPosition.value;
  bool get shouldShowAddressWidget => _shouldShowAddressWidget.value;

  Position get position => _position.value;

  HashSet<Marker> get marker {
    var marker = _marker.value;
    return marker;
  }

  // life cycle
  @override
  void onInit() async {
    super.onInit();
    _cameraPosition =
        CameraPosition(target: LatLng(27.7172, 85.3240), zoom: zoom).obs;
    var position = await _determinePosition();
    _setMarker(
      LatLng(position.latitude, position.longitude),
    );
  }

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

  _moveCamera(LatLng latLng) {
    CameraPosition cameraPosition =
        CameraPosition(target: latLng, zoom: this.zoom);
    mapController?.moveCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  _setMarker(LatLng latLng) async {
    var marker = Marker(
      markerId: MarkerId("0"),
      position: latLng,
    );
    HashSet<Marker> newSet = HashSet<Marker>();
    newSet.add(marker);
    this._marker.value = newSet;
    _moveCamera(latLng);
    _setLatLong(latLng);
  }

  setMap(GoogleMapController mapController) {
    this.mapController = mapController;
  }

  onTapLocation(LatLng latLng) {
    _setMarker(latLng);
    _moveCamera(latLng);
  }

  _setLatLong(LatLng latLng) {
    addController.setLatLng(latLng.latitude, latLng.longitude);
  }
}
