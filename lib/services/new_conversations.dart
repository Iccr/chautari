import 'package:chautari/model/conversation_model.dart';
import 'package:chautari/repository/chat_repository.dart';
import 'package:get/get.dart';

class NewConversationService extends GetxController {
  var conversation = Conversation().obs;
  var isLoading = false.obs;
  var _error = "".obs;

  var isSuccess = false.obs;

  String get error => _error.value.isEmpty ? null : _error.value;

  createConversation(int senderId, int recipientId) async {
    isLoading.value = true;
    var params = {"sender_id": senderId, "recipient_id": recipientId};

    var model = await ChatRepository().newConversations(params);

    isLoading.value = false;
    if (model.errors?.isEmpty ?? false) {
      this._error.value = model.errors?.first?.value;
    } else {
      this.conversation.value = model.conversation;
      isSuccess.value = true;
    }
  }
}
