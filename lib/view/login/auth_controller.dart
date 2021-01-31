import 'package:chautari/model/error.dart';
import 'package:chautari/model/login_model.dart';
import 'package:chautari/repository/login_repository.dart';
import 'package:chautari/utilities/constants.dart';
import 'package:chautari/utilities/storage.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  bool loading;
  bool loaded;
  var error = "".obs;
  final ChautariStorage box = ChautariStorage();
  var _user = UserModel().obs;

  onInit() {
    super.onInit();

    Map<String, dynamic> _userMap = box.read(AppConstant.userKey);
    if (_userMap == null) {
      this._user.value = UserModel();
    } else {
      UserModel user = UserModel.fromJson(_userMap);
      print(user.email);
      print(user.isLoggedIn);
      this._user.value = user;
    }
  }

  UserModel get user => _user.value;
  bool get isLoggedIn => this._user.value.isLoggedIn ?? false;

  String get token => this._user.value.token;

  logout() async {
    await _removeUser();
    var emptyUser = UserModel();
    await _saveuser(emptyUser);
    this._user.value = emptyUser;
  }

  final FacebookLogin facebookSignIn = new FacebookLogin();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  Future fbLogin() async {
    final FacebookLoginResult result =
        await facebookSignIn.logIn(['email', 'public_profile']);
    // var _result = false;
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;

        var model = await LoginRepository().getFacebookUser(accessToken.token);

        Map<String, dynamic> params = {
          "user": {
            "token": accessToken.token,
            "user_id": accessToken.userId,
            "provider": "facebook",
            "name": model.name,
            "email": model.email,
            "imageurl": model.picture ?? ""
          }
        };

        await _loginWithApi(params);

        break;
      case FacebookLoginStatus.cancelledByUser:
        error.value = "Login cancelled by the user.";
        break;
      case FacebookLoginStatus.error:
        error.value = result.errorMessage;
        break;
    }
  }

  Future gleSignIn() async {
    try {
      var result = await _googleSignIn.signIn();
      if (result == null) {
        throw Exception("something went wrong");
      } else {
        var auth = await result.authentication;

        Map<String, dynamic> params = {
          "user": {
            "token": auth.accessToken,
            "user_id": auth.idToken,
            "provider": "google",
            "name": result.displayName,
            "email": result.email,
            "imageurl": result.photoUrl
          }
        };
        await _loginWithApi(params);
      }
    } catch (e) {
      print(e);
      error = e.message;
    }
  }

  _saveuser(UserModel user) async {
    await box.write(AppConstant.userKey, user.toJson());
  }

  _removeUser() async {
    await box.remove(AppConstant.userKey);
  }

  Future _loginWithApi(Map<String, dynamic> params) async {
    var model = await LoginRepository().social(params);
    if ((model.errors ?? []).isEmpty) {
      UserModel user = model.data;
      user.isLoggedIn = true;
      await _saveuser(user);
      this._user.value = user;

      Get.back();
    } else {
      List<ApiError> errors = model.errors ?? [];
      error.value = errors.first?.value ?? "";
    }
  }
}
