import 'package:chautari/model/error.dart';
import 'package:chautari/repository/login_repository.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppConstant {
  static String userToken = "chautari_user_token";
  static String recentEmail = "chautari_recent_email";
}

class LoginController extends GetxController {
  bool loading;
  bool loaded;
  String error;

  final FacebookLogin facebookSignIn = new FacebookLogin();
  final _storage = FlutterSecureStorage();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  Future fbLogin() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    // var _result = false;
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        Map<String, String> params = {
          "token": accessToken.userId,
          "provider": "facebook"
        };
        // await _loginWithApi(params);
        break;
      case FacebookLoginStatus.cancelledByUser:
        error = "Login cancelled by the user.";
        break;
      case FacebookLoginStatus.error:
        error = result.errorMessage;
        break;
    }
  }

  Future gleSignIn() async {
    try {
      var result = await _googleSignIn.signIn();
      var auth = await result.authentication;
      Map<String, String> params = {
        "token": auth.accessToken,
        "provider": "google"
      };
      await _loginWithApi(params);
    } catch (e) {
      print(e);
      error = e;
    }
  }

  _saveToken(String val) async {
    await _storage.write(key: AppConstant.userToken, value: val);
  }

  Future _loginWithApi(Map<String, String> params) async {
    var model = await LoginRepository().social(params);
    if ((model.error ?? []).isEmpty) {
      String token = model.data.token;
      await _saveToken(token);

      // _result = true;
    } else {
      List<ApiError> errors = model.error ?? [];
      error = errors.first?.detail ?? "";
      // _result = false;
    }
  }
}
