import 'package:chautari/model/room_model.dart';
import 'package:chautari/repository/rooms_repository.dart';
import 'package:get/get.dart';

class DeleteRoomService extends GetxController {
  var _room = RoomModel().obs;
  var isLoading = false.obs;
  var _error = "".obs;

  String get error => _error.value.isEmpty ? null : _error.value;

  var success = false.obs;

  DeleteRoomService(RoomModel room) {
    this._room.value = room;
  }
  @override
  onInit() {
    super.onInit();
  }

  deleteRooms() async {
    isLoading.value = true;
    var models = await RoomsRepository().deleteRoom(_room.value.id);
    isLoading.value = false;

    if (models.errors?.isEmpty ?? false) {
      this.success.value = false;
      this._error.value = models.errors?.first?.value;
    } else {
      this.success.value = true;
    }
  }
}
