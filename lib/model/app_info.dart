import 'package:chautari/model/amenity.dart';
import 'package:chautari/model/districts.dart';
import 'package:chautari/model/error.dart';
import 'package:chautari/model/parkings.dart';
import 'package:chautari/model/type.dart';
import 'package:chautari/model/water.dart';

class AppinfoResponseModel {
  AppinfoModel data;
  List<ApiError> errors;

  AppinfoResponseModel({this.data});

  AppinfoResponseModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new AppinfoModel.fromJson(json['data']) : null;

    if (json['errors'] != null) {
      errors = new List<ApiError>();
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
  List<Amenities> amenities;
  List<Districts> districts;
  List<Parking> parkings;
  List<Water> waters;
  List<RoomType> types;

  AppinfoModel(
      {this.amenities, this.districts, this.parkings, this.waters, this.types});

  AppinfoModel.fromJson(Map<String, dynamic> json) {
    if (json['amenities'] != null) {
      amenities = new List<Amenities>();
      json['amenities'].forEach((v) {
        amenities.add(new Amenities.fromJson(v));
      });
    }
    if (json['districts'] != null) {
      districts = new List<Districts>();
      json['districts'].forEach((v) {
        districts.add(new Districts.fromJson(v));
      });
    }
    if (json['parkings'] != null) {
      parkings = new List<Parking>();
      json['parkings'].forEach((v) {
        parkings.add(new Parking.fromJson(v));
      });
    }
    if (json['waters'] != null) {
      waters = new List<Water>();
      json['waters'].forEach((v) {
        waters.add(new Water.fromJson(v));
      });
    }

    if (json['types'] != null) {
      types = new List<RoomType>();
      json['types'].forEach((v) {
        types.add(new RoomType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amenities != null) {
      data['amenities'] = this.amenities.map((v) => v.toJson()).toList();
    }
    if (this.districts != null) {
      data['districts'] = this.districts.map((v) => v.toJson()).toList();
    }
    if (this.parkings != null) {
      data['parkings'] = this.parkings.map((v) => v.toJson()).toList();
    }
    if (this.waters != null) {
      data['waters'] = this.waters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
