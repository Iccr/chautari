import 'package:chautari/model/add_room_multipart_model.dart';
import 'package:chautari/view/room/form_keys.dart';
import 'package:chautari/view/room/room_form_focusnode.dart';
import 'package:get/get.dart';

class UpdateRoomController extends GetxController {
  RoomFormKeys formKeys = RoomFormKeys();
  RoomFocusNodes focusNodes = RoomFocusNodes();
  final CreateRoomApiRequestModel apiModel = CreateRoomApiRequestModel();

  var contactNumberVisible = false.obs;
}
