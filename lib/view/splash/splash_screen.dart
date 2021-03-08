import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/splash/spalsh_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatelessWidget {
  SplashController controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return ProgressHud(
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
                        child: Image.asset("images/tree_logo.png")),
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
                ),
              ),
              Positioned.fill(
                bottom: 60,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Obx(() => Text(controller.versionlabel.value)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
