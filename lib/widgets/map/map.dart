import 'package:app_settings/app_settings.dart';
import 'package:chautari/utilities/mapStyles.dart';
import 'package:chautari/utilities/theme/theme_controller.dart';
import 'package:chautari/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class ChautariMapFunctions extends GetxController {
  GoogleMapController _mapController;
  RxBool _isReadyMap = false.obs;
  RxDouble _zoom;
  RxSet<Marker> _markers;
  Rx<CameraPosition> _cameraPosition;
  Rx<Position> position_;

  Set<Marker> markers;
  CameraPosition cameraPosition;

  LatLng selectedPosition;

  setZoom(double val);
  setMap(GoogleMapController controller);
  setMultipleMarker(Set<Marker> markers);
  onTapLocation(LatLng latLng);
  _showPermissionAlert({String title, String message, String textConfirm});
  Future<Position> _determinePosition();
  moveCamera(LatLng latLng);
  setMarker(LatLng latLng);

  setInitialMarker();
  Widget child;
}

class ChautariMapController extends ChautariMapFunctions {
  ThemeController theme = Get.find();
  MapStyles mapStyles = Get.find();

  ChautariMapController() {
    _zoom = 14.4746.obs;
    _cameraPosition =
        CameraPosition(target: LatLng(27.7172, 85.3240), zoom: zoom).obs;
    _markers = Set<Marker>().obs;
    position_ = Position().obs;
  }

  double get zoom => _zoom.value;
  CameraPosition get cameraPosition => _cameraPosition.value;

  Set<Marker> get markers {
    return _markers?.value;
  }

  setZoom(double val) {
    _zoom.value = val;
  }

  @override
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
    _isReadyMap.value = true;

    _mapController.setMapStyle(mapStyles.style);

    theme.themeChanged.listen((_) {
      _mapController.setMapStyle(mapStyles.style);
    });
  }

  RxBool isMapReady() {
    return _isReadyMap ?? false;
  }

  @override
  setMarker(LatLng latLng) {
    var marker = createMarker(latLng);
    Set<Marker> newSet = Set<Marker>();
    newSet.add(marker);
    this._markers.value = newSet;
    moveCamera(latLng);
    // setLatLong(latLng);
  }

  Marker createMarker(LatLng latLng) {
    return Marker(
      markerId: MarkerId("0"),
      position: latLng,
    );
  }

  setMultipleMarker(Set<Marker> markers) {
    this._markers.value = markers;
  }

  @override
  void onInit() async {
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

  @override
  _showPermissionAlert({String title, String message, String textConfirm}) {
    _showPermissionAlert({
      String message = "Service disabled. would you like to enable now?",
    }) {
      Alert.show(
          onConfirm: () {
            AppSettings.openLocationSettings();
            Get.back();
          },
          message: message);
    }
  }
}

class Map {
  MapView mapView;
  String title;
  ChautariMapFunctions controller;

  Map({
    @required this.title,
    ChautariMapFunctions controller,
  }) {
    this.controller = controller;
    this.mapView = MapView(mapController: controller);
  }

  Map setchild(Widget child) {
    mapView.child = child;
    return this;
  }

  Map setOnTapLocation(Function(LatLng) onTapLocation) {
    mapView.onTapLocation = onTapLocation;
    return this;
  }

  Widget build() {
    return mapView;
  }

  Map setMarkers(Set<Marker> markers) {
    controller.setMultipleMarker(markers);
    return this;
  }

  Map setMarkerWithLatLng(LatLng latLng) {
    controller.setMarker(latLng);
    return this;
  }
}

class MapView extends StatelessWidget {
  final ChautariMapFunctions mapController;
  Widget child;
  Function(LatLng) onTapLocation;
  MapView({@required this.mapController, this.child, this.onTapLocation});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: this.mapController.markers,
          mapToolbarEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: this.mapController.cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            this.mapController.setMap(controller);
          },
          onTap: (latLng) {
            if (onTapLocation != null) {
              onTapLocation(latLng);
            }
          },
        ),
        if (child != null) ...[child]
      ],
    );
  }
}
