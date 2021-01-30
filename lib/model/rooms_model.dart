import 'package:chautari/model/error.dart';

class RoomsResponseModel {
  List<RoomsModel> rooms;
  List<ApiError> errors;

  RoomsResponseModel({this.rooms});

  RoomsResponseModel.fromJson(Map<String, dynamic> json) {
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
  String lat;
  String long;
  int numberOfRooms;
  int parkingCount;
  String price;
  int state;
  String water;
  List<String> images;
  String postedOn;

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
      this.postedOn});

  RoomsModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    amenityCount = json['amenity_count'];
    available = json['available'];
    districtName = json['district_name'];
    id = json['id'];
    lat = json['lat'];
    long = json['long'];

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
