import 'package:chautari/model/room_model.dart';
import 'package:chautari/services/fetch_room_service.dart';
import 'package:chautari/widgets/map/map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomsMapController extends GetxController {
  final ChautariMapController mapController = ChautariMapController();
  Map map;
  FetchRoomService service;

  var _models = List<RoomModel>().obs;
  List<RoomModel> get models => _models.value;

  RoomsMapController() {
    mapController.setZoom(16.0);
    map = Map(title: "Map", controller: mapController);
  }

  var _selectedRoom = RoomModel().obs;

  clearRoomCard() {
    this._selectedRoom.value = RoomModel();
  }

  // List<RoomsModel> get rooms => exploreController.models;
  RoomModel get selectedRoom =>
      _selectedRoom.value.id == null ? null : _selectedRoom.value;

  @override
  void onInit() {
    super.onInit();

    service = Get.find();
    // this._isLoading.value = service.isLoading;
    this._models.assignAll(this.service.rooms);

    // exploreController = Get.find();
  }

  @override
  void onClose() {
    super.onClose();
    print("closing map view");
  }

  setChild(Widget child) {
    map = map.setchild(child);
  }

  onTapMarkerOf(RoomModel room) {
    _selectedRoom.value = room;
  }
}
