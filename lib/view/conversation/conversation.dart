import 'package:cached_network_image/cached_network_image.dart';
import 'package:chautari/model/menu_item.dart';
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

    Widget buildList(List<ChatMenuItem> models) {
      return ListView.separated(
          itemCount: models.length,
          separatorBuilder: (context, index) {
            return ChautariList().getSeperator();
          },
          itemBuilder: (context, index) {
            var item = models.elementAt(index);
            return ChautariList().getChatListTile(
              () {
                controller.onTapConversation(models.elementAt(index));
              },
              models.elementAt(index),
              leading: CachedNetworkImage(
                imageUrl: item.image1 ??
                    "https://picsum.photos/seed/picsum/50?grayscale",
              ),
            );
          });
    }

    // Widget buildStream() {
    //      StreamBuilder<List<ChatMenuItem>>(
    //       stream: controller.conversationListStream(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.active) {
    //           if (!snapshot.hasData) {
    //             return Container();
    //           } else if (snapshot.connectionState == ConnectionState.done) {
    //           } else {
    //             return ListView.separated(
    //                 itemCount: snapshot.data.length,
    //                 separatorBuilder: (context, index) {
    //                   return ChautariList().getSeperator();
    //                 },
    //                 itemBuilder: (context, index) {
    //                   var item = snapshot.data.elementAt(index);
    //                   return ChautariList().getChatListTile(
    //                     () {
    //                       controller.onTapConversation(
    //                           snapshot.data.elementAt(index));
    //                     },
    //                     snapshot.data.elementAt(index),
    //                     leading: CachedNetworkImage(
    //                       imageUrl: item.image1 ??
    //                           "https://picsum.photos/seed/picsum/50?grayscale",
    //                     ),
    //                   );
    //                 });
    //           }
    //         } else {
    //           return Center(
    //               child: CircularProgressIndicator(
    //                   valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
    //         }
    //       },
    //     );
    // }

    return GetX<ConversationController>(
      builder: (controller) => Scaffold(
          appBar: AppBar(
            title: Text("Conversations"),
          ),
          body: FutureBuilder<List<ChatMenuItem>>(
            initialData: [],
            future: controller.getConversation(),
            builder: (context, snapshot) => snapshot.data.isNotEmpty
                ? buildList(snapshot.data)
                : const SizedBox(),
          )),
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
