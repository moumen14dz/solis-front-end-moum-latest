import 'package:json_annotation/json_annotation.dart';


part 'messages_model.g.dart';

@JsonSerializable()
class MessageResponseModel {
  int? code;
  String? status;
  String? message;
  List<ChatMessageModel>? data;

  MessageResponseModel({
     this.code,
     this.status,
     this.message,
     this.data,
  });

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) => _$MessageResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageResponseModelToJson(this);
}

// @JsonSerializable()
// class Data {
//   final User user;
//   final String token;
//
//   Data({
//     required this.user,
//     required this.token,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
//   Map<String, dynamic> toJson() => _$DataToJson(this);
// }
@JsonSerializable()
class ChatMessageModel {
  int? id;
  dynamic name;
  int? unreadMessagesCount;
  List<User>? users;
  List<Message>? messages;

  ChatMessageModel({
     this.id,
     this.name,
    this.unreadMessagesCount,
    this.users,
    this.messages,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => _$ChatMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}

@JsonSerializable()
class Message {
  int? id;
  int? userId;
  int? conversationId;
  String? message;
  int? isRead;


  Message({
    this.id,
     this.userId,
     this.conversationId,
     this.message,
     this.isRead,
  });
  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
@JsonSerializable()
class User {
  final int? id;
  final String? email;
  final String? bio;
  final String? phone;
  final String? first_name;
  final String? last_name;
  final String? username;

  User({
    this.id,
    this.email,
    this.bio,
    this.phone,
    this.first_name,
    this.last_name,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}