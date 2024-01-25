import 'package:json_annotation/json_annotation.dart';

part 'log_in_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final int code;
  final String status;
  final String message;
  final Data data;

  LoginResponseModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  final User user;
  final String token;

  Data({
    required this.user,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class User {
  final int id;
  final String email;
  final String? bio;
  final String? phone;
  final String? first_name;
  final String? last_name;
  final String? username;
  final String? device_token;

  User({
    required this.id,
    required this.email,
    this.bio,
    this.phone,
    this.first_name,
    this.last_name,
    this.username,
    this.device_token,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
