// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationModel _$RegistrationModelFromJson(Map<String, dynamic> json) =>
    RegistrationModel(
      code: json['code'] as int,
      status: json['status'] as String,
      message: json['message'] as String == "Validation error"
          ? jsonDecode(jsonEncode(json['data'].toString()))
          : json['message'] as String,
      data: json['message'] as String == "Validation error"
          ? Data(
              user: User(
                  email: (jsonDecode(jsonEncode(json['data'].toString()))),
                  id: 0))
          : Data(
              user: User(
                  email: (jsonDecode(jsonEncode(json['data'].toString()))),
                  id: 0)),
    );

Map<String, dynamic> _$RegistrationModelToJson(RegistrationModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      //  'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => json['user'] != null
    ? Data(
        user: User.fromJson(json['user'] as Map<String, dynamic>),
      )
    : Data(user: User(email: "email", id: 1));

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String,
      id: json['id'] as int,
      business: json['business'] == null
          ? null
          : Business.fromJson(json['business'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'id': instance.id,
      'business': instance.business,
    };

Business _$BusinessFromJson(Map<String, dynamic> json) => Business(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      postal_code: json['postal_code'] as String,
    );

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'postal_code': instance.postal_code,
    };
