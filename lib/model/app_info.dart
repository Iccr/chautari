import 'package:chautari/model/amenity.dart';
import 'package:chautari/model/config.dart';
import 'package:chautari/model/districts.dart';
import 'package:chautari/model/error.dart';
import 'package:chautari/model/parkings.dart';
import 'package:chautari/model/type.dart';
import 'package:chautari/model/water.dart';

class AppinfoResponseModel {
  AppinfoModel data;
  List<ApiError> errors = [];

  AppinfoResponseModel({this.data});

  AppinfoResponseModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new AppinfoModel.fromJson(json['data']) : null;

    if (json['errors'] != null) {
      json['errors'].forEach((v) {
        errors.add(new ApiError.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }

    if (this.errors != null) {
      data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppinfoModel {
  List<Amenities> amenities = [];
  List<Districts> districts = [];
  List<Parking> parkings = [];
  List<Water> waters = [];
  List<RoomType> types = [];
  AppConfig config;

  AppinfoModel({
    this.amenities = const <Amenities>[],
    this.districts = const <Districts>[],
    this.parkings = const <Parking>[],
    this.waters = const <Water>[],
    this.types = const <RoomType>[],
  });

  AppinfoModel.fromJson(Map<String, dynamic> json) {
    if (json['amenities'] != null) {
      json['amenities'].forEach((v) {
        this.amenities.add(new Amenities.fromJson(v));
      });
    }
    if (json['districts'] != null) {
      json['districts'].forEach((v) {
        this.districts.add(new Districts.fromJson(v));
      });
    }
    if (json['parkings'] != null) {
      json['parkings'].forEach((v) {
        this.parkings.add(new Parking.fromJson(v));
      });
    }
    if (json['waters'] != null) {
      json['waters'].forEach((v) {
        this.waters.add(new Water.fromJson(v));
      });
    }

    if (json['types'] != null) {
      json['types'].forEach((v) {
        types.add(new RoomType.fromJson(v));
      });
    }

    if (json['config'] != null) {
      this.config = AppConfig.fromJson(json["config"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amenities.isNotEmpty) {
      data['amenities'] = this.amenities.map((v) => v.toJson()).toList();
    }
    if (this.districts.isNotEmpty) {
      data['districts'] = this.districts.map((v) => v.toJson()).toList();
    }
    if (this.parkings.isNotEmpty) {
      data['parkings'] = this.parkings.map((v) => v.toJson()).toList();
    }
    if (this.waters.isNotEmpty) {
      data['waters'] = this.waters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
