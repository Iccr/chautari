import 'package:chautari/model/room_model.dart';
import 'package:chautari/repository/rooms_repository.dart';
import 'package:get/get.dart';

class UpdateRoomService extends GetxController {
  var _room = RoomModel().obs;
  var _isLoading = false.obs;
  var _error = "".obs;
  bool get isLoading => _isLoading.value;
  String get error => _error.value.isEmpty ? null : _error.value;
  RoomModel get room => _room.value;

  @override
  onInit() {
    _updateRooms();
  }

  _updateRooms() async {
    var params = await room.toFormData();
    _isLoading.value = true;
    var models =
        await RoomsRepository().updateRoom(id: room.id, params: params);

    _isLoading.value = false;
    if (models.errors?.isEmpty ?? false) {
      this._room.value = models.room;
    } else {
      this._error.value = models.errors?.first?.value;
    }
    update();
  }
}
