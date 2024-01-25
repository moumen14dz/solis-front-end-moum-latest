class UserProfileDetails {
  int? code;
  String? status;
  String? message;
  Data? data;

  UserProfileDetails({this.code, this.status, this.message, this.data});

  UserProfileDetails.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? guid;
  String? email;
  String? bio;
  String? phone;
  String? firstName;
  String? lastName;
  String? username;
  String? image;
  String? coverImage;

  User(
      {this.id,
      this.guid,
      this.email,
      this.bio,
      this.phone,
      this.firstName,
      this.lastName,
      this.username,
      this.image,
      this.coverImage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guid = json['guid'];
    email = json['email'];
    bio = json['bio'];
    phone = json['phone'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    image = json['image'];
    coverImage = json['cover_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['guid'] = guid;
    data['email'] = email;
    data['bio'] = bio;
    data['phone'] = phone;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['image'] = image;
    data['cover_image'] = coverImage;
    return data;
  }
}
