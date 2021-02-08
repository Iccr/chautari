import 'dart:collection';

import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/alert.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';
import 'package:app_settings/app_settings.dart';

class MapController extends GetxController {
  AddRoomController addController = Get.find();

  GoogleMapController mapController;
  final double zoom = 14.4746;

  // observables

  Rx<CameraPosition> _cameraPosition;
  var _marker = HashSet<Marker>().obs;
  var _position = Position().obs;

// getters
  CameraPosition get cameraPosition => _cameraPosition.value;
  Position get position => _position.value;

  HashSet<Marker> get marker => _marker.value;

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

  _showPermissionAlert({
    String message = "Service disabled. would you like to enable now?",
  }) {
    Alert.show(
        message: message, onConfirm: () => AppSettings.openLocationSettings());
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // return Future.error('Location services are disabled.');
      _showPermissionAlert();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      _showPermissionAlert();
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        _showPermissionAlert();
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
