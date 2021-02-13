import 'package:chautari/model/conversation_model.dart';
import 'package:chautari/services/new_conversations.dart';
import 'package:chautari/utilities/socket.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatViewModel {
  List<Conversation> conversation;
  List<Messages> messages;
  int recipient;
}

class ChatController extends GetxController {
  int recipient;

  RxMap<dynamic, dynamic> _presence;
  PresenceService presence = Get.find();
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
    _presence = presence.presence;
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
    SocketController _socket = Get.find();
    _socket.conversationId = conversation.first.id;
    socket = _socket;

    await socket.initAndListenChannel();

    socket.message.listen((message) async {
      this.messages.add(message);
      await scrollToLast();
    });
  }

  isOnline() {
    return _presence.containsKey("${conversation.first.senderId}");
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

    // socket?.disconnect();
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
    await Future.delayed(Duration(milliseconds: 200));
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }
}
