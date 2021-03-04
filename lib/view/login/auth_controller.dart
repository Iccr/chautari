import 'package:chautari/model/error.dart';
import 'package:chautari/model/login_model.dart';
import 'package:chautari/repository/login_repository.dart';
import 'package:chautari/utilities/constants.dart';
import 'package:chautari/utilities/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  final ChautariStorage box = ChautariStorage();
  var _user = UserModel().obs;

  var loading = false.obs;
  var error = "".obs;

  UserModel get user => _user.value;
  bool get isLoggedIn => this._user.value.isLoggedIn ?? false;
  String get token => this._user.value.token;
  final FacebookLogin facebookSignIn = new FacebookLogin();

  onInit() {
    super.onInit();

    Map<String, dynamic> _userMap = box.read(AppConstant.userKey);
    if (_userMap == null) {
      this._user.value = UserModel();
    } else {
      UserModel user = UserModel.fromJson(_userMap);
      this._user.value = user;
    }
  }

  logout() async {
    await _removeUser();
    var emptyUser = UserModel();
    await _saveuser(emptyUser);
    await firebaseAuth.signOut();
    this._user.value = emptyUser;
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  Future fbLogin() async {
    loading.value = true;
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    // var _result = false;
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        var model = await LoginRepository().getFacebookUser(accessToken.token);
        Map<String, dynamic> params = {
          "user": {
            "token": accessToken.token,
            "user_id": "",
            "provider": "facebook",
            "name": "",
            "email": "",
            "imageurl": model.picture ?? "",
            "fuid": ""
            // "fcm"
          }
        };

        await _loginWithApi(params);

        break;
      case FacebookLoginStatus.cancelledByUser:
        loading.value = false;
        error.value = "Login cancelled by the user.";
        break;
      case FacebookLoginStatus.error:
        loading.value = false;
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
            "user_id": "",
            "provider": "google",
            "imageurl": result.photoUrl,
            "name": "",
            "email": "",
            "fuid": "",
          }
        };

        await _loginWithApi(params);
      }
    } catch (e) {
      print(e);
      error.value = e;
    }
  }

  _saveuser(UserModel user) async {
    await box.write(AppConstant.userKey, user.toJson());
  }

  _removeUser() async {
    await box.remove(AppConstant.userKey);
  }

  Future _loginWithApi(Map<String, dynamic> params) async {
    // String fuid = params['user']['fuid'];
    String fcm;
    // if (fuid != null) {
    fcm = await getFcmToken();
    params["user"]["fcm"] = fcm;

    // FirebaseFirestore.instance.collection('users').doc(fuid ?? "").update(
    //   {'fcm': fcm},
    // );
    // }

    var model = await LoginRepository().social(params);
    if ((model.errors ?? []).isEmpty) {
      loading.value = false;
      UserModel user = model.data;
      user.isLoggedIn = true;
      await _saveuser(user);
      this._user.value = user;
      await createFirebaseUser(user);
      Get.back();
    } else {
      loading.value = false;
      List<ApiError> errors = model.errors ?? [];
      error.value = errors.first?.value ?? "";
    }
  }

  Future createFirebaseUser(UserModel user) {
    var params = {
      "imageurl": user.imageurl ?? "",
      "name": user.name ?? "",
      "email": user.email ?? ""
    };
    FirebaseFirestore.instance
        .collection("users")
        .doc("${user.id}")
        .set(params);
  }

  Future<String> getFcmToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  Future<User> _loginWithGoogleFirebase(
      GoogleSignInAuthentication googleAuth) async {
    loading.value = true;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
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
    } catch (e) {
      print(e);
      loading.value = false;
      return null;
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

  Future appleSignIn() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    var name = credential.givenName;
    if (credential.familyName != null && credential.familyName.isNotEmpty) {
      name = name + " " + credential.familyName;
    }

    Map<String, dynamic> params = {
      "user": {
        "token": credential.userIdentifier,
        "user_id": credential.userIdentifier,
        "provider": "apple",
        "name": name,
        "email": credential.email ?? "",
        "imageurl": "",
        // "fuid": firebaseUser.uid
        // "fcm"
      }
    };

    await _loginWithApi(params);
    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
  }
}
