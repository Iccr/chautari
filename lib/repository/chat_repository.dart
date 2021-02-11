import 'package:chautari/model/conversation_model.dart';
import 'package:chautari/utilities/api_service.dart';

class ChatRepository {
  final String _chatUrl = "/chats";

  ApiService api;
  ChatRepository() {
    api = ApiService();
  }

  Future<ChatResponseModel> fetchConversations() async {
    final response = await api.get(_chatUrl);
    return ChatResponseModel.fromJson(response.data);
  }

  Future<CreateConversationResponseModel> newConversations(
      Map<String, dynamic> params) async {
    final response = await api.post(_chatUrl, params);
    return CreateConversationResponseModel.fromJson(response.data);
  }
}
