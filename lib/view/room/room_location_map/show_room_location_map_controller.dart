import 'package:chautari/model/room_model.dart';
import 'package:chautari/widgets/map/map.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowRoomLocationMapController extends GetxController {
  ChautariMapController mapController;

  RoomModel room;
  // RxBool isMapReady;

  var ready = false.obs;

  var markers = Set<Marker>().obs;

  ShowRoomLocationMapController() {
    // mapController = ChautariMapController();
    // mapController.setZoom(16.0);
  }

  setMarker() {
    LatLng latLng = LatLng(room.lat, room.long);
    var marker = createMarker(latLng);
    Set<Marker> newSet = Set<Marker>();
    newSet.add(marker);
    this.markers.value = newSet;
    // moveCamera(latLng);
    // setLatLong(latLng);
  }

  Marker createMarker(LatLng latLng) {
    return Marker(
      markerId: MarkerId("0"),
      position: latLng,
    );
  }

  LatLng get roomLatLng => LatLng(room.lat, room.long);

  @override
  void onInit() {
    super.onInit();
    room = Get.arguments;

    // try {
    //   mapController = Get.find();
    // } catch (e) {
    //   mapController = Get.put(ChautariMapController());
    // }}
  }

  setMarkers() {
    setMarker();
  }
}
