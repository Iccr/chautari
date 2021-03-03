import 'package:chautari/model/room_model.dart';

import 'package:chautari/repository/rooms_repository.dart';

import 'package:get/get.dart';

class RoomService extends GetxService {
  var rooms = <RoomModel>[].obs;
  var myRooms = <RoomModel>[].obs;
  var isLoading = false.obs;
  var _error = "".obs;
  String get error => _error.value.isEmpty ? null : _error.value;
  var success = false.obs;

  var _selectedRoom = RoomModel().obs;

  Future<RoomService> init() async {
    return this;
  }

  fetchRooms() async {
    isLoading.value = true;

    var models = await RoomsRepository().fetchRooms();

    isLoading.value = false;
    if (models.errors.isEmpty ?? false) {
      this.rooms.assignAll(models.rooms);
    } else {
      this._error.value = models.errors.first?.value;
    }
  }

  searchAddress({String address}) async {
    Map<String, dynamic> params = Map<String, dynamic>();

    params["address"] = address;

    this.search(params);
  }

  search(Map<String, dynamic> params) async {
    isLoading.value = true;

    var models = await RoomsRepository().searchRoom(params);

    isLoading.value = false;
    if (models.errors.isEmpty ?? false) {
      this.rooms.assignAll(models.rooms);
    } else {
      this._error.value = models.errors.first?.value;
    }
  }

  deleteRooms(RoomModel room) async {
    isLoading.value = true;
    var models = await RoomsRepository().deleteRoom(room.id);
    isLoading.value = false;

    if (models.errors.isNotEmpty) {
      this.success.value = false;
      this._error.value = models.errors?.first?.value;
    } else {
      this.success.value = true;
    }
  }

  fetchMyRooms() async {
    isLoading.value = true;
    var models = await RoomsRepository().fetchMyRooms();
    isLoading.value = false;
    if (models.errors?.isEmpty ?? false) {
      this.myRooms.assignAll(models.rooms);
    } else {
      this._error.value = models.errors.first?.value;
    }
    // update();
  }

  updateRoom(RoomModel room) async {
    isLoading.value = true;
    var models =
        await RoomsRepository().updateRoom(room.id, await room.toFormData());
    isLoading.value = false;

    if (models.errors.isEmpty ?? false) {
      this.success.value = true;
    } else {
      this.success.value = false;
      this._error.value = models.errors?.first?.value;
    }
  }
}
