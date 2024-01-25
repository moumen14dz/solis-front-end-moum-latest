import 'package:json_annotation/json_annotation.dart';

part 'universities_model.g.dart';

@JsonSerializable()
class UniversitiesModel {
  final int code;
  final String status;
  final String message;
  final List<University> data;

  UniversitiesModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory UniversitiesModel.fromJson(Map<String, dynamic> json) =>
      _$UniversitiesModelFromJson(json);
  Map<String, dynamic> toJson() => _$UniversitiesModelToJson(this);
}

@JsonSerializable()
class University {
  final int id;
  final String name;

  University({
    required this.id,
    required this.name,
  });

  factory University.fromJson(Map<String, dynamic> json) =>
      _$UniversityFromJson(json);
  Map<String, dynamic> toJson() => _$UniversityToJson(this);
}
