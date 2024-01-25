import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'registration_model.g.dart';

@JsonSerializable()
class RegistrationModel {
  final int code;
  final String status;
  final String message;
  final Data data;

  RegistrationModel(
      {required this.code,
      required this.status,
      required this.message,
    required this.data
    });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegistrationModelToJson(this);
}

@JsonSerializable()
class Data {
  final User user;

  Data({required this.user});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

// @JsonSerializable()
// class User {
//   final String email;
//   final int id;
//   final Business business;
//
//   User({required this.email, required this.id, required this.business});
//
//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
//   Map<String, dynamic> toJson() => _$UserToJson(this);
// }

@JsonSerializable()
class User {
  final String email;
  final int id;
  final Business? business; // Marking as nullable

  User(
      {required this.email,
      required this.id,
      this.business}); // Making it optional

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Business {
  final int id;
  final String name;
  final String address;
  final String city;
  final String postal_code;

  Business(
      {required this.id,
      required this.name,
      required this.address,
      required this.city,
      required this.postal_code});

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessToJson(this);
}
