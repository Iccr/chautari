import 'package:chautari/model/amenity.dart';
import 'package:chautari/model/parkings.dart';
import 'package:chautari/model/room_model.dart';

import 'package:chautari/repository/rooms_repository.dart';
import 'package:chautari/services/appinfo_service.dart';

import 'package:chautari/services/room_service.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/chats/chat_view.dart';

import 'package:chautari/view/login/auth_controller.dart';
import 'package:chautari/view/login/login_view.dart';
import 'package:chautari/view/room/my_rooms/my_room_viewmodel.dart';
import 'package:chautari/widgets/alert.dart';
import 'package:chautari/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RoomDetailController extends GetxController {
  AuthController auth;
  AppInfoService appIinfoService = Get.find();
  RoomService roomService;

  RoomDetailController() {
    auth = Get.find();
  }

  Rx<RoomModel> _room;
  var _error = "".obs;
  var _isLoading = false.obs;

  var _statusMessage = "".obs;

  List<String> roomParkings = List<String>();
  List<String> roomAmenities = List<String>();
  Map<String, String> roomDetailHashContent = Map<String, String>();
  var isMyRoomDetail = false;

  // getters

  List<Parking> get parkings =>
      _room.value.parkings == null ? [] : _room.value.parkings;
  List<Amenities> get amenities =>
      _room.value.amenities == null ? [] : _room.value.amenities;
  List<String> get water => [
        appIinfoService.appInfo.waters
            .firstWhere((e) => e.value == _room.value.water)
            .name
      ];

  String get statusMessage =>
      _room.value.available ? "Available for rent" : "Not Available For Rent";
  bool get isLoading => _isLoading.value;
  String get error => (_error.value?.isEmpty ?? false) ? null : _error.value;
  RoomModel get room => _room.value.id == null ? null : _room.value;
  bool get availability => _room.value.available;

  @override
  void onInit() {
    super.onInit();
    _setup();
    _setupRoomService();
    _fetchRoomDetail();
    _fillRoomDetailHash();
    roomParkings = [];
  }

  @override
  onClose() async {
    // await ChautariSnackBar.remove(Get.context);
    super.onClose();
  }

  _setup() {
    _room = RoomModel().obs;
    RoomDetailViewModel viewmodel = Get.arguments;
    this.isMyRoomDetail = viewmodel.isMyRoom;
    _room.value = viewmodel.room;
  }

  _setupRoomService() {
    try {
      roomService = Get.find();
    } catch (e) {
      roomService = Get.put(RoomService());
    }
  }

  _fillRoomDetailHash() {
    roomDetailHashContent["Type"] = "Appartment";
    roomDetailHashContent["Number Of Rooms"] = "${room.numberOfRooms}";
    roomDetailHashContent["Number Of Bathrooms"] = "${room.numberOfRooms}";
    roomDetailHashContent["Kitchen available"] = "${room.numberOfRooms}";
  }

  _fetchRoomDetail() async {
    _isLoading.value = true;
    var model = await RoomsRepository().fetchRoomDetail(room.id);
    if (model.errors == null) {
      _room.value = model.room;
    } else {
      _error.value = model.errors.first.value;
      // Get.showSnackbar(_error.value);
      // Get.snackbar("Warning", _error.value);

      // ChautariSnackBar.showNoInternetMesage(_error.value);
    }

    _isLoading.value = false;
  }

  updateRoomAvailability(bool availibiliy) async {
    var newRoom = _clone(room: this.room);
    newRoom.available = availibiliy;
    // _isLoading.value = true;
    var model = await RoomsRepository()
        .updateRoom(newRoom.id, await newRoom.toFormData());
    // _isLoading.value = false;
    if (model.errors != null && model.errors.isNotEmpty) {
      _error.value = model.errors.first.value;
    } else {
      this._room.value = model.room;
    }
  }

  delete() async {
    _isLoading.value = roomService.isLoading.value;

    await this.roomService.deleteRooms(room);
    roomService.fetchMyRooms();
    if (roomService.success.value) {
      Get.back();
    } else {
      print(roomService.error);
    }
  }

  goToChat() {
    if (auth.isLoggedIn && FirebaseAuth.instance.currentUser != null) {
      var viewModel = ChatViewModel(
        peerId: room.user.fuid,
        peerPhoto: room.user.imageurl,
        peerName: room.user.name,
      );
      Get.toNamed(RouteName.chat, arguments: viewModel);
    } else {
      goToLogin();
    }
  }

  goToLogin() async {
    await showCupertinoModalBottomSheet(
      expand: true,
      context: Get.context,
      backgroundColor: Colors.transparent,
      builder: (context) => LoginView(),
    );
  }

  goToUpdate() {}

  askForPermissionToDelete() async {
    Alert.show(
        message:
            "This action will remove all data related to this room from chautari bast. It cannot be undone. Are your sure?",
        onConfirm: () async {
          Get.back();
          delete();
        });
  }

  RoomModel _clone({RoomModel room}) {
    var model = RoomModel();
    model.address = room.address;
    model.amenityCount = room.amenityCount;
    model.available = room.available;
    model.districtName = room.districtName;
    model.id = room.id;
    model.lat = room.lat;
    model.long = room.long;
    model.numberOfRooms = room.numberOfRooms;
    model.parkingCount = room.parkingCount;
    model.price = room.price;
    model.state = room.state;
    model.water = room.water;
    model.type = room.type;
    model.phone = room.phone;
    model.phoneVisibility = room.phoneVisibility;
    model.images = room.images;
    model.postedOn = room.postedOn;
    model.parkings = room.parkings;
    model.amenities = room.amenities;
    model.district = room.district;
    model.user = room.user;
    model.rawImages = room.rawImages;
    return model;
  }
}
