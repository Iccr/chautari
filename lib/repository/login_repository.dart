import 'package:chautari/model/login_model.dart';
import 'package:chautari/utilities/api_service.dart';

class LoginRepository {
  final String url = "/auth/login";
  final String _socialUrl = "/auth/social";

  ApiService api;
  LoginRepository() {
    api = ApiService();
  }

  Future<LoginApiResponse> login(Map<String, String> params) async {
    print("calling with $params");
    final response = await api.post(url, params);
    return LoginApiResponse.fromJson(response.data);
  }

  Future<LoginApiResponse> social(Map<String, String> params) async {
    print("calling with $params");
    final response = await api.post(_socialUrl, params);
    return LoginApiResponse.fromJson(response.data);
  }
}
