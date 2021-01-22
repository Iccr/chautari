import 'dart:convert';

import 'package:chautari/model/app_info.dart';
import 'package:chautari/model/fb_user_model.dart';
import 'package:chautari/model/login_model.dart';
import 'package:chautari/utilities/api_service.dart';

class LoginRepository {
  final String _appinfoUrl = "appinfo";

  ApiService api;
  LoginRepository() {
    api = ApiService();
  }

  Future<AppinfoResponseModel> social(Map<String, dynamic> params) async {
    final response = await api.post(_appinfoUrl, params);
    return AppinfoResponseModel.fromJson(response.data);
  }
}
