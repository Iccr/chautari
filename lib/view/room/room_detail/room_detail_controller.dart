import 'package:chautari/model/amenity.dart';
import 'package:chautari/model/parkings.dart';
import 'package:chautari/model/rooms_model.dart';

import 'package:chautari/repository/rooms_repository.dart';
import 'package:get/get.dart';

class RoomDetailController extends GetxController {
  var _room = RoomsModel().obs;
  var _error = "".obs;
  var _isLoading = false.obs;

  List<String> roomParkings = List<String>();
  List<String> roomAmenities = List<String>();
  Map<String, String> roomDetailHashContent = Map<String, String>();

  // getters
  RoomsModel get room => _room.value.id == null ? null : _room.value;
  List<Parking> get parkings =>
      _room.value.parkings == null ? [] : _room.value.parkings;
  List<Amenities> get amenities =>
      _room.value.amenities == null ? [] : _room.value.amenities;
  bool get isLoading => _isLoading.value;
  String get error => (_error.value?.isEmpty ?? false) ? null : _error.value;

  List<String> get water => [_room.value.water];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _room.value = Get.arguments;
    _fetchRoomDetail();
    roomDetailHashContent["Type"] = "Appartment";
    roomDetailHashContent["Number Of Rooms"] = "${room.numberOfRooms}";
    roomDetailHashContent["Number Of Bathrooms"] = "${room.numberOfRooms}";
    roomDetailHashContent["Kitchen available"] = "${room.numberOfRooms}";

    // roomParkings = ["Bike", "Car", "Jeep"];
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
}
