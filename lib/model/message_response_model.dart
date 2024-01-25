// To parse this JSON data, do
//
//     final messagesResponseModel = messagesResponseModelFromJson(jsonString);

import 'dart:convert';



MessagesResponseModel messagesResponseModelFromJson(String str) => MessagesResponseModel.fromJson(json.decode(str));

String messagesResponseModelToJson(MessagesResponseModel data) => json.encode(data.toJson());

class MessagesResponseModel {
  int? code;
  String? status;
  String? message;
  List<DataThreads>? data;

  MessagesResponseModel({
   this.code,
     this.status,
     this.message,
     this.data,
  });

   MessagesResponseModel.fromJson(Map<String, dynamic> json) {  
    code = json['code'];
  status = json['status'];
  message = json['message'];
  if (json['data'] != null) {
    data = <DataThreads>[];
    json['data'].forEach((v) {
      data!.add(DataThreads.fromJson(v));
    });
  }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataThreads {
  int? id;
  dynamic name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? unreadMessagesCount;
  List<User>? users;
  List<Message>? messages;

  DataThreads({
     this.id,
     this.name,
     this.createdAt,
     this.updatedAt,
     this.unreadMessagesCount,
     this.users,
     this.messages,
  });

  DataThreads.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
    unreadMessagesCount = json["unread_messages_count"];
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add(User.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = <Message>[];
      json['messages'].forEach((v) {
        messages!.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"]= id;
    data["name"]= name;
    data["created_at"]=createdAt?.toIso8601String();
    data["updated_at"]= updatedAt?.toIso8601String();
    data["unread_messages_count"]= unreadMessagesCount;
    if (users != null) {
    data['users'] = users!.map((v) => v.toJson()).toList();
    }
    if (messages != null) {
    data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
    }
  }

class Message {
  int? id;
  int? userId;
  int? conversationId;
  String? message;
  int? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;

  Message({
     this.id,
     this.userId,
     this.conversationId,
     this.message,
     this.isRead,
     this.createdAt,
     this.updatedAt,
  });

  Message.fromJson(Map<String, dynamic> json) {
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
        data["id"] = id;
        data["user_id"] = userId;
        data["conversation_id"] = conversationId;
        data["message"] = message;
        data["is_read"] = isRead;
        data["created_at"] = createdAt?.toIso8601String();
        data["updated_at"] = updatedAt?.toIso8601String();
        return data;
        }
}

class User {
  int? id;
  String? guid;
  String? email;
  String? bio;
  String? phone;
  String? firstName;
  String? lastName;
  String? username;
  String? image;
  String? coverImage;
  Pivot? pivot;

  User(
      {this.id,
        this.guid,
        this.email,
        this.bio,
        this.phone,
        this.firstName,
        this.lastName,
        this.username,
        this.image,
        this.coverImage,
        this.pivot});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guid = json['guid'];
    email = json['email'];
    bio = json['bio'];
    phone = json['phone'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    image = json['image'];
    coverImage = json['cover_image'];
    if (json['pivot'] != null) {
      pivot = Pivot.fromJson(json['pivot']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['guid'] = guid;
    data['email'] = email;
    data['bio'] = bio;
    data['phone'] = phone;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['image'] = image;
    data['cover_image'] = coverImage;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}
class Pivot {
  int? conversationId;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Pivot({
    this.conversationId,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  Pivot.fromJson(Map<String, dynamic> json) {
    conversationId = json["conversation_id"];
    userId = json["user_id"];
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
  }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["conversation_id"]= conversationId;
    data["user_id"]= userId;
    data["created_at"]= createdAt!.toIso8601String();
    data["updated_at"]= updatedAt!.toIso8601String();
    return data;
    }
}