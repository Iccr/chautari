import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/utilities/theme/theme_controller.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginView extends StatelessWidget {
  ThemeController theme = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: GetX<AuthController>(
          init: AuthController(),
          builder: (c) {
            return ProgressHud(
              isLoading: c.loading.value,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "After Login you are able to use many features of ",
                            style: ChautariTextStyles().listSubtitle,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: ChautariPadding.medium),
                          Text(
                            "Chautari Basti.",
                            style: ChautariTextStyles().listTitle.copyWith(
                                  color: ChautariColors.primaryColor(),
                                ),
                          ),
                          SizedBox(height: ChautariPadding.standard),
                          SizedBox(height: ChautariPadding.standard),
                        ],
                      ),
                    ),
                    SignInButton(
                      theme.mode == ThemeMode.dark
                          ? Buttons.GoogleDark
                          : Buttons.Google,
                      onPressed: () => c.gleSignIn(),
                    ),
                    SignInButton(
                      Buttons.FacebookNew,
                      onPressed: () => c.fbLogin(),
                    ),
                    SignInButton(
                      Buttons.AppleDark,
                      onPressed: () {
                        c.appleSignIn();
                      },
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
