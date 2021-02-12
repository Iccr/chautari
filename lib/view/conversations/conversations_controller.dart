import 'package:chautari/model/conversation_model.dart';
import 'package:chautari/model/menu_item.dart';
import 'package:chautari/services/fetch_conversations.dart';
import 'package:get/get.dart';

class ConversationsController extends GetxController {
  FetchConversatiosnService conversationService;
  var isLoading = false.obs;
  var error = "".obs;
  var conversations = List<Conversation>().obs;

  List<MenuItem> get conversationViewModel => conversations
      .map((element) => MenuItem(
          title: "${element.senderName}",
          subtitle:
              element.messages.isEmpty ? "" : element.messages.last.content))
      .toList();

  @override
  void onInit() {
    super.onInit();
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
}
