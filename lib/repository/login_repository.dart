import 'dart:convert';

import 'package:chautari/model/fb_user_model.dart';
import 'package:chautari/model/login_model.dart';
import 'package:chautari/utilities/api_service.dart';

class LoginRepository {
  final String _socialUrl = "/login";
  final String _fbVerifyUrl =
      "https://graph.facebook.com/me?fields=name,first_name,last_name,email,picture&access_token=";

  ApiService api;
  LoginRepository() {
    api = ApiService();
  }

  Future<LoginApiResponse> social(Map<String, dynamic> params) async {
    final response = await api.post(_socialUrl, params);
    return LoginApiResponse.fromJson(response.data);
  }

  Future<FbUserModel> getFacebookUser(String accessToken) async {
    String url = _fbVerifyUrl + accessToken;
    final response = await api.post(url, null, shouldAppednBaseurl: false);
    return FbUserModel.fromJson(jsonDecode(response.data));
  }
}
