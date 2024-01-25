class EventResponseModel {
  final int? code;
  final String? status;
  final String? message;
  final int? count;
  final List<EventModel>? data;
  EventResponseModel({
    this.code,
    this.status,
    this.message,
    this.count,
    this.data,
  });
  factory EventResponseModel.fromJson(Map<String, dynamic> json) {
    return EventResponseModel(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      count: json['count'],
      data: json['data'] != null && json['data'] is List
          ? (json['data'] as List)
              .map((eventJson) => EventModel.fromJson(eventJson))
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

class EventModel {
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
  double? price;
  int? ageMin;
  int? ageMax;
  bool? limitEntrance;
  int? entranceLimitMin;
  int? entranceLimitMax;
  dynamic accountFollow;
  String? location;
  String? eventType;
  String? latitude;
  String? longitude;
  bool? publicEvent;
  bool? forFollowers;
  int? featured;
  String? status;
  String? freeTitle;
  String? freeDescription;
  String? freeQuantity;
  String? paidTitle;
  String? paidDescription;
  String? paidQuantity;

  DateTime? createdAt;
  DateTime? updatedAt;
  // List<Ticket>? tickets;

  EventModel({
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
    this.eventType,
    this.latitude,
    this.longitude,
    this.featured,
    this.status,
    this.publicEvent,
    this.forFollowers,
    this.freeTitle,
    this.freeDescription,
    this.freeQuantity,
    this.paidTitle,
    this.paidDescription,
    this.paidQuantity,
    this.createdAt,
    this.updatedAt,
    // this.tickets,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
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
      // tickets: json['tickets'] != null
      //     ? (json['tickets'] as List)
      //     .map((ticketJson) => Ticket.fromJson(ticketJson))
      //     .toList()
      //     : null,
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
      'start_date': startDate,
      'end_date': endDate,
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
      // 'tickets': tickets?.map((ticket) => ticket.toJson()).toList(),
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

class Ticket2 {
  final int? id;
  final int? eventId;
  final String ticket_title;
  final double? price;
  final int? quantity;
  final String? description;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Ticket2({
    this.id,
    this.eventId,
    required this.ticket_title,
    this.price,
    this.quantity,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
  factory Ticket2.fromJson(Map<String, dynamic> json) {
    return Ticket2(
      id: json['id'],
      eventId: json['event_id'],
      ticket_title: json['ticket_title '],
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
      'ticket_title ': ticket_title,
      'price': price,
      'quantity': quantity,
      'description': description,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
