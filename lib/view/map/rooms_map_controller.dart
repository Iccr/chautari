import 'dart:async';

import 'package:chautari/model/room_model.dart';
import 'package:chautari/services/room_service.dart';
import 'package:chautari/utilities/marker_generator.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/widgets/map/map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MiddleWare {
  StreamController isRoomMapViewInScreen = new StreamController.broadcast();

  observer(Routing routing) {
    this.isRoomMapViewInScreen.add(routing.current == RouteName.map);
  }
}

class RoomsMapController extends GetxController with StateMixin {
  final ChautariMapController mapController = ChautariMapController();
  Map map;
  RoomService service;

  var models = List.from([]).obs;
  RxSet<Marker> markers = Set<Marker>().obs;
  MarkerGenerator generator;

  var isRendered = false.obs;
  var customMarkersData = List.from([]).obs;

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
    this.models.assignAll(this.service.rooms);
    MiddleWare().isRoomMapViewInScreen.stream.listen((event) {
      if (event) {
        customeMarker();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
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
    print(room);
    _selectedRoom.value = room;
  }

  customeMarker() {
    var _widgets = models
        .map((element) => Container(
              child: Text("val"),
            ))
        .toList();

    MarkerGenerator(_widgets, (listUnit8) {
      var list = listUnit8.map((e) => BitmapDescriptor.fromBytes(e)).toList();

      customMarkersData.assignAll(list);
      getMarkers();
    });
  }

  Set<Marker> getMarkers() {
    var markers = models.map(
      (e) {
        var latlng = LatLng(e.lat, e.long);

        return Marker(
            markerId: MarkerId(
              e.id.toString(),
            ),
            position: latlng,
            onTap: () {
              onTapMarkerOf(e);
            },
            infoWindow: InfoWindow(
              title: "Rs. ${e.price}",
            ),
            icon: BitmapDescriptor.defaultMarker);
      },
    );
    this.markers.assignAll(markers);
  }
}
