import 'package:chautari/model/error.dart';

class LoginApiResponse {
  UserModel data;
  List<ApiError> errors;

  LoginApiResponse({this.data});

  LoginApiResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UserModel.fromJson(json['data']) : null;
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

class UserModel {
  String authToken;
  String email;
  int id;
  String imageurl;
  String name;
  String provider;
  String token;
  bool isLoggedIn = false;
  String fuid;
  String fcm;

  UserModel(
      {this.authToken,
      this.email,
      this.id,
      this.imageurl,
      this.name,
      this.provider,
      this.token,
      this.fuid,
      this.fcm});

  UserModel.fromJson(Map<String, dynamic> json) {
    authToken = json['auth_token'];
    email = json['email'];
    id = json['id'];
    imageurl = json['imageurl'];
    name = json['name'];
    provider = json['provider'];
    token = json['token'];
    isLoggedIn = json['isLoggedIn'];
    fuid = json['fuid'];
    fcm = json['fcm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth_token'] = this.authToken;
    data['email'] = this.email;
    data['id'] = this.id;
    data['imageurl'] = this.imageurl;
    data['name'] = this.name;
    data['provider'] = this.provider;
    data['token'] = this.token;
    data['isLoggedIn'] = this.isLoggedIn;
    data['fuid'] = this.fuid;
    data['fcm'] = this.fcm;
    return data;
  }
}
