import 'package:chautari/model/room_model.dart';

import 'package:chautari/repository/rooms_repository.dart';

import 'package:get/get.dart';

class FetchRoomService extends GetxController {
  var _rooms = List<RoomModel>().obs;
  var _isLoading = false.obs;
  var _error = "".obs;
  bool get isLoading => _isLoading.value;
  String get error => _error.value.isEmpty ? null : _error.value;
  List<RoomModel> get rooms => _rooms.value;

  @override
  onInit() {
    _fetchRooms();
  }

  _fetchRooms() async {
    _isLoading.value = true;
    var models = await RoomsRepository().fetchRooms();

    _isLoading.value = false;
    if (models.errors?.isEmpty ?? false) {
      this._error.value = models.errors?.first?.value;
    } else {
      this._rooms.assignAll(models.rooms);
    }
    update();
  }
}
