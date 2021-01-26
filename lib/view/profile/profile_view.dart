import 'package:chautari/model/login_model.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:chautari/view/login/login_view.dart';
import 'package:chautari/view/profile/avatar_component.dart';
import 'package:chautari/view/profile/profile_controller.dart';
import 'package:chautari/widgets/chautari_list.dart';
import 'package:chautari/widgets/chautari_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController loginController = Get.find();
    double padding = ChautariPadding.standard;

    int _redirectTo;

    _goTOLogin({ProfileController controller}) async {
      await showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => LoginView(),
      );
      if (loginController.isLoggedIn &&
          _redirectTo != null &&
          controller != null) {
        controller.selectedIndex(_redirectTo);
      }
      _redirectTo = null;
    }

    double _getHeight() {
      return loginController.isLoggedIn ? 60 : 60;
    }

    Widget _getFAB() {
      return loginController.isLoggedIn
          ? null
          : FloatingActionButton(
              onPressed: () => {_goTOLogin()},
              backgroundColor: ChautariColors.blackAndPrimarycolor(),
              child: Text(
                "Login",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            );
    }

    _selectedIndex(int index, ProfileController c) {
      if (loginController.isLoggedIn) {
        c.selectedIndex(index);
      } else {
        _redirectTo = index;
        _goTOLogin(controller: c);
      }
    }

    return GetX<ProfileController>(
      init: ProfileController(),
      builder: (c) => SafeArea(
        child: Scaffold(
            body: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: padding, left: padding),
                    height: _getHeight(),
                    child: UserInfoView(
                      user: loginController.user,
                      action: _goTOLogin,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          ChautariList().getSeperator(),
                      itemCount: c.menu.length,
                      itemBuilder: (context, index) {
                        return ChautariList().getListTile(
                            () => _selectedIndex(index, c),
                            c.menu.elementAt(index));
                      },
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: _getFAB()),
      ),
    );
  }
}

class UserInfoView extends StatelessWidget {
  final AuthController loginController = Get.find();
  final ProfileController profileController = Get.find();
  final UserModel user;
  final Function action;
  UserInfoView({this.user, this.action});
  @override
  Widget build(BuildContext context) {
    _logout() async {
      await loginController.logout();
    }

    showLogoutDialogue() {
      Get.defaultDialog(
          title: "Do you want to Logout?",
          middleText:
              "your will not be able to get notification and other services",
          textConfirm: "Logout",
          confirmTextColor: ChautariColors.blackAndWhitecolor(),
          onConfirm: () async {
            await _logout();
            Get.back();
          },
          onCancel: () => {Get.back()});
    }

    return !loginController.isLoggedIn
        ? Container(
            child: Row(
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                        style: ChautariTextStyles().listSubtitle,
                        children: [
                          TextSpan(text: profileController.userInsightMessage),
                          TextSpan(text: " Would you like to "),
                          TextSpan(
                              text: "Login now",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none,
                                color: ChautariColors.primaryColor(),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  action();
                                }),
                        ]),
                  ),
                ),
              ],
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AvatarView(
                radius: 37.77,
                imageUrl: user?.imageurl ?? "",
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user?.name ?? "",
                      style: Theme.of(context).textTheme.bodyText1),
                  Text(user?.email ?? "")
                ],
              ),
              Expanded(child: Container()),
              ChautariWidget.getFlatButton(
                Text("Logout"),
                () {
                  showLogoutDialogue();
                },
              ),
              SizedBox(
                width: 15,
              )
            ],
          );
  }
}
