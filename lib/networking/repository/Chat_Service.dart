import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constant.dart';
import '../../model/eventcreationModel.dart';

class ChatMessageService {
  String auth_token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vcGlwdGVzdG5ldC5jb20vYXBpL2xvZ2luIiwiaWF0IjoxNjkzOTMyNjc4LCJleHAiOjE2OTM5MzYyNzgsIm5iZiI6MTY5MzkzMjY3OCwianRpIjoiY1E5R1ZNU0E3eUdEZlBlUiIsInN1YiI6IjYiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.lNYZohf4V49hoGdMYBg_YdyLDWexGm3CX6EPLgbPkRQ";

  // ChatMessageService(String token);

  //------------------------------------------------Send Message------------------------------------------------

  Future<dynamic> sendMessage(
      String senderId, String recipientId, String content) async {
    // try {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    print("object$senderId$recipientId$content");
    final body = jsonEncode({
      'sender_id': senderId,
      'recipient_id': recipientId,
      'content': content,
    });
    var url = Uri.parse("http://piptestnet.com/api/send-message");
    final response = await http.post((url), headers: headers, body: body);

    if (response.statusCode == 200) {
      print("message saved to DB Successfully!");
      return response.body;
    } else {
      print("error");
    }
    // } catch (error) {
    //   throw Exception('Failed to send message. Error: $error');
    // }
  }

  //------------------------------------------------Get MessageThreads/Inboxes------------------------------------------------

  List<dynamic> getallthread = [];

  getMessageThreads() async {
    // print("response" + response.toString());
    print("object$userToken");
    SharedPreferences userpref = await SharedPreferences.getInstance();
    var myId = userpref.getInt("userId");
    // try {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    final body = jsonEncode({
      'user_id': myId,
    });
    var url = Uri.parse("http://piptestnet.com/api/inbox");
    var response = await http.post(url, headers: headers, body: body);
    print("response$response");
    var data = jsonDecode(response.body);
    print("data$data");
    // var body = json.encode(data);
    // var newstrr = jsonDecode(body);
    if (response.statusCode == 200) {
      if (data.containsKey('data')) {
        getallthread = data['data'];
      }
      // for (Map<String, dynamic> index in data) {
      //   getallthread.add(ChatMessageModel.fromJson(index));
      // }
      return getallthread;
    } else {
      return getallthread;
    }
    // } catch (e) {
    //    print(e);
  }

  //------------------------------------------------Get Messages------------------------------------------------

  List<dynamic> getallMessages = [];

  Future<List<dynamic>> getMessages(String convId) async {
    // print("response" + response.toString());
    SharedPreferences userpref = await SharedPreferences.getInstance();
    var myId = userpref.getInt("userId");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    final body = jsonEncode({
      'conversation_id': convId,
    });
    var url = Uri.parse("http://piptestnet.com/api/get-messages");
    var response = await http.post(url, headers: headers, body: body);
    print("response$response");
    var data = jsonDecode(response.body);
    print("data$data");
    // var body = json.encode(data);
    // var newstrr = jsonDecode(body);
    if (response.statusCode == 200) {
      if (data.containsKey('data')) {
        getallMessages = data['data'];
      }
      // for (Map<String, dynamic> index in data) {
      //   getallthread.add(ChatMessageModel.fromJson(index));
      // }
      return getallMessages;
    } else {
      return [];
    }
  }

  Future<EventResponseModel?> PostEventCreate(
    String bearerToken,
    int categoryId,
    // int? userId,
    int countryId,
    // int? neighborhoodId,
    int universityId,
    int programId,
    String title,
    String description,
    String image,
    String startDate,
    // String startTime,
    // String endDate,
    // String endTime,
    String price,
    String ageMin,
    String ageMax,
    bool limitEntrance,
    String minEntrance,
    String maxEntrance,
    String location,
    String latitude,
    String longitude,
    bool publicEvent,
    bool forFollowers,
    String freeTitle,
    String freeDescription,
    String freeQunatity,
    String paidTitle,
    String paidDescription,
    String paidQunatity,
  ) async {
    final data = {
      // 'guid':guid,
      'category_id': categoryId,
      // 'user_id':userId,
      'country_id': countryId,
      // 'neighborhood_id':neighborhoodId,
      'university_id': universityId,
      'program_id': programId,
      'title': title,
      'description': description,
      'image': image,
      'start_date': startDate,
      // 'end_date':endDate,
      // 'start_time':startTime,
      // 'end_time':endTime,
      'price': price,
      'age_min': ageMin,
      'age_max': ageMax,
      'limit_entrance': limitEntrance,
      'min_entrance': minEntrance,
      'max_entrance': maxEntrance,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'public_event': publicEvent,
      'for_followers': publicEvent ? null : forFollowers,
      // 'tickets':tickets,
      'ft_title': freeTitle,
      'ft_description': freeDescription,
      'ft_quantity': freeQunatity,
      'pt_title': paidTitle,
      'pt_description': paidDescription,
      'pt_quantity': paidQunatity,
      // 'accountFollow':accountFollow,
      // 'status': status,
      // "tickets":tickets,
      // 'featured':featured,
    };

    log("dataaa$data");
//encode Map to JSON
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken'
      };
      var dio = Dio();
      var response = await dio.request('http://piptestnet.com/api/events/store',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data);

      if (response.statusCode == 200) {
        if (response.data['code'] == 200) {
          final value = EventResponseModel.fromJson(response.data);
          print("value$value");
          return value;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
