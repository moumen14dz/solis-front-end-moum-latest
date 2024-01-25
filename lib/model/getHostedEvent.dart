// class HostedEventsOfUser {
//   int? code;
//   String? status;
//   String? message;
//   int? count;
//   List<Data>? data;
//
//   HostedEventsOfUser(
//       {this.code, this.status, this.message, this.count, this.data});
//
//   HostedEventsOfUser.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     status = json['status'];
//     message = json['message'];
//     count = json['count'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['status'] = this.status;
//     data['message'] = this.message;
//     data['count'] = this.count;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
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
//   int? accountFollow;
//   String? latitude;
//   String? longitude;
//   int? featured;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   List<Tickets>? tickets;
//
//   Data(
//       {this.id,
//         this.guid,
//         this.categoryId,
//         this.userId,
//         this.countryId,
//         this.neighborhoodId,
//         this.universityId,
//         this.programId,
//         this.title,
//         this.description,
//         this.image,
//         this.startDate,
//         this.startTime,
//         this.endDate,
//         this.endTime,
//         this.price,
//         this.ageMin,
//         this.ageMax,
//         this.limitEntrance,
//         this.entranceLimitMin,
//         this.entranceLimitMax,
//         this.accountFollow,
//         this.latitude,
//         this.longitude,
//         this.featured,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.tickets});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     guid = json['guid'];
//     categoryId = json['category_id'];
//     userId = json['user_id'];
//     countryId = json['country_id'];
//     neighborhoodId = json['neighborhood_id'];
//     universityId = json['university_id'];
//     programId = json['program_id'];
//     title = json['title'];
//     description = json['description'];
//     image = json['image'];
//     startDate = json['start_date'];
//     startTime = json['start_time'];
//     endDate = json['end_date'];
//     endTime = json['end_time'];
//     price = json['price'];
//     ageMin = json['age_min'];
//     ageMax = json['age_max'];
//     limitEntrance = json['limit_entrance'];
//     entranceLimitMin = json['entrance_limit_min'];
//     entranceLimitMax = json['entrance_limit_max'];
//     accountFollow = json['account_follow'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     featured = json['featured'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['tickets'] != null) {
//       tickets = <Tickets>[];
//       json['tickets'].forEach((v) {
//         tickets!.add(new Tickets.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['guid'] = this.guid;
//     data['category_id'] = this.categoryId;
//     data['user_id'] = this.userId;
//     data['country_id'] = this.countryId;
//     data['neighborhood_id'] = this.neighborhoodId;
//     data['university_id'] = this.universityId;
//     data['program_id'] = this.programId;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['image'] = this.image;
//     data['start_date'] = this.startDate;
//     data['start_time'] = this.startTime;
//     data['end_date'] = this.endDate;
//     data['end_time'] = this.endTime;
//     data['price'] = this.price;
//     data['age_min'] = this.ageMin;
//     data['age_max'] = this.ageMax;
//     data['limit_entrance'] = this.limitEntrance;
//     data['entrance_limit_min'] = this.entranceLimitMin;
//     data['entrance_limit_max'] = this.entranceLimitMax;
//     data['account_follow'] = this.accountFollow;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['featured'] = this.featured;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.tickets != null) {
//       data['tickets'] = this.tickets!.map((v) => v.toJson()).toList();
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
//   Tickets(
//       {this.id,
//         this.eventId,
//         this.title,
//         this.price,
//         this.quantity,
//         this.description,
//         this.status,
//         this.createdAt,
//         this.updatedAt});
//
//   Tickets.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     eventId = json['event_id'];
//     title = json['title'];
//     price = json['price'];
//     quantity = json['quantity'];
//     description = json['description'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['event_id'] = this.eventId;
//     data['title'] = this.title;
//     data['price'] = this.price;
//     data['quantity'] = this.quantity;
//     data['description'] = this.description;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
class HostedEventsOfUser {
  final int? code;
  final String? status;
  final String? message;
  final int? count;
  final List<Event>? data;
  HostedEventsOfUser({
    this.code,
    this.status,
    this.message,
    this.count,
    this.data,
  });
  factory HostedEventsOfUser.fromJson(Map<String, dynamic> json) {
    return HostedEventsOfUser(
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
  final int? id;
  final String? guid;
  final int? categoryId;
  final int? userId;
  final int? countryId;
  final int? neighborhoodId;
  final int? universityId;
  final int? programId;
  final String? title;
  final String? description;
  final String? image;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? startTime;
  final String? endTime;
  final double? price;
  final int? ageMin;
  final int? ageMax;
  final int? limitEntrance;
  final int? entranceLimitMin;
  final int? entranceLimitMax;
  final int? accountFollow;
  final String? location;
  final int? eventType;
  final String? latitude;
  final String? longitude;
  final int? featured;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Ticket>? tickets;

  Event({
    this.id,
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
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      startTime: json['start_time'],
      endTime: json['end_time'],
      price: json['price'] != null ? double.tryParse(json['price'].toString()) : null,
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
  final int? id;
  final int? eventId;
  final String title;
  final double? price;
  final int? quantity;
  final String? description;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
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