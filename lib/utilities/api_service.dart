import 'package:chautari/utilities/constants.dart';
import 'package:chautari/utilities/storage.dart';
import 'package:dio/dio.dart';
import 'dart:io' show Platform;

import '../environment.dart';

class BaseUrl {
  final String version = "v1";

  String _serverUrl;
  String _imageServerUrl;

  BaseUrl() {
    if (development) {
      if (Platform.isAndroid) {
        _serverUrl = "http://10.0.2.2:4000/api/";
        _imageServerUrl = "http://10.0.2.2:4000/";
      } else if (Platform.isIOS) {
        _serverUrl = "http://localhost:4000/api/";
        _imageServerUrl = "http://localhost:4000/";
      }
    } else {
      _serverUrl = "http://143.110.252.83:4000/api/";
      _imageServerUrl = "http://143.110.252.83:4000/";
    }
  }

  String get imageBaseUrl => _imageServerUrl;
  String get baseUrl => _serverUrl + version;
}

class ApiService {
  Dio _http;
  String _baseUrl = "";

  @override
  ApiService() {
    _baseUrl = BaseUrl().baseUrl;

    BaseOptions options = new BaseOptions(
      connectTimeout: 70000,
      receiveTimeout: 60000,
      headers: _headers(),
      contentType: 'application/json',
      validateStatus: (status) {
        return status > 0;
      },
    );

    _http = Dio(options);

    _http.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print("******** Request *********");
      print("url: ${options.uri}");
      print("contentType: ${options.contentType}");
      print("headers: ${options.headers}");

      return options;
    }, onResponse: (Response response) async {
      print("******** Response *********");
      print("data: ${response.data}");
      print("");
      print("statusCode: ${response.statusCode}");
      print("request: ${response.request}");

      return response; // continue
    }, onError: (DioError e) async {
      print("******** Error *********");
      print("error: ${e.error}");
      return e; //continue
    }));
  }

  bool validation(int val) => val == 1;

  Map<String, String> _headers() {
    var userMap = ChautariStorage().read(AppConstant.userKey);
    if (userMap != null && userMap["isLoggedIn"]) {
      String token = userMap["token"] ?? "";
      var header = Map<String, String>();
      header['Authorization'] = "Bearer " + token;
      return header;
    }
    var header = Map<String, String>();
    header['Authorization'] = "Bearer " + "";
    return header;
  }

  Future get(String url) async {
    var responseJson;
    try {
      responseJson = await _http.get(
        _baseUrl + url,
        options: Options(
          headers: _headers(),
        ),
      );
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

  // Future postFormData(String url, dynamic params,
  //     {bool shouldAppednBaseurl = true}) async {
  //   var responseJson;
  //   String _url = shouldAppednBaseurl ? _baseUrl + url : url;

  //   try {
  //     var formdata = FormData.fromMap(params);
  //     Response response = await _http.post(
  //       _url,
  //       data: formdata,
  //       options: Options(
  //         headers: _headers(),
  //       ),
  //     );

  //     responseJson = response;
  //   } catch (e) {
  //     String err = e.error.toString();
  //     Map<String, dynamic> val = {
  //       'error': [
  //         {'code': '1', 'detail': '$err'}
  //       ]
  //     };
  //     Response res = Response(data: val);
  //     responseJson = res;
  //   }
  //   return responseJson;
  // }

  Future post(String url, dynamic params,
      {bool shouldAppednBaseurl = true}) async {
    var responseJson;
    String _url = shouldAppednBaseurl ? _baseUrl + url : url;

    try {
      Response response = await _http.post(
        _url,
        data: params,
        options: Options(
          headers: _headers(),
        ),
      );
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

  Future update(String url, dynamic params) async {
    var responseJson;
    try {
      Response response = await _http.patch(
        url,
        data: params,
        options: Options(
          headers: _headers(),
        ),
      );
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
