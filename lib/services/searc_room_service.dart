import 'package:chautari/model/room_model.dart';

import 'package:chautari/repository/rooms_repository.dart';

import 'package:get/get.dart';

class SearchRoomService extends GetxController {
  var rooms = List<RoomModel>().obs;
  var isLoading = false.obs;
  var _error = "".obs;
  String get error => _error.value.isEmpty ? null : _error.value;

  search({String address}) async {
    Map<String, dynamic> params = Map<String, dynamic>();

    params["address"] = address;

    isLoading.value = true;

    var models = await RoomsRepository().searchRoom(params);

    isLoading.value = false;
    if (models.errors.isEmpty ?? false) {
      this.rooms.assignAll(models.rooms);
    } else {
      this._error.value = models.errors.first?.value;
    }
  }
}
