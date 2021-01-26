import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
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
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (c) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("After Login you are able to use many features of "),
                  Text(
                    "Chautari Basti.",
                    style: TextStyle(
                      color: ChautariColors.primaryColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: ChautariPadding.standard),
                ],
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
