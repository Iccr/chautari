import 'package:chautari/model/error.dart';
import 'package:chautari/model/room_model.dart';

class SingleRoomResponseModel {
  RoomModel room;
  List<ApiError> errors = [];

  SingleRoomResponseModel({this.room});

  SingleRoomResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      room = RoomModel.fromJson(json['data']);
    }
    if (json['errors'] != null) {
      json['errors'].forEach((v) {
        errors.add(new ApiError.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.room != null) {
      data['data'] = this.room.toJson();
    }
    return data;
  }
}
