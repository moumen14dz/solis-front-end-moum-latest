// To parse this JSON data, do
//
//     final usersListModel = usersListModelFromJson(jsonString);

import 'dart:convert';

UsersListModel usersListModelFromJson(String str) =>
    UsersListModel.fromJson(json.decode(str));

String usersListModelToJson(UsersListModel data) => json.encode(data.toJson());

class UsersListModel {
  int? code;
  String? status;
  String? message;
  List<Users>? data;

  UsersListModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory UsersListModel.fromJson(Map<String, dynamic> json) => UsersListModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<Users>.from(json["data"].map((x) => Users.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Users {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  String? coverImage;
  String? username;
  String? userType;
  int? eventCount;

  Users(
      {this.id,
      this.firstName,
      this.lastName,
      this.image,
      this.coverImage,
      this.username,
      this.userType,
      this.eventCount});

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        coverImage: json["cover_image"],
        username: json['username'],
        userType: json['user_type'],
        eventCount: json['event_count'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "cover_image": coverImage,
        "username": username,
        "user_type": userType
      };
}
