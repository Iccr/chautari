import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/chats/chat_view.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  AuthController auth = Get.find();
  List<ConversationModel> conversations = [];

  Stream<List<ChatMenuItem>> conversationListStream() {
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
                conversations.add(conversation);

                return ChatMenuItem(
                  title: (conversation.toName ?? "unknown"),
                  subtitle: conversation.content,
                  extra: conversation.id,
                  fromId: conversation.idFrom,
                  toId: conversation.idTo,
                  fromName: conversation.fromName,
                  toName: conversation.toName,
                  image1: auth.user.fuid == conversation.idFrom
                      ? conversation.toPhoto
                      : conversation.fromPhoto,
                  image2: conversation.toPhoto,
                  seen: conversation.seen,
                );
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

  onTapConversation(ChatMenuItem item) {
    var c =
        this.conversations.firstWhere((element) => element.id == item.extra);
    var mine = c.idTo == auth.user.fuid;
    var viewModel = ChatViewModel(
      peerId: mine ? c.idFrom : item.toId,
      peerPhoto: mine ? c.fromPhoto : c.toPhoto,
      peerName: mine ? c.fromName : c.toName,
    );
    Get.toNamed(RouteName.chat, arguments: viewModel);
  }
}

class ConversationModel {
  String id;
  String content;
  String idFrom;
  String fromName;
  String idTo;
  String fromPhoto;
  String toPhoto;
  String toName;
  String timestamp;
  bool seen;

  ConversationModel({
    this.id,
    this.content,
    this.idFrom,
    this.idTo,
    this.timestamp,
    this.seen,
    this.fromName,
    this.toName,
    this.fromPhoto,
    this.toPhoto,
  });

  ConversationModel.fromJson(Map<String, dynamic> jsn, String key) {
    id = key;
    content = jsn['content'];
    idFrom = jsn['idFrom'];
    idTo = jsn['idTo'];
    timestamp = jsn['timestamp'];
    seen = jsn["seen"];
    fromName = jsn['fromName'];
    toName = jsn["toName"];
    fromPhoto = jsn["fimg"];
    toPhoto = jsn["timg"];
  }
}
