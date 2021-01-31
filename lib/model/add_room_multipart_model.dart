import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'app_info.dart';

class CreateRoomApiRequestModel {
  int id;
  int district;
  String address;
  double lat;
  double long;
  String price;
  int numberOfRooms;
  List<Parking> parkings;
  List<Amenities> amenities;
  bool available = true;
  Water water;
  List<File> images;

  FormData toJson() {
    var data = FormData.fromMap({
      'district': this.district,
      'address': this.address,
      'lat': this.lat,
      'long': this.long,
      'number_of_rooms': this.numberOfRooms,
      'price': this.price,
      'water': this.water.value,
      'parkings': this.parkings.map((e) => e.id).toList(),
      'amenities': this.amenities.map((e) => e.id).toList(),
      'available': this.available,
      "images": this.images.asMap().entries.map((e) {
        return MultipartFile.fromBytes(e.value.readAsBytesSync(),
            filename: e.key.toString() + ".jpg",
            contentType: MediaType("image", "jpg"));
      }).toList(),
    });

    return data;
  }
}
