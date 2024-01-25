// class HostedEventsOfUser {
//   final int? code;
//   final String? status;
//   final String? message;
//   final int? count;
//   final List<Event>? data;
//   HostedEventsOfUser({
//     this.code,
//     this.status,
//     this.message,
//     this.count,
//     this.data,
//   });
//   factory HostedEventsOfUser.fromJson(Map<String, dynamic> json) {
//     return HostedEventsOfUser(
//       code: json['code'],
//       status: json['status'],
//       message: json['message'],
//       count: json['count'],
//       data: json['data'] != null
//           ? (json['data'] as List)
//           .map((eventJson) => Event.fromJson(eventJson))
//           .toList()
//           : null,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'code': code,
//       'status': status,
//       'message': message,
//       'count': count,
//       'data': data?.map((event) => event.toJson()).toList(),
//     };
//   }
// }
// class Event {
//   final int? id;
//   final String? guid;
//   final int? categoryId;
//   final int? userId;
//   final int? countryId;
//   final int? neighborhoodId;
//   final int? universityId;
//   final int? programId;
//   final String? title;
//   final String? description;
//   final String? image;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final String? startTime;
//   final String? endTime;
//   final double? price;
//   final int? ageMin;
//   final int? ageMax;
//   final int? limitEntrance;
//   final int? entranceLimitMin;
//   final int? entranceLimitMax;
//   final int? accountFollow;
//   final String? location;
//   final int? eventType;
//   final String? latitude;
//   final String? longitude;
//   final int? featured;
//   final String? status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final List<Ticket>? tickets;
//
//   Event({
//     this.id,
//     this.guid,
//     this.categoryId,
//     this.userId,
//     this.countryId,
//     this.neighborhoodId,
//     this.universityId,
//     this.programId,
//     this.title,
//     this.description,
//     this.image,
//     this.startDate,
//     this.endDate,
//     this.startTime,
//     this.endTime,
//     this.price,
//     this.ageMin,
//     this.ageMax,
//     this.limitEntrance,
//     this.entranceLimitMin,
//     this.entranceLimitMax,
//     this.accountFollow,
//     this.location,
//     this.eventType,
//     this.latitude,
//     this.longitude,
//     this.featured,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.tickets,
//   });
//
//   factory Event.fromJson(Map<String, dynamic> json) {
//     return Event(
//       id: json['id'],
//       guid: json['guid'],
//       categoryId: json['category_id'],
//       userId: json['user_id'],
//       countryId: json['country_id'],
//       neighborhoodId: json['neighborhood_id'],
//       universityId: json['university_id'],
//       programId: json['program_id'],
//       title: json['title'],
//       description: json['description'],
//       image: json['image'],
//       startDate: json['start_date'] != null
//           ? DateTime.parse(json['start_date'])
//           : null,
//       endDate: json['end_date'] != null
//           ? DateTime.parse(json['end_date'])
//           : null,
//       startTime: json['start_time'],
//       endTime: json['end_time'],
//       price: json['price'] != null ? double.tryParse(json['price'].toString()) : null,
//       ageMin: json['age_min'],
//       ageMax: json['age_max'],
//       limitEntrance: json['limit_entrance'],
//       entranceLimitMin: json['entrance_limit_min'],
//       entranceLimitMax: json['entrance_limit_max'],
//       accountFollow: json['account_follow'],
//       location: json['location'],
//       eventType: json['event_type'],
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       featured: json['featured'],
//       status: json['status'],
//       createdAt: json['created_at'] != null
//           ? DateTime.parse(json['created_at'])
//           : null,
//       updatedAt: json['updated_at'] != null
//           ? DateTime.parse(json['updated_at'])
//           : null,
//       tickets: json['tickets'] != null
//           ? (json['tickets'] as List)
//           .map((ticketJson) => Ticket.fromJson(ticketJson))
//           .toList()
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'guid': guid,
//       'category_id': categoryId,
//       'user_id': userId,
//       'country_id': countryId,
//       'neighborhood_id': neighborhoodId,
//       'university_id': universityId,
//       'program_id': programId,
//       'title': title,
//       'description': description,
//       'image': image,
//       'start_date': startDate?.toIso8601String(),
//       'end_date': endDate?.toIso8601String(),
//       'start_time': startTime,
//       'end_time': endTime,
//       'price': price,
//       'age_min': ageMin,
//       'age_max': ageMax,
//       'limit_entrance': limitEntrance,
//       'entrance_limit_min': entranceLimitMin,
//       'entrance_limit_max': entranceLimitMax,
//       'account_follow': accountFollow,
//       'location': location,
//       'event_type': eventType,
//       'latitude': latitude,
//       'longitude': longitude,
//       'featured': featured,
//       'status': status,
//       'created_at': createdAt?.toIso8601String(),
//       'updated_at': updatedAt?.toIso8601String(),
//       'tickets': tickets?.map((ticket) => ticket.toJson()).toList(),
//     };
//   }
// }
// class Ticket {
//   final int? id;
//   final int? eventId;
//   final String title;
//   final double? price;
//   final int? quantity;
//   final String? description;
//   final String? status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   Ticket({
//     this.id,
//     this.eventId,
//     required this.title,
//     this.price,
//     this.quantity,
//     this.description,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//   factory Ticket.fromJson(Map<String, dynamic> json) {
//     return Ticket(
//       id: json['id'],
//       eventId: json['event_id'],
//       title: json['title'],
//       price: double.tryParse(json['price']?.toString() ?? '0'),
//       quantity: json['quantity'],
//       description: json['description'],
//       status: json['status'],
//       createdAt: json['created_at'] != null
//           ? DateTime.parse(json['created_at'])
//           : null,
//       updatedAt: json['updated_at'] != null
//           ? DateTime.parse(json['updated_at'])
//           : null,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'event_id': eventId,
//       'title': title,
//       'price': price,
//       'quantity': quantity,
//       'description': description,
//       'status': status,
//       'created_at': createdAt?.toIso8601String(),
//       'updated_at': updatedAt?.toIso8601String(),
//     };
//   }
// }

import 'dart:convert';

import 'userProfileDetails.dart';

class GetEventDetails {
  int? code;
  String? status;
  String? message;
  Data? data;

  GetEventDetails({this.code, this.status, this.message, this.data});

  GetEventDetails.fromJson(Map<String, dynamic> json) {
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
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  int? price;
  int? ageMin;
  int? ageMax;
  int? limitEntrance;
  int? entranceLimitMin;
  int? entranceLimitMax;
  var accountFollow;
  String? location;
  String? latitude;
  String? longitude;
  int? featured;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Tickets>? tickets;
  Category? category;
  University? university;
  Country? country;
  int ? participants;
  String? is_redirected;
  String? ticketing_link;

  Data(
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
      this.startTime,
      this.endDate,
      this.endTime,
      this.price,
      this.ageMin,
      this.ageMax,
      this.limitEntrance,
      this.entranceLimitMin,
      this.entranceLimitMax,
      this.accountFollow,
      this.location,
      this.latitude,
      this.longitude,
      this.featured,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.tickets,
      this.category,
      this.university,
      this.country,
      this.participants,
      this.is_redirected,
      this.ticketing_link});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guid = json['guid'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    countryId = json['country_id'];
    neighborhoodId = json['neighborhood_id'];
    universityId = json['university_id'];
    programId = json['program_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endDate = json['end_date'];
    endTime = json['end_time'];
    price = json['price'];
    ageMin = json['age_min'];
    ageMax = json['age_max'];
    limitEntrance = json['limit_entrance'];
    entranceLimitMin = json['entrance_limit_min'];
    entranceLimitMax = json['entrance_limit_max'];
    accountFollow = json['account_follow'];

    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    featured = json['featured'];
    status = json['status'];
    is_redirected = json['is_redirected'].toString();
    ticketing_link = json['ticketing_link'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(Tickets.fromJson(v));
      });
    }

    if (json['participants'] != null) {
      participants = json['participants'] ;
      //json['participants'].forEach((v) {
        //participants!.add(User.fromJson(v));
      //});
    }
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    university = json['university'] != null
        ? University.fromJson(json['university'])
        : null;
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['guid'] = guid;
    data['category_id'] = categoryId;
    data['user_id'] = userId;
    data['country_id'] = countryId;
    data['neighborhood_id'] = neighborhoodId;
    data['university_id'] = universityId;
    data['program_id'] = programId;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['start_date'] = startDate;
    data['start_time'] = startTime;
    data['end_date'] = endDate;
    data['end_time'] = endTime;
    data['price'] = price;
    data['age_min'] = ageMin;
    data['age_max'] = ageMax;
    data['limit_entrance'] = limitEntrance;
    data['entrance_limit_min'] = entranceLimitMin;
    data['entrance_limit_max'] = entranceLimitMax;
    data['account_follow'] = accountFollow;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['featured'] = featured;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_redirected'] = is_redirected.toString();
    data['ticketing_link'] = ticketing_link;

    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (university != null) {
      data['university'] = university!.toJson();
    }
    if (country != null) {
      data['country'] = country!.toJson();
    }

    return data;
  }
}

class Tickets {
  int? id;
  int? eventId;
  String? title;
  String? price;
  int? quantity;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Tax>? taxes;

  Tickets(
      {this.id,
      this.eventId,
      this.title,
      this.price,
      this.quantity,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.taxes});

  Tickets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['taxes'] != null) {
      taxes = <Tax>[];
      json['taxes'].forEach((v) {
        taxes!.add(Tax.fromJson(v));
      });
    } else {
      taxes = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['event_id'] = eventId;
    data['title'] = title;
    data['price'] = price;
    data['quantity'] = quantity;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['taxes'] = taxes;
    return data;
  }
}

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

class Category {
  int? id;
  var guid;
  String? name;
  String? description;
  String? thumb;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.guid,
      this.name,
      this.description,
      this.thumb,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guid = json['guid'];
    name = json['name'];
    description = json['description'];
    thumb = json['thumb'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['guid'] = guid;
    data['name'] = name;
    data['description'] = description;
    data['thumb'] = thumb;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class University {
  int? id;
  var guid;
  String? name;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  University(
      {this.id,
      this.guid,
      this.name,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt});

  University.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guid = json['guid'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['guid'] = guid;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Country {
  int? id;
  String? code;
  String? name;
  String? createdAt;
  String? updatedAt;

  Country({this.id, this.code, this.name, this.createdAt, this.updatedAt});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

// class GetEventDetails {
//   int? code;
//   String? status;
//   String? message;
//   Event? data;
//
//   GetEventDetails({this.code, this.status, this.message, this.data});
//
//   factory GetEventDetails.fromJson(Map<String, dynamic> json) {
//     return GetEventDetails(
//       code: json['code'],
//       status: json['status'],
//       message: json['message'],
//       data: json['data'] != null ? Event.fromJson(json['data']) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['code'] = code;
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Event {
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
//   int? limitEntrance;
//   int? entranceLimitMin;
//   int? entranceLimitMax;
//   var accountFollow;
//   String? location;
//   String? latitude;
//   String? longitude;
//   int? featured;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   List<Tickets>? tickets;
//   Category? category;
//   University? university;
//   Country? country;
//
//   Event({
//     this.id,
//     this.guid,
//     this.categoryId,
//     this.userId,
//     this.countryId,
//     this.neighborhoodId,
//     this.universityId,
//     this.programId,
//     this.title,
//     this.description,
//     this.image,
//     this.startDate,
//     this.startTime,
//     this.endDate,
//     this.endTime,
//     this.price,
//     this.ageMin,
//     this.ageMax,
//     this.limitEntrance,
//     this.entranceLimitMin,
//     this.entranceLimitMax,
//     this.accountFollow,
//     this.location,
//     this.latitude,
//     this.longitude,
//     this.featured,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.tickets,
//     this.category,
//     this.university,
//     this.country,
//   });
//
//   factory Event.fromJson(Map<String, dynamic> json) {
//     return Event(
//       id: json['id'],
//       guid: json['guid'],
//       categoryId: json['category_id'],
//       userId: json['user_id'],
//       countryId: json['country_id'],
//       neighborhoodId: json['neighborhood_id'],
//       universityId: json['university_id'],
//       programId: json['program_id'],
//       title: json['title'],
//       description: json['description'],
//       image: json['image'],
//       startDate: json['start_date'],
//       startTime: json['start_time'],
//       endDate: json['end_date'],
//       endTime: json['end_time'],
//       price: json['price'],
//       ageMin: json['age_min'],
//       ageMax: json['age_max'],
//       limitEntrance: json['limit_entrance'],
//       entranceLimitMin: json['entrance_limit_min'],
//       entranceLimitMax: json['entrance_limit_max'],
//       accountFollow: json['account_follow'],
//       location: json['location'],
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       featured: json['featured'],
//       status: json['status'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       tickets: json['tickets'] != null
//           ? List<Tickets>.from(json['tickets'].map((x) => Tickets.fromJson(x)))
//           : null,
//       category: json['category'] != null
//           ? Category.fromJson(json['category'])
//           : null,
//       university: json['university'] != null
//           ? University.fromJson(json['university'])
//           : null,
//       country: json['country'] != null
//           ? Country.fromJson(json['country'])
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['guid'] = guid;
//     data['category_id'] = categoryId;
//     data['user_id'] = userId;
//     data['country_id'] = countryId;
//     data['neighborhood_id'] = neighborhoodId;
//     data['university_id'] = universityId;
//     data['program_id'] = programId;
//     data['title'] = title;
//     data['description'] = description;
//     data['image'] = image;
//     data['start_date'] = startDate;
//     data['start_time'] = startTime;
//     data['end_date'] = endDate;
//     data['end_time'] = endTime;
//     data['price'] = price;
//     data['age_min'] = ageMin;
//     data['age_max'] = ageMax;
//     data['limit_entrance'] = limitEntrance;
//     data['entrance_limit_min'] = entranceLimitMin;
//     data['entrance_limit_max'] = entranceLimitMax;
//     data['account_follow'] = accountFollow;
//     data['location'] = location;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['featured'] = featured;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     if (tickets != null) {
//       data['tickets'] = List<dynamic>.from(tickets!.map((x) => x.toJson()));
//     }
//     if (category != null) {
//       data['category'] = category!.toJson();
//     }
//     if (university != null) {
//       data['university'] = university!.toJson();
//     }
//     if (country != null) {
//       data['country'] = country!.toJson();
//     }
//     return data;
//   }
// }
//
// class Tickets {
//   int? id;
//   int? eventId;
//   String? title;
//   double? price;
//   int? quantity;
//   String? description;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Tickets({
//     this.id,
//     this.eventId,
//     this.title,
//     this.price,
//     this.quantity,
//     this.description,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Tickets.fromJson(Map<String, dynamic> json) {
//     return Tickets(
//       id: json['id'],
//       eventId: json['event_id'],
//       title: json['title'],
//       price: json['price'],
//       quantity: json['quantity'],
//       description: json['description'],
//       status: json['status'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['event_id'] = eventId;
//     data['title'] = title;
//     data['price'] = price;
//     data['quantity'] = quantity;
//     data['description'] = description;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
//
// class Category {
//   int? id;
//   var guid;
//   String? name;
//   String? description;
//   String? thumb;
//   String? image;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Category({
//     this.id,
//     this.guid,
//     this.name,
//     this.description,
//     this.thumb,
//     this.image,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'],
//       guid: json['guid'],
//       name: json['name'],
//       description: json['description'],
//       thumb: json['thumb'],
//       image: json['image'],
//       status: json['status'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['guid'] = guid;
//     data['name'] = name;
//     data['description'] = description;
//     data['thumb'] = thumb;
//     data['image'] = image;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
//
// class University {
//   int? id;
//   var guid;
//   String? name;
//   String? description;
//   String? image;
//   String? createdAt;
//   String? updatedAt;
//
//   University({
//     this.id,
//     this.guid,
//     this.name,
//     this.description,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory University.fromJson(Map<String, dynamic> json) {
//     return University(
//       id: json['id'],
//       guid: json['guid'],
//       name: json['name'],
//       description: json['description'],
//       image: json['image'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['guid'] = guid;
//     data['name'] = name;
//     data['description'] = description;
//     data['image'] = image;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
//
// class Country {
//   int? id;
//   String? code;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//
//   Country({
//     this.id,
//     this.code,
//     this.name,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Country.fromJson(Map<String, dynamic> json) {
//     return Country(
//       id: json['id'],
//       code: json['code'],
//       name: json['name'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['code'] = code;
//     data['name'] = name;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
