import 'package:chautari/model/room_model.dart';

import 'package:chautari/repository/rooms_repository.dart';

import 'package:get/get.dart';

class FetchMyRoomService extends GetxController {
  var rooms = List<RoomModel>().obs;
  var isLoading = false.obs;
  var _error = "".obs;

  String get error => _error.value.isEmpty ? null : _error.value;

  fetchMyRooms() async {
    isLoading.value = true;
    var models = await RoomsRepository().fetchMyRooms();
    isLoading.value = false;
    if (models.errors?.isEmpty ?? false) {
      this._error.value = models.errors?.first?.value;
    } else {
      this.rooms.assignAll(models.rooms);
    }
    update();
  }
}
