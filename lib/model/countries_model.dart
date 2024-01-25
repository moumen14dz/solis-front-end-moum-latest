import 'package:json_annotation/json_annotation.dart';

part 'countries_model.g.dart';

@JsonSerializable()
class CountriesModel {
  final int code;
  final String status;
  final String message;
  final List<Country> data;

  CountriesModel({required this.code, required this.status, required this.message, required this.data});

  factory CountriesModel.fromJson(Map<String, dynamic> json) => _$CountriesModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountriesModelToJson(this);
}

@JsonSerializable()
class Country {
  final int id;
  final String code;
  final String name;

  Country({required this.id, required this.code, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
