// // To parse this JSON data, do
// //
// //     final eventResponseModel = eventResponseModelFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:json_annotation/json_annotation.dart';
//
// part 'events_model.g.dart';
//
//
//
// EventResponseModel eventResponseModelFromJson(String str) => EventResponseModel.fromJson(json.decode(str));
// String eventResponseModelToJson(EventResponseModel data) => json.encode(data.toJson());
// @JsonSerializable()
// class EventResponseModel {
//   int? code;
//   String? status;
//   String? message;
//   int? count;
//   List<EventModel>? data;
//
//   EventResponseModel({
//      this.code,
//      this.status,
//      this.message,
//      this.count,
//      this.data,
//   });
//
//   factory EventResponseModel.fromJson(Map<String, dynamic> json) => EventResponseModel(
//     code: json["code"],
//     status: json["status"],
//     message: json["message"],
//     count: json["count"],
//     data: List<EventModel>.from(json["data"].map((x) => EventModel.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "code": code,
//     "status": status,
//     "message": message,
//     "count": count,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
// @JsonSerializable()
// class EventModel {
//   int? id;
//   String? guid;
//   int? categoryId;
//   int? userId;
//   int? countryId;
//   int? neighborhoodId;
//   int? universityId;
//   int? programId;
//   String? title;
//   String? description;
//   String? image;
//   String? startDate;
//   String? startTime;
//   String? endDate;
//   String? endTime;
//   double? price;
//   int? ageMin;
//   int? ageMax;
//   bool? limitEntrance;
//   int? entranceLimitMin;
//   int? entranceLimitMax;
//   dynamic accountFollow;
//   String? latitude;
//   String? longitude;
//   bool? publicEvent;
//   bool? forFollowers;
//   int? featured;
//   String? status;
//   String? freeTitle;
//   String? freeDescription;
//   String? freeQuantity;
//   String? paidTitle;
//   String? paidDescription;
//   String? paidQuantity;
//
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   List<Ticket>? tickets;
//
//   EventModel({
//      this.id,
//      this.guid,
//      this.categoryId,
//     this.userId,
//      this.countryId,
//     this.neighborhoodId,
//      this.universityId,
//      this.programId,
//      this.title,
//      this.description,
//      this.image,
//      this.startDate,
//      this.startTime,
//      this.endDate,
//      this.endTime,
//      this.price,
//      this.ageMin,
//      this.ageMax,
//      this.limitEntrance,
//      this.entranceLimitMin,
//      this.entranceLimitMax,
//      this.accountFollow,
//      this.latitude,
//      this.longitude,
//      this.featured,
//      this.status,
//      this.publicEvent,
//      this.forFollowers,
//      this.freeTitle,
//      this.freeDescription,
//      this.freeQuantity,
//      this.paidTitle,
//      this.paidDescription,
//      this.paidQuantity,
//
//      this.createdAt,
//      this.updatedAt,
//      this.tickets,
//   });
//
//   factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
//     id: json["id"],
//     guid: json["guid"],
//     categoryId: json["category_id"],
//     userId: json["user_id"],
//     countryId: json["country_id"],
//     neighborhoodId: json["neighborhood_id"],
//     universityId: json["university_id"],
//     programId: json["program_id"],
//     title: json["title"],
//     description: json["description"],
//     image: json["image"],
//     startDate: json["event_date"],
//     startTime: json["start_time"],
//     endDate: json["end_date"],
//     endTime: json["end_time"],
//     price: json["price"],
//     ageMin: json["age_min"],
//     ageMax: json["age_max"],
//     limitEntrance: json["limit_entrance"],
//     entranceLimitMin: json["min_entrance"],
//     entranceLimitMax: json["max_entrance"],
//     accountFollow: json["account_follow"],
//     latitude: json["latitude"],
//     longitude: json["longitude"],
//     publicEvent: json["public_Event"],
//     forFollowers: json["for_followers"],
//     featured: json["featured"],
//     status: json["status"],
//     freeTitle: json["ft_title"],
//     freeDescription: json["ft_description"],
//     freeQuantity: json["ft_quantity"],
//     paidTitle: json["pt_title"],
//     paidDescription: json["pt_description"],
//     paidQuantity: json["pt_quantity"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     tickets: json['tickets'] != null
//         ? (json['tickets'] as List)
//         .map((ticketJson) => Ticket.fromJson(ticketJson))
//         .toList()
//         : null,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "guid": guid,
//     "category_id": categoryId,
//     "user_id": userId,
//     "country_id": countryId,
//     "neighborhood_id": neighborhoodId,
//     "university_id": universityId,
//     "program_id": programId,
//     "title": title,
//     "description": description,
//     "image": image,
//     "start_date": "${startDate}",
//     "event_date": startDate,
//     "start_time": startTime,
//     "end_date": endDate,
//     "end_time": endTime,
//     "price": price,
//     "age_min": ageMin,
//     "age_max": ageMax,
//     "limit_entrance": limitEntrance,
//     "min_entrance": entranceLimitMin,
//     "max_entrance": entranceLimitMax,
//     "account_follow": accountFollow,
//     "latitude": latitude,
//     "longitude": longitude,
//     "public_event": publicEvent,
//     "for_followers": forFollowers,
//     "featured": featured,
//     "status": status,
//     "created_at": createdAt!.toIso8601String(),
//     "updated_at": updatedAt!.toIso8601String(),
//     'tickets': tickets?.map((ticket) => ticket.toJson()).toList(),  };
// }
//
// enum Status {
//   ACTIVE
// }
//
// final statusValues = EnumValues({
//   "active": Status.ACTIVE
// });
// @JsonSerializable()
// class Ticket {
//   int? id;
//   int? eventId;
//   String? title;
//   double? price;
//   String? quantity;
//   String? description;
//   Status? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Ticket({
//     this.id,
//     this.eventId,
//      this.title,
//     this.price,
//      this.quantity,
//      this.description,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
//     id: json["id"],
//     eventId: json["event_id"],
//     title: json["title"]!,
//     price: json["price"],
//     quantity: json["quantity"],
//     description: json["description"]!,
//     status: statusValues.map[json["status"]]!,
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "event_id": eventId,
//     "title": titleValues.reverse[title],
//     "price": price,
//     "quantity": quantity,
//     "description": descriptionValues.reverse[description],
//     "status": statusValues.reverse[status],
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//   };
// }
//
// enum Description {
//   FREE_TICKETS,
//   PAID_TICKETS
// }
//
// final descriptionValues = EnumValues({
//   "Free tickets": Description.FREE_TICKETS,
//   "Paid tickets": Description.PAID_TICKETS
// });
//
// enum Title {
//   FREE,
//   PAID
// }
//
// final titleValues = EnumValues({
//   "Free": Title.FREE,
//   "Paid": Title.PAID
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
