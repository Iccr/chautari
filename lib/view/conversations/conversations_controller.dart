import 'package:chautari/model/conversation_model.dart';
import 'package:chautari/model/menu_item.dart';
import 'package:chautari/services/fetch_conversations.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/utilities/socket.dart';
import 'package:chautari/view/chat/chat_controller.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:get/get.dart';

class ConversationsController extends GetxController {
  RxMap<dynamic, dynamic> _presence;
  final PresenceService presenceService = Get.find();
  FetchConversatiosnService conversationService;
  AuthController auth;
  var isLoading = false.obs;
  var error = "".obs;
  var conversations = List<Conversation>().obs;

  List<MenuItem> get conversationViewModel => conversations
      .map((element) => MenuItem(
          index: element.senderId,
          title: "${element.senderName}",
          subtitle:
              element.messages.isEmpty ? "" : element.messages.last.content))
      .toList();

  @override
  void onInit() {
    super.onInit();
    auth = Get.find();
    _presence = presenceService.presence;
    conversationService = FetchConversatiosnService();
    isLoading = conversationService.isLoading;
    conversationService.fetchConversation();
    conversationService.isSuccess.listen((value) {
      if (value) {
        conversations.assignAll(conversationService.conversation.value);
        conversations.refresh();
      } else {
        error.value = conversationService.error;
      }
    });
  }

  isOnline(int id) {
    return _presence.containsKey("$id");
  }

  goToChats(int index) {
    var viewModel = ChatViewModel();
    viewModel.conversation = conversations.value;
    viewModel.recipient = conversations.elementAt(index).recipientId;
    viewModel.messages = conversations.elementAt(index).messages;

    Get.toNamed(RouteName.chat, arguments: viewModel);
  }
}
