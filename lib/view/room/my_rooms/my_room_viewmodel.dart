import 'package:chautari/model/room_model.dart';

class RoomDetailViewModel {
  RoomsModel room;
  bool isMyRoom;

  RoomDetailViewModel(this.room, {this.isMyRoom = false});
}
