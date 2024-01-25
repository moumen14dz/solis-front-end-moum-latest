class GetCategories {
  int? code;
  String? status;
  String? message;
  List<DataOfGetCategories>? data;

  GetCategories({this.code, this.status, this.message, this.data});

  GetCategories.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataOfGetCategories>[];
      json['data'].forEach((v) {
        data!.add(DataOfGetCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataOfGetCategories {
  int? id;
  String? name;
  String? description;
  String? thumb;
  String? image;

  DataOfGetCategories(
      {this.id, this.name, this.description, this.thumb, this.image});

  DataOfGetCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    thumb = json['thumb'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['thumb'] = thumb;
    data['image'] = image;
    return data;
  }
}
