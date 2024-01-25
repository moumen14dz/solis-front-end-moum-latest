// // To parse this JSON data, do
// //
// //     final registrationModel = registrationModelFromJson(jsonString);
//
// import 'dart:convert';
//
// RegistrationModel registrationModelFromJson(String str) => RegistrationModel.fromJson(json.decode(str));
//
// String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());
//
// class RegistrationModel {
//   int? code;
//   String? status;
//   String? message;
//   Data? data;
//
//   RegistrationModel({
//      this.code,
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
//     code: json["code"],
//     status: json["status"],
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "code": code,
//     "status": status,
//     "message": message,
//     "data": data != null ? data!.toJson() : null,
//   };
// }
//
// class Data {
//   User user;
//
//   Data({
//     required this.user,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     user: User.fromJson(json["user"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "user": user.toJson(),
//   };
// }
//
// class User {
//   String? firstName;
//   String? lastName;
//   String username;
//   String? guid;
//   String? bio;
//   String email;
//   String password;
//   int? id;
//   String? image;
//   String? coverImage;
//   String? association_name; String? business_name;
//   String? business_address; String? city;
//   String? postal_code;
//   String? userType;
//   User({
//     this.firstName,
//     this.lastName,
//     this.guid,
//     this.bio,
//     required this.username,
//     required this.email,
//     required this.password,
//     this.id,
//     this.image,
//     this.coverImage,
//     this.association_name,
//     this.business_address,
//     this.business_name,
//     this.city,
//     this.postal_code,
//     this.userType,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     firstName: json["first_name"],
//     lastName: json["last_name"],
//     guid: json["guid"],
//     bio: json["bio"],
//     email: json["email"],
//     id: json["id"],
//     image: json["image"],
//     coverImage: json["cover_image"], username: json['username'], password: json['password'],
//     association_name: json["association_name"],
//     business_address: json["business_address"],
//     business_name: json["business_name"],
//     city: json["city"],
//     postal_code: json["postal_code"],
//     userType: json["user_type"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "first_name": firstName,
//     "last_name": lastName,
//     "guid": guid,
//     "bio": bio,
//     'username':username,
//     "email": email,
//     "password":password,
//     "id": id,
//     "image": image,
//     "cover_image": coverImage,
//     "association_name":association_name,
//     "business_address":business_name,
//     "city":city,
//     "postal_code":postal_code,
//     "user_type":userType,
//   };
// }
