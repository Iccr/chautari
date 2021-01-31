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

  Future<RoomsResponseModel> fetchRooms() async {
    final response = await api.get(_roomsURl);
    return RoomsResponseModel.fromJson(response.data);
  }

  Future<AddRoomResponseModel> addRoom(FormData params) async {
    final response = await api.post(_roomsURl, params);
    return AddRoomResponseModel.fromJson(response.data);
  }
}
