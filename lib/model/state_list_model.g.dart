// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateListModel _$StateListModelFromJson(Map<String, dynamic> json) =>
    StateListModel(
      code: json['code'] as int,
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => StateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StateListModelToJson(StateListModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

StateModel _$StateModelFromJson(Map<String, dynamic> json) => StateModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$StateModelToJson(StateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
