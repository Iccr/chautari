import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

class ChatController extends GetxController {
  PhoenixSocket _socket;
  PhoenixChannel _channel;
  TextEditingController messageTextField;
  var messages = List<ChatMessages>().obs;

  @override
  void onInit() async {
    super.onInit();

    messageTextField = TextEditingController();

    _socket = new PhoenixSocket("ws://localhost:4000/socket/websocket",
        socketOptions: PhoenixSocketOptions(params: {"token": "blabla"}));

    _socket.connect();

    _socket.openStream.listen((event) {
      print("connected");
    });

    // await _socket.connect();
    // // _channel = _socket.channel("rent_room:lobby", {});
    // // _channel.on("shout", (payload, ref, joinRef) {
    // //   print(payload);
    // //   print(ref);
    // //   print(joinRef);
    // //   var message = ChatMessages.fromJson(payload);
    // //   this.messages.add(message);
    // //   this.messages.refresh();
    // // });

    // // _channel.join();

    _fakeMessages();
  }

  @override
  void onClose() {
    super.onClose();
    _socket.close();
    // var value = _socket.disconnect();
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
