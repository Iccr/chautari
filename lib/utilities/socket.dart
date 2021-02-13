import 'dart:convert';

import 'package:chautari/model/conversation_model.dart';
import 'package:chautari/model/presence_model.dart';
import 'package:chautari/utilities/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class PresenceService extends GetxService {
  var presence = {}.obs;

  joined(PresenceModel user) {
    presence["${user.metas.first.userId}"] = user;
    print("joined: ${user.metas.first.userId}");
  }

  leave(PresenceModel user) {
    if (presence.containsKey("${user.metas.first.userId}")) {
      presence.remove("${user.metas.first.userId}");
    }
  }
}

class SocketController extends GetxController {
  PhoenixSocket _socket;
  PhoenixChannel _channel;
  final String token;
  final int conversationId;
  final PresenceService presences = Get.find();

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

  onJoin(String key, dynamic currentPresence, dynamic newPresence) {
    var jsn = jsonDecode(jsonEncode(newPresence));
    var presenceModel = PresenceModel.fromJson(jsn);
    presences.joined(presenceModel);
  }

  onLeave(String key, dynamic currentPresence, dynamic newPresence) {
    var jsn = jsonDecode(jsonEncode(newPresence));
    var presenceModel = PresenceModel.fromJson(jsn);
    presences.leave(presenceModel);
  }

  initSocketAndListenChannel() async {
    _channel = _createChannel();

    _channel?.on("shout", (payload, ref, joinRef) {
      this.message.value = Messages.fromJson(payload);
    });

    _channel.on("presence_state", (payload, ref, joinRef) {
      PhoenixPresence.syncState(
          presences.presence.value, payload, onJoin, onLeave);
    });

    _channel.on("presence_diff", (payload, ref, joinRef) {
      print("presence_diff");
      PhoenixPresence.syncDiff(
          presences.presence.value, payload, onJoin, onLeave);
    });

    _channel.join();
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
