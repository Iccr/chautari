import 'package:chautari/view/login/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class ChatController extends GetxController {
  AuthController auth = Get.find();
  PhoenixSocket _socket;
  PhoenixChannel _channel;
  TextEditingController messageTextField;
  var messages = List<ChatMessages>().obs;

  @override
  void onInit() async {
    super.onInit();
    var token = auth.user.token ?? "";

    messageTextField = TextEditingController();

    _socket = new PhoenixSocket("ws://localhost:4000/socket/websocket",
        socketOptions: PhoenixSocketOptions(params: {"token": token}));

    await _socket.connect();
    // _channel = _socket.channel("rent_room:lobby", {});
    // _channel.on("shout", (payload, ref, joinRef) {
    //   print(payload);
    //   print(ref);
    //   print(joinRef);
    //   var message = ChatMessages.fromJson(payload);
    //   this.messages.add(message);
    //   this.messages.refresh();
    // }
    // );

    // _channel.join();

    _fakeMessages();
  }

  @override
  void onClose() {
    super.onClose();

    _socket.disconnect();
  }

  sendMessage() {
    var message = messageTextField.text;

    if (message.isNotEmpty) {
      var _message = ChatMessages(message: message, isMine: true);
      // _channel.push(event: "ping", payload: {"message": message});
      messages.add(_message);
      messages.refresh();
      messageTextField.clear();
    }
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
