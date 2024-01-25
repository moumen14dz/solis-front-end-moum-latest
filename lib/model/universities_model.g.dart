// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'universities_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniversitiesModel _$UniversitiesModelFromJson(Map<String, dynamic> json) =>
    UniversitiesModel(
      code: json['code'] as int,
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => University.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UniversitiesModelToJson(UniversitiesModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

University _$UniversityFromJson(Map<String, dynamic> json) => University(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$UniversityToJson(University instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
