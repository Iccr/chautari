import 'package:chautari/view/login/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  AuthController auth = Get.find();

  var groupChatId = "".obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    List<String> ids = [];
    var result = await FirebaseFirestore.instance
        .collection('conversations')
        .doc(auth.user.fuid)
        .collection("groupChatId")
        // .doc("Ygm7CR2Uyea37Tfn7XeJYQSxAwv1-q3dlGmEvcZQl6aEDeDMpghcPoND2")
        .get();

    groupChatId.value = result.docs.first.id;

    // .doc(groupChatId)
    // .collection('messages')
    // .orderBy('timestamp', descending: true)
    // .limit(_limit)
    // .snapshots(),
  }
}

class ConversationModel {
  String goupChatId;
  String content;
  String idFrom;
  String idTo;
  String timestamp;
  bool seen;

  ConversationModel({
    this.goupChatId,
    this.content,
    this.idFrom,
    this.idTo,
    this.timestamp,
    this.seen,
  });

  ConversationModel.fromJson(Map<String, dynamic> jsn, String key) {
    goupChatId = key;
    content = jsn['content'];
    idFrom = jsn['idFrom'];
    idTo = jsn['idTo'];
    timestamp = jsn['timestamp'];
    seen = jsn["seen"];
  }
}
