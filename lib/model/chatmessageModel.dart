// To parse this JSON data, do
//
//     final chatMessagesModels = chatMessagesModelsFromJson(jsonString);

import 'dart:convert';

ChatMessagesModels chatMessagesModelsFromJson(String str) => ChatMessagesModels.fromJson(json.decode(str));

String chatMessagesModelsToJson(ChatMessagesModels data) => json.encode(data.toJson());

class ChatMessagesModels {
  int? code;
  String? status;
  String? message;
  List<Messages>? data;

  ChatMessagesModels({
     this.code,
     this.status,
    this.message,
    this.data,
  });

  factory ChatMessagesModels.fromJson(Map<String, dynamic> json) => ChatMessagesModels(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: List<Messages>.from(json["data"].map((x) => Messages.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Messages {
  int? id;
  int? userId;
  int? conversationId;
  String? message;
  int? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;

  Messages({
    this.id,
    this.userId,
    this.conversationId,
    this.message,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  Messages.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = <String, dynamic>{};
    id = json["id"];
    userId = json["user_id"];
    conversationId = json["conversation_id"];
    message = json["message"];
    isRead = json["is_read"];
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"]= id;
    data["user_id"]= userId;
    data["conversation_id"]= conversationId;
    data["message"]= message;
    data["is_read"]= isRead;
    data["created_at"]= createdAt?.toIso8601String();
    data["updated_at"]= updatedAt?.toIso8601String();
    return data;
  }
}
