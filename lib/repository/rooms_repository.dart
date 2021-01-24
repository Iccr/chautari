import 'dart:convert';

import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/utilities/api_service.dart';

class RoomsRepository {
  final String _list_rooms_url = "/rooms";

  ApiService api;
  RoomsRepository() {
    api = ApiService();
  }

  Future<RoomsResponseModel> fetchRoms() async {
    final response = await api.get(_list_rooms_url);
    return RoomsResponseModel.fromJson(response.data);
  }
}
