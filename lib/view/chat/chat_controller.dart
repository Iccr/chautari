import 'package:chautari/model/conversation_model.dart';
import 'package:chautari/model/login_model.dart';
import 'package:chautari/services/fetch_conversations.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/external/platform_check/platform_check.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class ChatController extends GetxController {
  UserModel owner;
  AuthController auth = Get.find();
  PhoenixSocket _socket;
  PhoenixChannel _channel;
  FetchConversatiosnService conversationService;
  TextEditingController messageTextField;
  var messages = List<Messages>().obs;
  var isLoading = false.obs;
  var _error = "".obs;

  String get error => _error.value;

  @override
  void onInit() async {
    super.onInit();
    owner = Get.arguments;
    messageTextField = TextEditingController();

    conversationService = FetchConversatiosnService();
    isLoading = conversationService.isLoading;
    conversationService.createConversation(auth.user.id, owner.id);

    conversationService.isSuccess.listen((value) async {
      if (value) {
        messages.assignAll(conversationService.conversation.first.messages);
        var socket = await _initConnection();
        _channel = _createChannel(socket)..join();

        _channel?.on("shout", (payload, ref, joinRef) {
          print(payload);
          var message = Messages.fromJson(payload);

          messages.add(message);
          messages.refresh();
        });
      }
    });
  }

  String _get_room_name() {
    if (auth?.user?.id != null &&
        conversationService?.conversation?.first?.id != null) {
      return "rent_room:" + ("${conversationService.conversation.first.id}");
    }
  }

  PhoenixChannel _createChannel(PhoenixSocket socket) {
    return socket.channel(_get_room_name(), {});
  }

  Future<PhoenixSocket> _initConnection() async {
    if (PlatformCheck.isIOS) {
      _socket = new PhoenixSocket("ws://localhost:4000/socket/websocket",
          socketOptions:
              PhoenixSocketOptions(params: {"token": auth.user.token ?? ""}));
    } else {
      _socket = new PhoenixSocket("ws://10.0.2.2:4000/socket/websocket",
          socketOptions:
              PhoenixSocketOptions(params: {"token": auth.user.token ?? ""}));
    }

    await _socket.connect();
    return _socket;
  }

  @override
  void onClose() {
    super.onClose();
    _socket?.disconnect();
  }

  sendMessage() {
    var message = messageTextField.text;
    if (message.isNotEmpty) {
      var _params = {
        "content": message,
        "sender_id": auth?.user?.id ?? "",
        "conversation_id": conversationService.conversation.value.first.id
      };

      _channel?.push(
        event: "shout",
        payload: _params,
      );
    }
  }
}
