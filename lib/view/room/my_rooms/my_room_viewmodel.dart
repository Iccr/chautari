import 'package:chautari/model/rooms_model.dart';

class RoomDetailViewModel {
  RoomsModel room;
  bool isMyRoom;

  RoomDetailViewModel(this.room, {this.isMyRoom = false});
}
