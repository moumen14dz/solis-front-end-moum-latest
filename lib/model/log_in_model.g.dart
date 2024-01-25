// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_in_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      code: json['code'] as int,
      status: json['status'] as String,
      message: json['message'] as String,
      data: json['data'].toString() != '{}'
          ? Data.fromJson(json['data'])
          : Data.fromJson({
              "user": User.fromJson({
                "id": 0,
                "email": "",
                "bio": "",
                "phone": "",
                "first_name": "",
                "last_name": "",
                "username": "",
                "device_token": "",
              }),
              "token": ""
            }),
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      user: json['user'] is Map<String, dynamic>
          ? User.fromJson(json['user'])
          : json['user'],
      token: json['token'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      email: json['email'] as String,
      bio: json['bio'] as String?,
      phone: json['phone'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      username: json['username'] as String?,
      device_token: json['device_token'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'bio': instance.bio,
      'phone': instance.phone,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'username': instance.username,
      'device_token': instance.device_token,
    };
