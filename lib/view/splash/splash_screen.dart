import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/splash/spalsh_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (c) => Container(
          child: ProgressHud(
        isLoading: false,
        child: Scaffold(
          body: Container(
            color: ChautariColors.primary,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  top: 100,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "चौतारी",
                      textAlign: TextAlign.center,
                      style: ChautariTextStyles()
                          .listTitle
                          .copyWith(fontSize: 35, color: Colors.white70),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 150,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "बस्ती",
                      textAlign: TextAlign.center,
                      style: ChautariTextStyles()
                          .listTitle
                          .copyWith(fontSize: 20, color: Colors.white70),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                          color: Colors.white24,
                          width: 200,
                          height: 200,
                          child: Image.asset(
                              "images/symmetric_transparent_chautari.png")),
                    ),
                  ],
                ),
                Positioned.fill(
                  bottom: Get.height / 2 - 150,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TyperAnimatedTextKit(
                      totalRepeatCount: 1,
                      speed: Duration(milliseconds: 140),
                      repeatForever: false,
                      onTap: () {
                        print("Tap Event");
                      },
                      text: ["तपाईंको दिन शुभ रहोस "],
                      textStyle: ChautariTextStyles().listTitle,
                      textAlign: TextAlign.start,
                    ),

                    // Text(
                    //   "Roots of Nepal",
                    //   textAlign: TextAlign.center,
                    //   style: ChautariTextStyles().listTitle,
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
