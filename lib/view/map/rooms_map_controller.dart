import 'dart:async';
import 'dart:typed_data';

import 'package:chautari/model/room_model.dart';
import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/services/room_service.dart';
import 'package:chautari/utilities/marker_generator.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/widgets/map/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:ui' as ui;

class RoomsMapController extends GetxController with StateMixin {
  final ChautariMapController mapController = ChautariMapController();
  AppInfoService appInfoService = Get.find();
  Map map;
  RoomService service;
  RxList<Widget> iconsWidgets = <Widget>[].obs;
  var models = <RoomModel>[].obs;
  RxSet<Marker> markers = Set<Marker>().obs;
  MarkerGenerator generator;

  var renderingDone = false.obs;

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
    var rooms = this.service.rooms;
    getIcons(rooms);
    this.models.assignAll(rooms);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setChild(Widget child) {
    map = map.setchild(child);
  }

  onTapMarkerOf(RoomModel room) {
    _selectedRoom.value = room;
  }

  List<Widget> getIcons(List<RoomModel> rooms) {
    var _iconsWidgets = rooms.map((element) {
      return RepaintBoundary(
        key: GlobalKey(),
        child: ClipOval(
          child: Container(
            color: getColor(element.type),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      style: ChautariTextStyles()
                          .listTitle
                          .copyWith(fontSize: 12, color: Colors.white),
                      children: [
                        TextSpan(text: element.getShortPriceString()),
                        TextSpan(
                            text: "k",
                            style: ChautariTextStyles()
                                .listSubtitle
                                .copyWith(fontSize: 10.5, color: Colors.white)),
                      ]),
                ),
              ],
            ),
            height: 45,
            width: 45,
          ),
        ),
      );
    }).toList();
    this.iconsWidgets.assignAll(_iconsWidgets);
  }

  List<Widget> getInsightText() {
    var wids = appInfoService.appInfo.types
        .map(
          (e) => Row(
            children: [
              ClipOval(
                child: Container(
                  height: 10,
                  width: 10,
                  color: getColor(e.value),
                ),
              ),
              SizedBox(
                width: ChautariPadding.small5,
              ),
              Text(
                e.name,
                style: ChautariTextStyles().listTitle.copyWith(
                    color: ChautariColors.black,
                    fontSize: 12,
                    fontStyle: FontStyle.normal),
              ),
            ],
          ),
        )
        .toList();

    return wids;
  }

  getColor(int type) {
    // %RoomTypes{name: "Appartment", value: 0},
    //   %RoomTypes{name: "Room", value: 1},
    //   %RoomTypes{name: "Flat", value: 2},
    //   %RoomTypes{name: "Hostel", value: 3},
    //   %RoomTypes{name: "Shutter", value: 4},
    //   %RoomTypes{name: "Office", value: 5},
    //   %RoomTypes{name: "Commercial", value: 6}

    switch (type) {
      case 0:
        // appartment
        return ChautariColors.green;
        break;
      case 1:
        // room
        return ChautariColors.indigo;
        break;
      case 2:
        // flat
        return ChautariColors.tabYellow;
        break;
      case 3:
        // hostel
        return ChautariColors.teal;
        break;
      case 4:
        // shutter
        return ChautariColors.brown;
        break;
      case 5:
        // office
        return ChautariColors.purple;
        break;
      case 6:
        // commercial
        return ChautariColors.blueGrey;
        break;

      default:
        // others
        return ChautariColors.cyan;
    }
  }

  String getRoundedPriceString(String price) {
    var _price = "${(double.parse(price) / 1000).toStringAsFixed(1)}k";
    if (_price.split(".").last == "0k") {
      var _price = "${(double.parse(price) / 1000).toStringAsFixed(0)}k";
      return _price;
    } else {
      return _price;
    }
    // int decimals = 2;
    // int fac = pow(10, decimals);
    // double d = double.parse(price);
    // d = (d * fac).round() / fac;
    // return "$d";
  }

  getMarkers() async {
    // await Future.delayed(Duration(seconds: 1));

    var result = await Future.wait(
      iconsWidgets.map(
        (element) {
          return getCustomIcon(element.key);
        },
      ),
    );

    this.models.asMap().forEach(
      (index, e) {
        var latlng = LatLng(e.lat, e.long);
        var maker = Marker(
          markerId: MarkerId(
            e.id.toString(),
          ),
          position: latlng,
          onTap: () {
            onTapMarkerOf(e);
          },
          // infoWindow: InfoWindow(
          //   title: "Rs. ${e.price}",
          // ),
          icon: result.elementAt(index),
        );
        this.markers.add(maker);
      },
    );
    // return this.markers.value;
    this.renderingDone.value = true;
  }

  // Set<Marker> getMarkers() {
  //   models.forEach(
  //     (e) {
  //       var latlng = LatLng(e.lat, e.long);

  //       var marker = Marker(
  //         markerId: MarkerId(
  //           e.id.toString(),
  //         ),
  //         position: latlng,
  //         onTap: () {
  //           onTapMarkerOf(e);
  //         },
  //         infoWindow: InfoWindow(
  //           title: "Rs. ${e.price}",
  //         ),
  //         icon: BitmapDescriptor.defaultMarker,
  //       );
  //       this.markers.add(marker);
  //     },
  //   );
  //   return this.markers.value;
  // }

  Future<BitmapDescriptor> getCustomIcon(GlobalKey iconKey) async {
    Future<Uint8List> _capturePng(GlobalKey iconKey) async {
      try {
        RenderRepaintBoundary boundary =
            iconKey.currentContext.findRenderObject();

        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        var pngBytes = byteData.buffer.asUint8List();
        return pngBytes;
      } catch (e) {}
    }

    Uint8List imageData = await _capturePng(iconKey);
    return BitmapDescriptor.fromBytes(imageData);
  }
}
