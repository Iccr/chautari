import 'package:chautari/model/error.dart';
import 'package:chautari/model/room_model.dart';

class AllRoomsResponseModel {
  List<RoomsModel> rooms;
  List<ApiError> errors;

  AllRoomsResponseModel({this.rooms});

  AllRoomsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      rooms = new List<RoomsModel>();
      json['data'].forEach((v) {
        rooms.add(new RoomsModel.fromJson(v));
      });
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
    if (this.rooms != null) {
      data['data'] = this.rooms.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
