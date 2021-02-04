import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/view/explore/explore_controller.dart';
import 'package:chautari/widgets/map/map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomsMapController extends GetxController {
  ExploreController exploreController;
  final ChautariMapController mapController = ChautariMapController();
  Map map;

  RoomsMapController() {
    mapController.setZoom(16.0);
    map = Map(title: "Map", controller: mapController);
  }

  var _selectedRoom = RoomsModel().obs;

  clearRoomCard() {
    this._selectedRoom.value = RoomsModel();
  }

  List<RoomsModel> get rooms => exploreController.models;
  RoomsModel get selectedRoom =>
      _selectedRoom.value.id == null ? null : _selectedRoom.value;

  @override
  void onInit() {
    super.onInit();
    exploreController = Get.find();
  }

  @override
  void onClose() {
    super.onClose();
    print("closing map view");
  }

  setChild(Widget child) {
    map = map.setchild(child);
  }

  onTapMarkerOf(RoomsModel room) {
    _selectedRoom.value = room;
  }
}
