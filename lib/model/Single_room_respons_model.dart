import 'package:chautari/model/error.dart';
import 'package:chautari/model/room_model.dart';

class SingleRoomResponseModel {
  RoomsModel room;
  List<ApiError> errors;

  SingleRoomResponseModel({this.room});

  SingleRoomResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      room = RoomsModel.fromJson(json['data']);
    }
    if (json['errors'] != null) {
      errors = new List<ApiError>();
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
