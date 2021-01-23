import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/repository/rooms_repository.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ExploreController extends GetxController {
  bool isLoading = false;
  String error;
  List<RoomsModel> models;

  get length => models.length;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _fetchRooms();
  }

  _fetchRooms() async {
    isLoading = true;
    var models = await RoomsRepository().fetchRoms();
    isLoading = false;
    if (models.errors?.isEmpty ?? false) {
      this.error = models.errors?.first?.value;
    } else {
      this.models = models.rooms;
    }
    update();
  }
}
