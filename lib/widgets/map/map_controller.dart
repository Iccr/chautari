import 'dart:collection';

import 'package:chautari/utilities/theme/colors.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app_settings/app_settings.dart';
import 'package:geocoding/geocoding.dart';

class MapController extends GetxController {
  GoogleMapController mapController;

  final double zoom = 14.4746;
  var address = "".obs;

  Rx<CameraPosition> _cameraPosition;

  var _marker = HashSet<Marker>().obs;
  var _position = Position().obs;

  CameraPosition get cameraPosition => _cameraPosition.value;

  Position get position => _position.value;

  HashSet<Marker> get marker {
    var marker = _marker.value;
    print(marker);
    return marker;
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

  Set<Marker> _markers = HashSet<Marker>();
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

  _moveCamera(LatLng latLng) {
    CameraPosition cameraPosition =
        CameraPosition(target: latLng, zoom: this.zoom);
    mapController.moveCamera(
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
    await _getPlaceFrom(latLng);
  }

  setMap(GoogleMapController mapController) {
    this.mapController = mapController;
  }

  onTapLocation(LatLng latLng) {
    _setMarker(latLng);
    _moveCamera(latLng);
  }

  _getPlaceFrom(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    print("name:   ${placemarks.first.name}");
    print("street: ${placemarks.first.street}");
    print("isoCountryCode: ${placemarks.first.isoCountryCode}");
    print("country: ${placemarks.first.country}");

    print("administrativeArea: ${placemarks.first.administrativeArea}");
    print("subAdministrativeArea: ${placemarks.first.subAdministrativeArea}");
    print("locality: ${placemarks.first.locality}");
    print("subLocality: ${placemarks.first.subLocality}");
    print("thoroughfare: ${placemarks.first.thoroughfare}");
    print("subThoroughfare: ${placemarks.first.subThoroughfare}");

    // this.address.value = placemarks.
  }
}
