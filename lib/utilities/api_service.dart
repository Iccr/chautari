import 'package:chautari/utilities/constants.dart';
import 'package:chautari/utilities/storage.dart';
import 'package:dio/dio.dart';
import 'dart:io' show Platform;

class BaseUrl {
  final String version = "v1";

  String _serverUrl;
  String _imageServerUrl;

  BaseUrl() {
    if (Platform.isAndroid) {
      _serverUrl = "http://10.0.2.2:4000/api/";
      _imageServerUrl = "http://10.0.2.2:4000/";
    } else if (Platform.isIOS) {
      _serverUrl = "http://localhost:4000/api/";
      _imageServerUrl = "http://localhost:4000/";
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
  }

  bool validation(int val) => val == 1;

  Map<String, String> _headers() {
    String token = ChautariStorage().read(AppConstant.userKey)["token"];
    var header = Map<String, String>();
    header['Authorization'] = "Bearer " + token ?? "";
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

  Future postFormData(String url, dynamic params,
      {bool shouldAppednBaseurl = true}) async {
    var responseJson;
    String _url = shouldAppednBaseurl ? _baseUrl + url : url;

    print(_url);
    print(params);
    try {
      var formdata = FormData.fromMap(params);
      print(formdata);
      Response response = await _http.post(
        _url,
        data: formdata,
        options: Options(
          headers: _headers(),
        ),
      );
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

  Future post(String url, dynamic params,
      {bool shouldAppednBaseurl = true}) async {
    var responseJson;
    String _url = shouldAppednBaseurl ? _baseUrl + url : url;

    print(_url);
    print(params);
    try {
      Response response = await _http.post(
        _url,
        data: params,
        options: Options(
          headers: _headers(),
        ),
      );
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
