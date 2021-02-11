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
    json['data'] != null ? Conversation.fromJson(json['data']) : null;

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
  String recipientId;
  int senderId;

  Conversation({this.id, this.recipientId, this.senderId});

  Conversation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recipientId = json['recipient_id'];
    senderId = json['sender_id'];
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
