import 'package:app_settings/app_settings.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_style.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class ChautariMapFunctions extends GetxController {
  GoogleMapController _mapController;
  double _zoom;
  RxSet<Marker> _markers;
  Rx<CameraPosition> _cameraPosition;
  Rx<Position> position_;

  Set<Marker> markers;
  CameraPosition cameraPosition;

  LatLng selectedPosition;

  setMap(GoogleMapController controller);
  onTapLocation(LatLng latLng);
  _showPermissionAlert({String title, String message, String textConfirm});
  Future<Position> _determinePosition();
  moveCamera(LatLng latLng);
  setMarker(LatLng latLng);
  setInitialMarker();
  Widget child;
}

class ChautariMapController extends ChautariMapFunctions {
  double get zoom => _zoom;
  CameraPosition get cameraPosition => _cameraPosition.value;

  Set<Marker> get markers {
    print(_markers.value);
    return _markers.value;
  }

  @override
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

  @override
  moveCamera(LatLng latLng) {
    CameraPosition cameraPosition =
        CameraPosition(target: latLng, zoom: this.zoom);
    this._mapController?.moveCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        );
  }

  @override
  onTapLocation(LatLng latLng) {
    this.selectedPosition = latLng;
    this.setMarker(latLng);
    this.moveCamera(latLng);
  }

  @override
  setMap(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  setMarker(LatLng latLng) {
    var marker = Marker(
      markerId: MarkerId("0"),
      position: latLng,
    );
    Set<Marker> newSet = Set<Marker>();
    newSet.add(marker);
    this._markers.assignAll(newSet);
    moveCamera(latLng);
    // setLatLong(latLng);
  }

  @override
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

  @override
  void onInit() async {
    _zoom = 14.4746;
    _cameraPosition =
        CameraPosition(target: LatLng(27.7172, 85.3240), zoom: zoom).obs;
    _markers = Set<Marker>().obs;
    super.onInit();
    position_.value = await _determinePosition();
  }

  setInitialMarker() async {
    if (position_.value.latitude == null) {
      var currentPosition = await _determinePosition();
      setMarker(
        LatLng(currentPosition.latitude, currentPosition.longitude),
      );
    }
  }
}

class Map {
  Widget _mapView;
  Widget child;
  String _title;
  ChautariMapFunctions _controller;

  Map({@required String title, ChautariMapFunctions controller, this.child}) {
    _controller = controller ?? Get.put(ChautariMapController());
    _title = title;
  }

  Widget getLocationPicker() {
    _mapView = MapView(
      mapController: _controller,
      title: _title,
      child: child,
    );
    return _mapView;
  }
}

class MapView extends StatelessWidget {
  ChautariMapFunctions mapController = Get.put(ChautariMapController());
  final String title;
  Widget child;
  MapView({@required this.mapController, @required this.title, this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? "Map"),
      ),
      body: Obx(
        () => Stack(
          children: [
            GoogleMap(
              markers: this.mapController.markers,
              myLocationEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: this.mapController.cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                this.mapController.setMap(controller);
              },
              onTap: (latLng) => this.mapController.onTapLocation(latLng),
            ),
            if (child != null) ...[child]
            // Positioned.fill(
            //   bottom: 75,
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: RaisedButton(
            //       onPressed: () {
            //         Get.back(result: mapController.selectedPosition);
            //       },
            //       child: Text(
            //         "Done",
            //         style: ChautariTextStyles()
            //             .listTitle
            //             .copyWith(color: ChautariColors.white),
            //       ),
            //       color: ChautariColors.primaryColor(),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
