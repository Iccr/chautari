import 'package:chautari/model/conversation_model.dart';
import 'package:chautari/utilities/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class SocketController extends GetxController {
  PhoenixSocket _socket;
  PhoenixChannel _channel;
  final String token;
  final int conversationId;
  SocketController({@required this.token, @required this.conversationId}) {
    _initConnection(token);
  }
  var message = Messages().obs;

  @override
  onClose() {
    super.onClose();
    disconnect();
  }

  disconnect() {
    _socket.disconnect();
  }

  Future<PhoenixSocket> _initConnection(String token) async {
    _socket = new PhoenixSocket(BaseUrl().socketUrl,
        socketOptions: PhoenixSocketOptions(params: {"token": token}));
    await _socket.connect();
    return _socket;
  }

  initSocketAndListenChannel() async {
    _channel = _createChannel()..join();

    _channel?.on("shout", (payload, ref, joinRef) {
      this.message.value = Messages.fromJson(payload);
    });
  }

  String _getRoomName() {
    return "rent_room:$conversationId";
  }

  PhoenixChannel _createChannel() {
    return _socket.channel(_getRoomName(), {});
  }

  sendMessage(String message, int senderId) {
    if (message.isNotEmpty) {
      var _params = {
        "content": message,
        "sender_id": senderId,
        "conversation_id": conversationId
      };

      _channel?.push(
        event: "shout",
        payload: _params,
      );
    }
  }
}
