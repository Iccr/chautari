import 'package:chautari/model/room_model.dart';

import 'package:chautari/repository/rooms_repository.dart';

import 'package:get/get.dart';

class DeleteRoomService extends GetxController {
  var _room = RoomModel().obs;
  var _isLoading = false.obs;
  var _error = "".obs;
  bool get isLoading => _isLoading.value;
  String get error => _error.value.isEmpty ? null : _error.value;

  var _success = false.obs;
  bool get deleteSuccess => this._success.value;

  DeleteRoomService(RoomModel room) {
    this._room.value = room;
  }
  @override
  onInit() {
    super.onInit();
  }

  deleteRooms() async {
    _isLoading.value = true;
    var models = await RoomsRepository().deleteRoom(_room.value.id);
    _isLoading.value = false;

    if (models.errors?.isEmpty ?? false) {
      this._success.value = false;
      this._error.value = models.errors?.first?.value;
    } else {
      this._success.value = true;
    }
  }
}
