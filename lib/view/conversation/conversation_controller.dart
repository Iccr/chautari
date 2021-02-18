import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/chats/chat_view.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  AuthController auth = Get.find();

  Stream<List<MenuItem>> conversationListStream() {
    return FirebaseFirestore.instance
        .collection('conversations')
        .doc(auth.user.fuid)
        .collection("groupChatId")
        .snapshots()
        .map(
          (event) => {
            event.docs.map(
              (e) {
                var conversation = ConversationModel.fromJson(e.data(), e.id);
                return MenuItem(
                    title: conversation.idFrom,
                    subtitle: conversation.content,
                    extra: conversation.id,
                    fromId: conversation.idFrom,
                    toId: conversation.idTo);
              },
            ).toList()
          }.first,
        );
  }

  @override
  void onInit() async {
    super.onInit();

    List<String> ids = [];
  }

  onTapConversation(MenuItem item) {
    var viewModel = ChatViewModel(
      peerId: item.toId == auth.user.fuid ? item.fromId : item.toId,
      photoUrl: "",
    );
    Get.toNamed(RouteName.chat, arguments: viewModel);
  }
}

class ConversationModel {
  String id;
  String content;
  String idFrom;
  String idTo;
  String timestamp;
  bool seen;

  ConversationModel({
    this.id,
    this.content,
    this.idFrom,
    this.idTo,
    this.timestamp,
    this.seen,
  });

  ConversationModel.fromJson(Map<String, dynamic> jsn, String key) {
    id = key;
    content = jsn['content'];
    idFrom = jsn['idFrom'];
    idTo = jsn['idTo'];
    timestamp = jsn['timestamp'];
    seen = jsn["seen"];
  }
}
