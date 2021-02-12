import 'package:chautari/model/conversation_model.dart';
import 'package:chautari/services/new_conversations.dart';
import 'package:chautari/utilities/api_service.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/external/platform_check/platform_check.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class ChatViewModel {
  List<Conversation> conversation;
  List<Messages> messages;
  int recipient;
}

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

class ChatController extends GetxController {
  int recipient;
  AuthController auth = Get.find();
  NewConversatiosnService conversationService;
  TextEditingController messageTextField;

  SocketController socket;

  final ScrollController scrollController = ScrollController();

  ChatViewModel _viewModel;
  var messages = List<Messages>().obs;

  var conversation = List<Conversation>().obs;

  var isLoading = false.obs;
  var _error = "".obs;

  String get error => _error.value;

  @override
  void onInit() async {
    super.onInit();
    _viewModel = Get.arguments;
    recipient = _viewModel.recipient;
    if (_viewModel.conversation != null) {
      updateConversation(_viewModel.conversation);
    }

    if (_viewModel.messages != null) {
      updateMessages(_viewModel.messages);
    }

    messageTextField = TextEditingController();
    if (conversation.isEmpty && messages.isEmpty) {
      fetchConversations();
    } else {
      initsocket();
    }
  }

  initsocket() async {
    print("init socket");
    socket = SocketController(
        token: auth.token, conversationId: conversation.first.id);
    await socket.initSocketAndListenChannel();
    socket.message.listen((message) async {
      this.messages.add(message);
      await scrollToLast();
    });
  }

  fetchConversations() {
    conversationService = NewConversatiosnService();
    isLoading = conversationService.isLoading;
    conversationService.createConversation(auth.user.id, recipient);
    conversationService.isSuccess.listen((value) async {
      if (value) {
        updateConversation(conversationService.conversation.value);
        updateMessages(conversationService.conversation.first.messages);
        await initsocket();
      }
    });
  }

  updateConversation(List<Conversation> conversations) {
    this.conversation.assignAll(conversations);
    this.conversation.refresh();
  }

  updateMessages(List<Messages> messages) async {
    this.messages.assignAll(messages);

    await Future.delayed(Duration(milliseconds: 100));
    scrollToLast();
  }

  @override
  void onClose() {
    super.onClose();
    socket?.disconnect();
  }

  sendMessage() {
    var message = messageTextField.text;
    if (message.isNotEmpty) {
      if (auth?.user?.id != null) {
        socket.sendMessage(message, auth?.user?.id);
        messageTextField.clear();
      }
    }
  }

  scrollToLast() async {
    print("scrolling to last");
    await Future.delayed(Duration(milliseconds: 200));
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }
}
