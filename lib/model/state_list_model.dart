import 'package:json_annotation/json_annotation.dart';

part 'state_list_model.g.dart';

@JsonSerializable()
class StateListModel {
  final int code;
  final String status;
  final String message;
  final List<StateModel> data;

  StateListModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory StateListModel.fromJson(Map<String, dynamic> json) =>
      _$StateListModelFromJson(json);
  Map<String, dynamic> toJson() => _$StateListModelToJson(this);
}

@JsonSerializable()
class StateModel {
  final int id;
  final String name;

  StateModel({
    required this.id,
    required this.name,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) =>
      _$StateModelFromJson(json);
  Map<String, dynamic> toJson() => _$StateModelToJson(this);
}
