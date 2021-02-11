import 'package:chautari/model/error.dart';

class ChatResponseModel {
  List<Conversation> conversations = List<Conversation>();
  List<ApiError> errors;

  ChatResponseModel({this.conversations});

  ChatResponseModel.fromJson(Map<String, dynamic> json) {
    // conversations =
    // json['data'] != null ? new AppinfoModel.fromJson(json['data']) : null;

    if (json['data'] != null) {
      json['data'].forEach(
        (e) => conversations.add(
          Conversation.fromJson(e),
        ),
      );
    }

    if (json['error'] != null) {
      errors = new List<ApiError>();
      json['error'].forEach((v) {
        errors.add(new ApiError.fromJson(v));
      });
    }
  }
}

class CreateConversationResponseModel {
  Conversation conversation;
  List<ApiError> errors;

  CreateConversationResponseModel({this.conversation});

  CreateConversationResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      conversation = Conversation.fromJson(json['data']);
    }

    if (json['error'] != null) {
      errors = new List<ApiError>();
      json['error'].forEach((v) {
        errors.add(new ApiError.fromJson(v));
      });
    }
  }
}

class Conversation {
  int id;
  int recipientId;
  int senderId;
  List<Messages> messages;

  Conversation({this.id, this.recipientId, this.senderId});

  Conversation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recipientId = json['recipient_id'];
    senderId = json['sender_id'];
    if (json['messages'] != null) {
      messages = new List<Messages>();
      json['messages'].forEach((v) {
        messages.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['recipient_id'] = this.recipientId;
    return data;
  }

  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is Amenities &&
  //         runtimeType == other.runtimeType &&
  //         id == other.id &&
  //         tag == other.tag;

  // @override
  // int get hashCode => tag.hashCode;
}

class Messages {
  String content;
  int conversationId;
  int senderId;

  Messages({this.content, this.conversationId, this.senderId});

  Messages.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    conversationId = json['conversation_id'];
    senderId = json['sender_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['conversation_id'] = this.conversationId;
    data['sender_id'] = this.senderId;
    return data;
  }
}
