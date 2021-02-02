import 'dart:io';
import 'package:chautari/model/amenity.dart';
import 'package:chautari/model/parkings.dart';
import 'package:chautari/model/water.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

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

  Future<FormData> toJson() async {
    var compressed = await _compressFiles(this.images);

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
