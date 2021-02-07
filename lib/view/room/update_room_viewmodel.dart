import 'package:chautari/model/room_model.dart';

class UpdateRoomViewModel {
  RoomModel room;
  bool update;

  UpdateRoomViewModel(this.room, {this.update = false});
}
