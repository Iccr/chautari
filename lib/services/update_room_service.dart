import 'package:chautari/model/room_model.dart';
import 'package:chautari/repository/rooms_repository.dart';
import 'package:get/get.dart';

class UpdateRoomService extends GetxController {
  var _room = RoomModel().obs;
  var isLoading = false.obs;
  var _error = "".obs;

  String get error => _error.value.isEmpty ? null : _error.value;

  var success = false.obs;

  UpdateRoomService(RoomModel room) {
    this._room.value = room;
  }

  @override
  onInit() {
    super.onInit();
  }

  updateRoom() async {
    isLoading.value = true;
    var models = await RoomsRepository()
        .updateRoom(_room.value.id, await _room.value.toFormData());
    isLoading.value = false;

    if (models.errors?.isEmpty ?? false) {
      this.success.value = false;
      this._error.value = models.errors?.first?.value;
    } else {
      this.success.value = true;
    }
  }

// var newRoom = _clone(room: this.room);
//     newRoom.available = availibiliy;
//     // _isLoading.value = true;
//     var model = await RoomsRepository()
//         .updateRoom(newRoom.id, await newRoom.toFormData());
//     // _isLoading.value = false;
//     if (model.errors != null && model.errors.isNotEmpty) {
//       _error.value = model.errors.first.value;
//     } else {
//       this._room.value = model.room;
//     }
}
