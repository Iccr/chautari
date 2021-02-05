import 'package:chautari/model/amenity.dart';
import 'package:chautari/model/parkings.dart';
import 'package:chautari/model/room_model.dart';

import 'package:chautari/repository/rooms_repository.dart';
import 'package:chautari/services/update_room_availability_service.dart';

import 'package:chautari/view/login/auth_controller.dart';
import 'package:chautari/view/room/my_rooms/my_room_viewmodel.dart';
import 'package:get/get.dart';

class RoomDetailController extends GetxController {
  UpdateRoomService updateRoomService;
  AuthController auth;

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
  List<String> get water => [_room.value.water];

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

  updateRoomAvailability(bool availibiliy) {
    var newRoom = RoomModel.fromJson(room.toJson());
    newRoom.available = availibiliy;
    this._room.value = newRoom;
  }
}
