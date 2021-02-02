import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/repository/rooms_repository.dart';
import 'package:get/get.dart';

class RoomDetailController extends GetxController {
  RoomsModel _room;

  var _isLoading = false.obs;

  // getters
  RoomsModel get room => _room;
  bool get isLoading => _isLoading.value;

  Map<String, String> roomDetailHashContent = Map<String, String>();
  List<String> roomParkings = List<String>();
  List<String> roomAmenities = List<String>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _room = Get.arguments;
    print("roomdetail: $_room");

    roomDetailHashContent["Type"] = "Appartment";
    roomDetailHashContent["Number Of Rooms"] = "${room.numberOfRooms}";
    roomDetailHashContent["Number Of Bathrooms"] = "${room.numberOfRooms}";
    roomDetailHashContent["Kitchen available"] = "${room.numberOfRooms}";
    roomDetailHashContent["Water"] = "${room.water}";

    roomParkings = ["Bike", "Car", "Jeep"];
  }

  _fetchRoomDetail() {
    RoomsRepository()
  }
}
