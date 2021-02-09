import 'package:chautari/model/room_model.dart';
import 'package:chautari/widgets/map/map.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowRoomLocationMapController extends GetxController {
  ChautariMapController mapController;
  Map map;

  RoomModel room;
  // RxBool isMapReady;

  ShowRoomLocationMapController() {
    mapController = ChautariMapController();
    mapController.setZoom(16.0);
    Map map;
  }

  LatLng get roomLatLng => LatLng(room.lat, room.long);

  @override
  void onInit() {
    super.onInit();
    room = Get.arguments;

    try {
      mapController = Get.find();
    } catch (e) {
      mapController = Get.put(ChautariMapController());
    }

    map = Map(title: "Map", controller: mapController);
    mapController.isMapReady().listen((ready) {
      if (ready) {
        map.setMarkerWithLatLng(roomLatLng);
      }
    });
  }
}
