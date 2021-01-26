import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/utilities/api_service.dart';

class RoomsRepository {
  final String _listRoomURl = "/rooms";

  ApiService api;
  RoomsRepository() {
    api = ApiService();
  }

  Future<RoomsResponseModel> fetchRoms() async {
    final response = await api.get(_listRoomURl);
    return RoomsResponseModel.fromJson(response.data);
  }
}
