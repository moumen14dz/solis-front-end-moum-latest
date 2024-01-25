import 'package:json_annotation/json_annotation.dart';

part 'programs_model.g.dart';

@JsonSerializable()
class ProgramsModel {
  final int code;
  final String status;
  final String message;
  final List<ProgramData> data;

  ProgramsModel({required this.code, required this.status, required this.message, required this.data});

  factory ProgramsModel.fromJson(Map<String, dynamic> json) => _$ProgramsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProgramsModelToJson(this);
}

@JsonSerializable()
class ProgramData {
  final int id;
  final String name;

  ProgramData({required this.id, required this.name});

  factory ProgramData.fromJson(Map<String, dynamic> json) => _$ProgramDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProgramDataToJson(this);
}
