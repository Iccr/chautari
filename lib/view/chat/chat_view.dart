import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/chat/bubble.dart';
import 'package:chautari/view/chat/chat_controller.dart';
import 'package:chautari/view/login/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());
  AuthController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Chautari Basti'),
      ),
      body: Container(
        // color: Colors.yellow.withAlpha(64),
        color: ChautariColors.primary.withAlpha(64),
        // color: ChautariColors.primary.withAlpha(64),
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(8.0),
                  children: controller.messages
                      .map((element) => Bubble(
                            style: element.senderId == auth.user.id
                                ? styleMe
                                : styleSomebody,
                            child: Text(
                              element.content,
                              style: ChautariTextStyles().listSubtitle,
                            ),
                          ))
                      .toList(),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 49),
                child: Row(
                  children: [
                    SizedBox(width: ChautariPadding.standard),
                    Expanded(
                      child: TextField(
                          controller: controller.messageTextField,
                          decoration:
                              ChautariDecoration().outlinedBorderTextField()),
                    ),
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () => {controller.sendMessage()})
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
