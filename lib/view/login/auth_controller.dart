import 'package:chautari/model/error.dart';
import 'package:chautari/model/login_model.dart';
import 'package:chautari/repository/login_repository.dart';
import 'package:chautari/utilities/constants.dart';
import 'package:chautari/utilities/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

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
    await firebaseAuth.signOut();
    this._user.value = emptyUser;
  }

  final FacebookLogin facebookSignIn = new FacebookLogin();

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

        var model = await LoginRepository().getFacebookUser(accessToken.token);

        var firebaseUser = await _loginWithFacebookFirebase(accessToken.token);
        if (firebaseUser == null) {
          print("firebase login failed");
        }

        Map<String, dynamic> params = {
          "user": {
            "token": accessToken.token,
            "user_id": accessToken.userId,
            "provider": "facebook",
            "name": firebaseUser.displayName,
            "email": model.email,
            "imageurl": firebaseUser.photoURL ?? "",
            "fuid": firebaseUser.uid
            // "fcm"
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

        var firebaseUser = await _loginWithGoogleFirebase(auth);
        if (firebaseUser == null) {
          print("firebase login failed");
        }
        Map<String, dynamic> params = {
          "user": {
            "token": auth.accessToken,
            "user_id": auth.idToken,
            "provider": "google",
            "name": result.displayName,
            "email": result.email,
            "imageurl": result.photoUrl,
            "fuid": firebaseUser.uid,
            // "fcm":
          }
        };

        await _loginWithApi(params);
      }
    } catch (e) {
      print(e);
      error.value = e.message;
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

  Future<User> _loginWithGoogleFirebase(
      GoogleSignInAuthentication googleAuth) async {
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    User firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;
    if (firebaseUser != null) {
      // Check is already sign up

      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .get();

      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // Update data to server if new user
        FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .set({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoURL,
          'id': firebaseUser.uid
        });
      }
      return firebaseUser;
    }
  }

  Future<User> _loginWithFacebookFirebase(String accesstoken) async {
    final OAuthCredential credential =
        FacebookAuthProvider.credential(accesstoken);

    var result = (await firebaseAuth.signInWithCredential(credential));
    var firebaseUser = result.user;
    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .get();

      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // Update data to server if new user
        FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .set({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoURL,
          'id': firebaseUser.uid
        });
      }
      return firebaseUser;
    }
  }
}
