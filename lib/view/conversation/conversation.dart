import 'package:chautari/model/menu_item.dart';
import 'package:chautari/view/chats/const.dart';
import 'package:chautari/view/conversation/conversation_controller.dart';
import 'package:chautari/widgets/chautari_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Conversation extends StatelessWidget {
  ConversationController controller = Get.put(ConversationController());
  @override
  Future<QuerySnapshot> checkReferenceExist() {
    return FirebaseFirestore.instance.collection("chats").get();
  }

  @override
  Widget build(BuildContext context) {
    List<MenuItem> listMessage = new List.from([]);

    return GetX<ConversationController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("conversations"),
        ),
        body: controller.groupChatId.value.isEmpty
            ? Container()
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('conversations')
                    .doc(controller.auth.user.fuid)
                    .collection("groupChatId")
                    .doc(controller.groupChatId.value)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      var conversation = ConversationModel.fromJson(
                        snapshot.data.data(),
                        snapshot.data.id,
                      );
                      print(conversation);
                      listMessage.add(MenuItem(
                          title: conversation.idFrom,
                          subtitle: conversation.content));

                      return ListView.separated(
                          itemCount: listMessage.length,
                          separatorBuilder: (context, index) {
                            return ChautariList().getSeperator();
                          },
                          itemBuilder: (context, index) {
                            return ChautariList().getListTile(
                                () {}, listMessage.elementAt(index));
                          });
                    }
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(themeColor)));
                  }
                },
              ),
      ),
    );
  }

  // return FutureBuilder<QuerySnapshot>(
  //     future: checkReferenceExist(),
  //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.hasData) {
  //         return Stack(
  //           children: <Widget>[
  //             Column(
  //               children: <Widget>[
  //                 // List of messages

  //                 buildListMessage(),
  //                 buildInput()
  //               ],
  //             ),
  //             // Loading
  //             // buildLoading()
  //           ],
  //         );
  //       } else {
  //         return Container();
  //       }
  //     });
  // }
}
