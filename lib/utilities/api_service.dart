import 'package:dio/dio.dart';
import 'dart:io' show Platform;

class ApiService {
  String _serverUrl = "";

  final String version = "v1";

  Dio _http;
  String _baseUrl = "";
  @override
  ApiService() {
    // _serverUrl = "http://143.110.252.83:4000/api/";

    if (Platform.isAndroid) {
      _serverUrl = "http://10.0.2.2:4000/api/";
    } else if (Platform.isIOS) {
      _serverUrl = "http://localhost:4000/api/";
      // _serverUrl = "http://192.168.0.100:8080/api/";
    }
    _baseUrl = _serverUrl + version + "/";
    BaseOptions options = new BaseOptions(
      // baseUrl: _baseUrl,
      connectTimeout: 70000,
      receiveTimeout: 60000,
      headers: _headers(),
      contentType: 'application/json',
      validateStatus: (status) {
        return status > 0;
      },
    );

    _http = Dio(options);
  }

  bool validation(int val) => val == 1;

  Map<String, String> _headers() {
    return this._headerBeforeLogin();
  }

  Future get(String url) async {
    var responseJson;
    try {
      responseJson = await _http.get(_baseUrl + url);
      print(responseJson);
    } catch (e) {
      String err = e.error.toString();
      Map<String, dynamic> val = {
        'error': [
          {'code': '1', 'detail': '$err'}
        ]
      };
      Response res = Response(data: val);
      responseJson = res;
    }
    return responseJson;
  }

  Future post(String url, dynamic params,
      {bool shouldAppednBaseurl = true}) async {
    var responseJson;
    String _url = shouldAppednBaseurl ? _baseUrl + url : url;

    print(_url);
    try {
      Response response = await _http.post(_url, data: params);
      print(response);

      responseJson = response;
    } catch (e) {
      String err = e.error.toString();
      Map<String, dynamic> val = {
        'error': [
          {'code': '1', 'detail': '$err'}
        ]
      };
      Response res = Response(data: val);
      responseJson = res;
    }
    return responseJson;
  }
}

extension on ApiService {
  Map<String, String> _headerBeforeLogin() {
    final String apikey =
        "16c9c17b5f17cba2edd2981deb74a46d123a9848d443c9d59ea4231f54892ada3391542f48609387";
    return {"API-Key": apikey};
  }

  // _headerAfterLogin() {
  //   final String apikey = "1cd74cd4-82c9-46b9-a12b-878782d2d610";
  //   return {"API-Key": apikey, "authorization": ""};
  // }
}
