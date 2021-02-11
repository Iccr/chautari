import 'package:chautari/services/new_conversations.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class ChatController extends GetxController {
  AuthController auth = Get.find();
  PhoenixSocket _socket;
  PhoenixChannel _channel;
  NewConversationService newConversationService;
  TextEditingController messageTextField;
  var messages = List<ChatMessages>().obs;
  var isLoading = false.obs;
  var _error = "".obs;

  String get error => _error.value;

  @override
  void onInit() async {
    super.onInit();
    messageTextField = TextEditingController();

    newConversationService = NewConversationService();
    isLoading = newConversationService.isLoading;

    newConversationService.isSuccess.listen((value) async {
      if (value) {
        var socket = await _initConnection();
        _channel = _createChannel(socket)..join();
        _channel.on("shout", (payload, ref, joinRef) {
          print(payload);
          var message = ChatMessages.fromJson(payload);
          messages.add(message);
          messages.refresh();
        });
      }
    });
  }

  PhoenixChannel _createChannel(PhoenixSocket socket) {
    return socket.channel("rent_room:lobby", {});
  }

  Future<PhoenixSocket> _initConnection() async {
    _socket = new PhoenixSocket("ws://localhost:4000/socket/websocket",
        socketOptions:
            PhoenixSocketOptions(params: {"token": auth.user.token ?? ""}));
    await _socket.connect();
  }

  @override
  void onClose() {
    super.onClose();
    _socket.disconnect();
  }

  _fetchConversation() {}

  sendMessage() {
    var message = messageTextField.text;
    if (message.isNotEmpty) {
      var _params = {
        "message": message,
        "sender_id": auth?.user?.id ?? "",
        "conversation_id": newConversationService.conversation.value.id
      };

      _channel?.push(
        event: "shout",
        payload: _params,
      );
    }
    //   var _message = ChatMessages(message: message, isMine: true);
    //   // _channel.push(event: "ping", payload: {"message": message});
    //   messages.add(_message);
    //   messages.refresh();
    //   messageTextField.clear();
    // }
  }

  _fakeMessages() {
    var messages = [
      ChatMessages(message: "hello is this room still available", isMine: true),
      ChatMessages(message: "hi, Yes this is still available", isMine: false),
      ChatMessages(message: "hello is this room still available", isMine: true),
      ChatMessages(message: "hi, Yes this is still available", isMine: false),
    ];

    this.messages.assignAll(messages);
  }
}

class ChatMessages {
  String message;
  bool isMine;
  ChatMessages({@required this.message, this.isMine = false});

  ChatMessages.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    isMine = false;
  }
}
