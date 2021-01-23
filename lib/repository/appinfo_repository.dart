import 'dart:convert';

import 'package:chautari/model/app_info.dart';
import 'package:chautari/model/fb_user_model.dart';
import 'package:chautari/model/login_model.dart';
import 'package:chautari/utilities/api_service.dart';

class AppinfoRepository {
  final String _appinfoUrl = "appinfo";

  ApiService api;
  AppinfoRepository() {
    api = ApiService();
  }

  Future<AppinfoResponseModel> fetchAppInfo() async {
    final response = await api.post(_appinfoUrl, null);
    return AppinfoResponseModel.fromJson(response.data);
  }
}
