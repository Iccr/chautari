import 'package:cached_network_image/cached_network_image.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'const.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatViewModel {
  final String peerId;
  final String peerPhoto;
  final String peerName;
  ChatViewModel({
    @required this.peerId,
    @required this.peerPhoto,
    @required this.peerName,
  });
}

class ChatController extends GetxController {
  AuthController auth = Get.find();
  var peerId = "".obs;

  var peerName = "".obs;
  var peerPhoto = "".obs;

  @override
  void onInit() {
    super.onInit();
    ChatViewModel viewModel = Get.arguments;
    peerId.value = viewModel.peerId;
    peerName.value = viewModel.peerName;
    peerPhoto.value = viewModel.peerPhoto;
  }
}

class Chat extends StatelessWidget {
  Chat({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<ChatController>(
      init: ChatController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            'CHAT',
            // style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ChatScreen(
          peerId: controller.peerId.value,
          peerAvatar: controller.peerPhoto.value,
          peerName: controller.peerName.value,
          peerPhoto: controller.peerPhoto.value,
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String peerId;
  final String peerAvatar;
  final String peerName;
  final String peerPhoto;

  ChatScreen(
      {Key key,
      @required this.peerId,
      @required this.peerAvatar,
      @required this.peerName,
      @required this.peerPhoto})
      : super(key: key);

  @override
  State createState() => ChatScreenState(
        peerId: peerId,
        peerAvatar: peerAvatar,
        peerName: this.peerName,
        peerPhoto: this.peerPhoto,
      );
}

class ChatScreenState extends State<ChatScreen> {
  final String peerId;
  final String peerAvatar;
  final String peerName;
  final String peerPhoto;
  ChatScreenState({
    Key key,
    @required this.peerId,
    @required this.peerAvatar,
    @required this.peerName,
    @required this.peerPhoto,
  });
  AuthController auth = Get.find();

  String fuid;

  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  int _limit = 20;
  final int _limitIncrement = 20;
  String groupChatId;
  SharedPreferences prefs;

  bool isLoading;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(_scrollListener);
    this.fuid = "${auth.user.id}";

    groupChatId = '';

    isLoading = false;

    readLocal();
    FirebaseFirestore.instance.collection('users').doc(fuid ?? "").update(
      {'chattingWith': peerId},
    );
  }

  readLocal() async {
    fuid = "${auth.user.id}" ?? '';
    if (fuid.hashCode <= peerId.hashCode) {
      groupChatId = '$fuid-$peerId';
    } else {
      groupChatId = '$peerId-$fuid';
    }
  }

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the bottom");
      setState(() {
        print("reach the bottom");
        _limit += _limitIncrement;
      });
    }
    if (listScrollController.offset <=
            listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the top");
      setState(() {
        print("reach the top");
      });
    }
  }

  void onSendMessage({
    @required String content,
    @required String myId,
    @required String myName,
    @required String peerId,
    @required String peerName,
    @required String fromPhoto,
    @required String toPhoto,
  }) {
    if (content.trim() != '') {
      textEditingController.clear();

      var rootRef = FirebaseFirestore.instance;

      var params = {
        'groupChatId': groupChatId,
        'idFrom': fuid,
        'fromName': myName,
        'idTo': peerId,
        'toName': peerName,
        'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
        'content': content,
        'fimg': fromPhoto,
        'timg': toPhoto,
        'seen': false
      };

      var convesationRef1 = rootRef
          .collection("conversations")
          .doc(myId)
          .collection("groupChatId")
          .doc(groupChatId)
          .set(params);

      var convesationRef2 = rootRef
          .collection("conversations")
          .doc(peerId)
          .collection("groupChatId")
          .doc(groupChatId)
          .set(params);

      //   .set(
      // {"groupChatId": groupChatId},

      var documentReference1 = rootRef
          .collection('chats')
          .doc(myId)
          .collection("conversations")
          .doc(groupChatId)
          .collection("messages")
          .doc(
            DateTime.now().millisecondsSinceEpoch.toString(),
          );

      var documentReference2 = rootRef
          .collection('chats')
          .doc(peerId)
          .collection("conversations")
          .doc(groupChatId)
          .collection("messages")
          .doc(
            DateTime.now().millisecondsSinceEpoch.toString(),
          );

      FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          transaction.set(
            documentReference1,
            {
              'idFrom': fuid,
              'idTo': peerId,
              'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
              'content': content,
            },
          );

          transaction.set(
            documentReference2,
            {
              'idFrom': fuid,
              'idTo': peerId,
              'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
              'content': content,
            },
          );
        },
      );

      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document.data()['idFrom'] == fuid) {
      // Right (my message)
      return Row(
        children: <Widget>[
          // Text
          Container(
            child: Text(
              document.data()['content'],
              style: TextStyle(color: primaryColor),
            ),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 200.0,
            decoration: BoxDecoration(
                color: greyColor2, borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(
                bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      // document.reference.update({"seen": true});
      //   var convesationRef2 = rootRef

      // .collection("conversations")
      // .doc(peerId)
      // .collection("groupChatId")
      // .doc(groupChatId)
      // .set(params);
      var fromId = document.data()['idFrom'];
      var peerId = document.data()['idTo'];
      var groupId = document.reference.parent.parent.id;
      var rootref = FirebaseFirestore.instance.collection("conversations");

      rootref
          .doc(peerId)
          .collection("groupChatId")
          .doc(groupId)
          .update({"seen": true});

      rootref
          .doc(fromId)
          .collection("groupChatId")
          .doc(groupId)
          .update({"seen": true});

      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                    ? Material(
                        child: CachedNetworkImage(
                          // placeholder: (context, url) =>
                          // ClipOval(
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       color: ChautariColors.primary,
                          //     ),
                          //     width: 35.0,
                          //     height: 35.0,
                          //     padding: EdgeInsets.all(10.0),
                          //   ),
                          // ),
                          imageUrl: peerAvatar,
                          width: 35.0,
                          height: 35.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      )
                    : Container(width: 35.0),
                Container(
                  child: Text(
                    document.data()['content'],
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(left: 10.0),
                )
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document.data()['timestamp']))),
                      style: TextStyle(
                          color: greyColor,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].data()['idFrom'] == fuid) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].data()['idFrom'] != fuid) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<QuerySnapshot> checkReferenceExist() {
    return FirebaseFirestore.instance.collection("chats").get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: checkReferenceExist(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    // List of messages

                    buildListMessage(),
                    buildInput()
                  ],
                ),
                // Loading
                // buildLoading()
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Widget buildInput() {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: greyColor2, width: 0.5)),
            color: Colors.white),
        // padding: EdgeInsets.all(ChautariPadding.standard),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Button send image

            // Edit text
            Flexible(
              child: Container(
                padding: EdgeInsets.only(left: ChautariPadding.standard),
                child: TextField(
                  autocorrect: false,
                  cursorColor: ChautariColors.primary,
                  onSubmitted: (value) {
                    onSendMessage(
                      content: textEditingController.text,
                      myId: auth.user.id.toString(),
                      myName: auth.user.name,
                      peerId: this.peerId,
                      peerName: this.peerName,
                      toPhoto: this.peerPhoto,
                      fromPhoto: auth.user.imageurl,
                    );
                  },
                  style: ChautariTextStyles()
                      .listSubtitle
                      .copyWith(color: ChautariColors.black),
                  controller: textEditingController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Type your message...',
                    // hintStyle: TextStyle(color: greyColor),
                    hintStyle: ChautariTextStyles()
                        .listSubtitle
                        .copyWith(fontSize: 13, color: ChautariColors.grey),
                  ),
                  focusNode: focusNode,
                ),
              ),
            ),

            // Button send message
            Container(
              margin: EdgeInsets.only(right: ChautariPadding.standard),
              child: IconButton(
                color: ChautariColors.brown,
                icon: Icon(Icons.send),
                onPressed: () => onSendMessage(
                  content: textEditingController.text,
                  myId: auth.user.id.toString(),
                  peerId: this.peerId,
                  myName: auth.user.name,
                  peerName: peerName,
                  toPhoto: this.peerPhoto,
                  fromPhoto: auth.user.imageurl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId == ''
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themeColor),
              ),
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(auth.user.id.toString())
                  .collection('conversations')
                  .doc(groupChatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .limit(_limit)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(themeColor)));
                } else {
                  listMessage.addAll(snapshot.data.docs);
                  int count = snapshot.data.docs.length;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildItem(index, snapshot.data.docs[index]),
                    itemCount: count,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }
}
