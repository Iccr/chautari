import 'package:chautari/model/amenity.dart';
import 'package:chautari/model/parkings.dart';
import 'package:chautari/model/room_model.dart';

import 'package:chautari/repository/rooms_repository.dart';
import 'package:chautari/services/appinfo_service.dart';

import 'package:chautari/view/login/auth_controller.dart';
import 'package:chautari/view/room/my_rooms/my_room_viewmodel.dart';
import 'package:get/get.dart';

class RoomDetailController extends GetxController {
  AuthController auth;
  AppInfoService appIinfoService = Get.find();

  RoomDetailController() {
    auth = Get.find();
  }

  var _room = RoomModel().obs;
  var _error = "".obs;
  var _isLoading = false.obs;

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

  bool get isLoading => _isLoading.value;
  String get error => (_error.value?.isEmpty ?? false) ? null : _error.value;
  RoomModel get room => _room.value.id == null ? null : _room.value;
  bool get availability => _room.value.available;

  @override
  void onInit() {
    super.onInit();
    RoomDetailViewModel viewmodel = Get.arguments;
    this.isMyRoomDetail = viewmodel.isMyRoom;
    _room.value = viewmodel.room;
    _fetchRoomDetail();
    roomDetailHashContent["Type"] = "Appartment";
    roomDetailHashContent["Number Of Rooms"] = "${room.numberOfRooms}";
    roomDetailHashContent["Number Of Bathrooms"] = "${room.numberOfRooms}";
    roomDetailHashContent["Kitchen available"] = "${room.numberOfRooms}";
    roomParkings = [];
  }

  _fetchRoomDetail() async {
    _isLoading.value = true;
    var model = await RoomsRepository().fetchRoomDetail(room.id);
    if (model.errors == null) {
      _room.value = model.room;
    } else {
      _error.value = model.errors.first.value;
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
    model.phone_visibility = room.phone_visibility;
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
