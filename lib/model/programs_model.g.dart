// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'programs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramsModel _$ProgramsModelFromJson(Map<String, dynamic> json) =>
    ProgramsModel(
      code: json['code'] as int,
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ProgramData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProgramsModelToJson(ProgramsModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

ProgramData _$ProgramDataFromJson(Map<String, dynamic> json) => ProgramData(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ProgramDataToJson(ProgramData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
