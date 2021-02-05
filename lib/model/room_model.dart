import 'dart:io';

import 'package:chautari/model/amenity.dart';
import 'package:chautari/model/districts.dart';

import 'package:chautari/model/login_model.dart';
import 'package:chautari/model/parkings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http_parser/http_parser.dart';

class RoomModel {
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
  String type;
  String phone;
  bool phone_visibility;
  List<String> images;
  String postedOn;
  List<Parking> parkings;
  List<Amenities> amenities;
  Districts district;
  UserModel user;
  List<File> rawImages = List<File>();

  RoomModel(
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
      this.user,
      this.type,
      this.phone,
      this.phone_visibility,
      this.rawImages});

  RoomModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    amenityCount = json['amenity_count'];
    available = json['available'];
    districtName = json['district_name'];
    phone = json['phone'];
    type = json["type"];
    phone_visibility = json["phone_visibility"];

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
    data['type'] = this.type;
    data['phone'] = this.phone;

    data['phone_visibility'] = this.phone_visibility;
    data['postedOn'] = this.postedOn;

    // List<String> images;

    // List<Parking> parkings;
    // List<Amenities> amenities;

    return data;
  }

  Future<FormData> toFormData() async {
    var compressed = await _compressFiles(this.rawImages);

    var data = FormData.fromMap({
      'district': this.district,
      'address': this.address,
      'lat': this.lat,
      'long': this.long,
      'number_of_rooms': this.numberOfRooms,
      'price': this.price,
      'water': this.water,
      'parkings': this.parkings.map((e) => e.id).toList(),
      'amenities': this.amenities.map((e) => e.id).toList(),
      'available': this.available,
      'phone_visibility': this.phone_visibility,
      'phone': this.phone,
      'type': this.type,
      "images": compressed.asMap().entries.map((e) {
        return MultipartFile.fromBytes(e.value.readAsBytesSync(),
            filename: e.key.toString() + ".jpg",
            contentType: MediaType("image", "jpg"));
      }).toList(),
    });

    return data;
  }

  Future<List<File>> _compressFiles(List<File> files) async {
    var futures = files.map((e) => _compressFile(e));
    return await Future.wait(futures);
  }

  Future<File> _compressFile(File file) async {
    int quality = 5;
    int percentage = 60;
    return FlutterNativeImage.compressImage(file.path,
        quality: quality, percentage: percentage);
  }
}
