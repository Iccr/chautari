import 'package:chautari/model/amenity.dart';
import 'package:chautari/model/districts.dart';
import 'package:chautari/model/error.dart';
import 'package:chautari/model/login_model.dart';
import 'package:chautari/model/parkings.dart';

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

class RoomsModel {
  String address;
  int amenityCount;
  bool available;
  String districtName;
  int id;
  double lat;
  double long;
  int numberOfRooms;
  int parkingCount;
  String price;
  int state;
  String water;
  List<String> images;
  String postedOn;
  List<Parking> parkings;
  List<Amenities> amenities;
  Districts district;
  UserModel user;

  RoomsModel(
      {this.address,
      this.amenityCount,
      this.available,
      this.districtName,
      this.id,
      this.lat,
      this.long,
      this.numberOfRooms,
      this.parkingCount,
      this.price,
      this.images,
      this.state,
      this.water,
      this.postedOn,
      this.parkings,
      this.amenities,
      this.district,
      this.user});

  RoomsModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    amenityCount = json['amenity_count'];
    available = json['available'];
    districtName = json['district_name'];

    id = json['id'];
    if (json['lat'] != null) {
      lat = double.parse(json['lat']);
    }
    // lat = json['lat'];
    if (json['long'] != null) {
      long = double.parse(json['long']);
    }
    // long = json['long'];

    numberOfRooms = json['number_of_rooms'];
    parkingCount = json['parking_count'];
    price = json['price'];
    state = json['state'];
    water = json['water'];
    postedOn = json['posted_on'];

    this.images = List<String>();
    json['images'].forEach((e) {
      images.add(e);
    });

    if (json["parkings"] != null) {
      this.parkings = List<Parking>();
      json['parkings'].forEach((e) {
        this.parkings.add(Parking.fromJson(e));
      });
    }

    if (json["amenities"] != null) {
      this.amenities = List<Amenities>();
      json['amenities'].forEach((e) {
        this.amenities.add(Amenities.fromJson(e));
      });
    }

    if (json["district"] != null) {
      this.district = Districts.fromJson(json["district"]);
    }

    if (json["user"] != null) {
      this.user = UserModel.fromJson(json["user"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['amenity_count'] = this.amenityCount;
    data['available'] = this.available;
    data['district_name'] = this.districtName;
    data['id'] = this.id;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['number_of_rooms'] = this.numberOfRooms;
    data['parking_count'] = this.parkingCount;
    data['price'] = this.price;
    data['state'] = this.state;
    data['water'] = this.water;

    return data;
  }
}
