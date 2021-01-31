import 'package:chautari/model/add_room_respons_model.dart';
import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/utilities/api_service.dart';
import 'package:dio/dio.dart';

class RoomsRepository {
  final String _roomsURl = "/rooms";

  ApiService api;
  RoomsRepository() {
    api = ApiService();
  }

  Future<RoomsResponseModel> fetchMyRooms(int id) async {
    var url = _roomsURl + "?user_id=$id";
    final response = await api.get(url);
    return RoomsResponseModel.fromJson(response.data);
  }

  Future<RoomsResponseModel> fetchRooms() async {
    final response = await api.get(_roomsURl);
    return RoomsResponseModel.fromJson(response.data);
  }

  Future<AddRoomResponseModel> addRoom(FormData params) async {
    final response = await api.post(_roomsURl, {"room": params});
    return AddRoomResponseModel.fromJson(response.data);
  }
}
