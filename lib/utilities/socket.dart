import 'dart:convert';

import 'package:chautari/model/conversation_model.dart';
import 'package:chautari/model/presence_model.dart';
import 'package:chautari/utilities/api_service.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:get/get.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class PresenceService extends GetxService {
  var presence = {}.obs;

  Future<PresenceService> init() async {
    return this;
  }

  joined(PresenceModel user) {
    presence.value["${user.metas.first.userId}"] = user;
    print("joined: ${user.metas.first.userId}");
    presence.refresh();
  }

  leave(PresenceModel user) {
    if (presence.value.containsKey("${user.metas.first.userId}")) {
      presence.value.remove("${user.metas.first.userId}");
      print("leaved: ${user.metas.first.userId}");
      presence.refresh();
    }
  }

  isPresent(int userId) {
    return presence.containsKey("$userId");
  }
}

class SocketController extends GetxService {
  PhoenixSocket _socket;
  PhoenixChannel _channel;

  int conversationId;
  final PresenceService presences = Get.find();
  AuthController auth = Get.find();

  var message = Messages().obs;

  Future<SocketController> init() async {
    initSocket();

    return this;
  }

  @override
  onClose() {
    super.onClose();
    disconnect();
  }

  disconnect() {
    _socket?.disconnect();
  }

  initSocket() {
    if (auth.isLoggedIn.isTrue) {
      _initConnection(auth.user.token);
    } else {
      auth.isLoggedIn.listen((value) {
        if (value) {
          _initConnection(auth.user.token);
        }
      });
    }
  }

  Future<PhoenixSocket> _initConnection(String token) async {
    _socket = new PhoenixSocket(
      BaseUrl().socketUrl,
      socketOptions: PhoenixSocketOptions(
          params: {"token": token}, timeout: 10000, heartbeatIntervalMs: 30000),
    );
    await _socket.connect();
    print("socket connected");
    suscribeToPresence(auth.user.id);
    return _socket;
  }

  onJoin(dynamic newPresence) {
    if (newPresence == null) {
      return;
    }

    var jsn = jsonDecode(jsonEncode(newPresence));
    if (jsn.isNotEmpty) {
      if (jsn.keys.first != null) {
        var presenceModel = PresenceModel.fromJson(jsn[jsn.keys.first]);
        presences.joined(presenceModel);
      }
    }
  }

  onLeave(dynamic newPresence) {
    if (newPresence == null) {
      return;
    }
    var jsn = jsonDecode(jsonEncode(newPresence));
    if (jsn.isNotEmpty) {
      if (jsn.keys.first != null) {
        var presenceModel = PresenceModel.fromJson(jsn[jsn.keys.first]);
        presences.leave(presenceModel);
      }
    }
  }

  initAndListenChannel() async {
    _channel = _createChannel("rent_room:$conversationId");

    _channel?.on("shout", (payload, ref, joinRef) {
      this.message.value = Messages.fromJson(payload);
    });

    _channel.join();
  }

  suscribeToPresence(int userId) {
    _channel = _createChannel("user_room:loby");
    _channel.on("presence_state", (payload, ref, joinRef) {
      PhoenixPresence.syncState({}, payload, null, null);
      print(payload);
      onJoin(payload);
    });

    _channel.on("presence_diff", (payload, ref, joinRef) {
      PhoenixPresence.syncDiff({}, payload, null, null);
      print(payload);
      onJoin(payload["joins"]);
      onLeave(payload["leaves"]);
    });

    _channel.join();
  }

  PhoenixChannel _createChannel(String name) {
    return _socket.channel(name, {});
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
