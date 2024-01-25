class MyFollowingList {
  int? code;
  String? status;
  String? message;
  int? count;
  List<DataFollowing>? data;

  MyFollowingList(
      {this.code, this.status, this.message, this.count, this.data});

  MyFollowingList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <DataFollowing>[];
      json['data'].forEach((v) {
        data!.add(DataFollowing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataFollowing {
  int? id;
  String? guid;
  String? email;
  var emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? bio;
  String? phone;
  String? firstName;
  String? lastName;
  var username;
  var image;
  var coverImage;
  Pivot? pivot;

  DataFollowing(
      {this.id,
      this.guid,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.bio,
      this.phone,
      this.firstName,
      this.lastName,
      this.username,
      this.image,
      this.coverImage,
      this.pivot});

  DataFollowing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guid = json['guid'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bio = json['bio'];
    phone = json['phone'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    image = json['image'];
    coverImage = json['cover_image'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['guid'] = guid;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['bio'] = bio;
    data['phone'] = phone;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['image'] = image;
    data['cover_image'] = coverImage;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? userId;
  int? followId;

  Pivot({this.userId, this.followId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    followId = json['follow_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['follow_id'] = followId;
    return data;
  }
}
