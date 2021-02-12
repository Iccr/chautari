import 'package:chautari/model/amenity.dart';
import 'package:chautari/model/parkings.dart';
import 'package:chautari/model/room_model.dart';

import 'package:chautari/repository/rooms_repository.dart';
import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/services/delete_room_service.dart';
import 'package:chautari/services/fetch_my_room_service.dart';

import 'package:chautari/view/login/auth_controller.dart';
import 'package:chautari/view/room/my_rooms/my_room_viewmodel.dart';
import 'package:chautari/widgets/alert.dart';
import 'package:get/get.dart';

class RoomDetailController extends GetxController {
  AuthController auth;
  AppInfoService appIinfoService = Get.find();
  DeleteRoomService deleteRoomService;
  FetchMyRoomService myRoomService;

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

  // bool get isMyRoom => room?.id == null ? false : auth.user.id == room.id;
  var isMyRoom = false.obs;

  @override
  void onInit() {
    super.onInit();
    _room = RoomModel().obs;
    RoomDetailViewModel viewmodel = Get.arguments;

    this.isMyRoomDetail = viewmodel.isMyRoom;
    _room.value = viewmodel.room;

    deleteRoomService = DeleteRoomService(room);

    try {
      myRoomService = Get.find();
    } catch (e) {
      myRoomService = Get.put(FetchMyRoomService());
    }

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
      isMyRoom.value = _room.value.user.id == auth.user.id;
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

  delete() async {
    _isLoading.value = deleteRoomService.isLoading.value;
    await this.deleteRoomService.deleteRooms();
    myRoomService.fetchMyRooms();
    if (deleteRoomService.success.value) {
      Get.back();
    } else {
      print(deleteRoomService.error);
    }
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
