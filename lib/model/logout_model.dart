import 'package:json_annotation/json_annotation.dart';

part 'logout_model.g.dart';

@JsonSerializable()
class LogoutResponseModel {
  final int code;
  final String status;
  final String message;
  final Map<String, dynamic> data;

  LogoutResponseModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) => _$LogoutResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LogoutResponseModelToJson(this);
}
