import 'package:chautari/model/Single_room_respons_model.dart';
import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/utilities/api_service.dart';
import 'package:dio/dio.dart';

class RoomsRepository {
  final String _roomsURl = "/rooms";
  final String _myRooms = "/my_rooms";

  ApiService api;
  RoomsRepository() {
    api = ApiService();
  }

  Future<AllRoomsResponseModel> fetchMyRooms() async {
    final response = await api.get(_myRooms);
    return AllRoomsResponseModel.fromJson(response.data);
  }

  Future<AllRoomsResponseModel> fetchRooms() async {
    final response = await api.get(_roomsURl);
    return AllRoomsResponseModel.fromJson(response.data);
  }

  Future<SingleRoomResponseModel> addRoom(FormData params) async {
    final response = await api.post(_roomsURl, params);
    return SingleRoomResponseModel.fromJson(response.data);
  }

  Future<SingleRoomResponseModel> fetchRoomDetail(int params) async {
    var url = _roomsURl + "/$params";
    final response = await api.get(url);
    return SingleRoomResponseModel.fromJson(response.data);
  }
}
