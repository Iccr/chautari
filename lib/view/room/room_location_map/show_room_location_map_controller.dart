import 'package:chautari/model/room_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowRoomLocationMapController extends GetxController {
  GoogleMapController mapController;
  RoomModel room;

  var _zoom = 14.4746.obs;

  var ready = false.obs;

  var cameraPosition =
      CameraPosition(target: LatLng(27.7172, 85.3240), zoom: 14).obs;

  var markers = Set<Marker>().obs;

  setMarker() {
    LatLng latLng = LatLng(room.lat, room.long);
    var marker = createMarker(latLng);
    Set<Marker> newSet = Set<Marker>();
    newSet.add(marker);
    this.markers.value = newSet;
  }

  Marker createMarker(LatLng latLng) {
    return Marker(
      markerId: MarkerId("0"),
      position: latLng,
    );
  }

  moveCamera(LatLng latLng) {
    CameraPosition cameraPosition =
        CameraPosition(target: latLng, zoom: this._zoom.value);
    this.mapController.moveCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        );
  }

  LatLng get roomLatLng => LatLng(room.lat, room.long);

  @override
  void onInit() {
    super.onInit();
    room = Get.arguments;
  }

  setMarkers() {
    setMarker();
  }
}
