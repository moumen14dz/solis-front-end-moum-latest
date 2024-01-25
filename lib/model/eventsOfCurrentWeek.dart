import 'dart:convert';
import 'dart:developer';

import 'package:newproject/model/loginResponse.dart';

class GetEventsOfCurrentWeek {
  int? code;
  String? status;
  String? message;
  int? count;
  List<Event>? data;
  GetEventsOfCurrentWeek({
    this.code,
    this.status,
    this.message,
    this.count,
    this.data,
  });
  factory GetEventsOfCurrentWeek.fromJson(Map<String, dynamic> json) {
    log('dddddd');
    return GetEventsOfCurrentWeek(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      count: json['count'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((eventJson) => Event.fromJson(eventJson))
              .toList()
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'count': count,
      'data': data?.map((event) => event.toJson()).toList(),
    };
  }
}

class Event {
  int? id;
  String? guid;
  int? categoryId;
  int? userId;
  int? countryId;
  int? neighborhoodId;
  int? universityId;
  int? programId;
  String? title;
  String? description;
  String? image;
  DateTime? startDate;
  DateTime? endDate;
  String? startTime;
  String? endTime;
  double? price;
  int? ageMin;
  int? ageMax;
  int? limitEntrance;
  int? entranceLimitMin;
  int? entranceLimitMax;
  int? accountFollow;
  String? location;
  int? eventType;
  String? latitude;
  String? longitude;
  int? featured;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Ticket>? tickets;
  List<User>? participants;
    double? distance;


  Event(
      {this.id,
      this.guid,
      this.categoryId,
      this.userId,
      this.countryId,
      this.neighborhoodId,
      this.universityId,
      this.programId,
      this.title,
      this.description,
      this.image,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.price,
      this.ageMin,
      this.ageMax,
      this.limitEntrance,
      this.entranceLimitMin,
      this.entranceLimitMax,
      this.accountFollow,
      this.location,
      this.eventType,
      this.latitude,
      this.longitude,
      this.featured,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.tickets,
      this.participants,
      this.distance
      });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      guid: json['guid'],
      categoryId: json['category_id'],
      userId: json['user_id'],
      countryId: json['country_id'],
      neighborhoodId: json['neighborhood_id'],
      universityId: json['university_id'],
      programId: json['program_id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      startTime: json['start_time'],
      endTime: json['end_time'],
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
      ageMin: json['age_min'],
      ageMax: json['age_max'],
      limitEntrance: json['limit_entrance'],
      entranceLimitMin: json['entrance_limit_min'],
      entranceLimitMax: json['entrance_limit_max'],
      accountFollow: json['account_follow'],
      location: json['location'],
      eventType: json['event_type'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      featured: json['featured'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      tickets: json['tickets'] != null
          ? (json['tickets'] as List)
              .map((ticketJson) => Ticket.fromJson(ticketJson))
              .toList()
          : null,
      participants: json['participants'] != null
          ? (json['participants'] as List)
              .map((user) => User.fromJson(user))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'guid': guid,
      'category_id': categoryId,
      'user_id': userId,
      'country_id': countryId,
      'neighborhood_id': neighborhoodId,
      'university_id': universityId,
      'program_id': programId,
      'title': title,
      'description': description,
      'image': image,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'start_time': startTime,
      'end_time': endTime,
      'price': price,
      'age_min': ageMin,
      'age_max': ageMax,
      'limit_entrance': limitEntrance,
      'entrance_limit_min': entranceLimitMin,
      'entrance_limit_max': entranceLimitMax,
      'account_follow': accountFollow,
      'location': location,
      'event_type': eventType,
      'latitude': latitude,
      'longitude': longitude,
      'featured': featured,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'tickets': tickets?.map((ticket) => ticket.toJson()).toList(),
    };
  }
}

class Ticket {
  int? id;
  int? eventId;
  String title;
  double? price;
  int? quantity;
  String? description;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Ticket({
    this.id,
    this.eventId,
    required this.title,
    this.price,
    this.quantity,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      eventId: json['event_id'],
      title: json['title'],
      price: double.tryParse(json['price']?.toString() ?? '0'),
      quantity: json['quantity'],
      description: json['description'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'title': title,
      'price': price,
      'quantity': quantity,
      'description': description,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
// To parse this JSON data, do
//
//     final tax = taxFromJson(jsonString);

Tax taxFromJson(String str) => Tax.fromJson(json.decode(str));

String taxToJson(Tax data) => json.encode(data.toJson());

class Tax {
  int id;
  String title;
  String rateType;
  String rate;
  String netPrice;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  Tax({
    required this.id,
    required this.title,
    required this.rateType,
    required this.rate,
    required this.netPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        id: json["id"],
        title: json["title"],
        rateType: json["rate_type"],
        rate: json["rate"],
        netPrice: json["net_price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "rate_type": rateType,
        "rate": rate,
        "net_price": netPrice,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  int ticketId;
  int taxId;

  Pivot({
    required this.ticketId,
    required this.taxId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        ticketId: json["ticket_id"],
        taxId: json["tax_id"],
      );

  Map<String, dynamic> toJson() => {
        "ticket_id": ticketId,
        "tax_id": taxId,
      };
}
