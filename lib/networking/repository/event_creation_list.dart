import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/networking/rest_client/rest_client.dart';
import 'package:newproject/providers/global_providers.dart';
import 'package:newproject/utils/handler/network_response_handler.dart';

import '../../model/eventcreationModel.dart';

abstract class EventCreationRepository {
  Future<NetworkResponseHandler<EventResponseModel>> createEvents({
    required String bearerToken,
    required int categoryId,
    int? userId,
    required int countryId,
    // int? neighborhoodId,
    required int universityId,
    required int programId,
    required String title,
    required String description,
    required String image,
    required String startDate,
    required String startTime,
    required String endDate,
    required String endTime,
    required String price,
    required String ageMin,
    required String ageMax,
    required bool limitEntrance,
    required String minEntrance,
    required String maxEntrance,
    required int city,
    required String location,
    required String latitude,
    required String longitude,
    required bool publicEvent,
    required bool forFollowers,
    required String freeTitle,
    required String freeDescription,
    required String freeQunatity,
    required String paidTitle,
    required String paidDescription,
    required String paidQunatity,
    // required String city,

    required List<Map<String, dynamic>> tickets,
    required String is_redirected,
    required String ticketing_link,
  });
}

final eventRepositoryProvider = Provider<CreateEventRepositoryImpl>((ref) {
  return CreateEventRepositoryImpl(RestClient(ref.watch(dioProvider)));
});

class CreateEventRepositoryImpl implements EventCreationRepository {
  RestClient client;

  CreateEventRepositoryImpl(this.client);

  @override
  Future<NetworkResponseHandler<EventResponseModel>> createEvents({
    required String bearerToken,
    required int categoryId,
    int? userId,
    required int countryId,
    // int? neighborhoodId,
    required int universityId,
    required int programId,
    required String title,
    required String description,
    required String image,
    required String startDate,
    required String endDate,
    required String startTime,
    required String endTime,
    required String price,
    required String ageMin,
    required String ageMax,
    required bool limitEntrance,
    required String minEntrance,
    required String maxEntrance,
    required int city,
    required String location,
    required String latitude,
    required String longitude,
    required bool publicEvent,
    required bool forFollowers,
    required String freeTitle,
    required String freeDescription,
    required String freeQunatity,
    required String paidTitle,
    required String paidDescription,
    required String paidQunatity,
    required List<Map<String, dynamic>> tickets,
    required String is_redirected,
    required String ticketing_link,
  }) async {
    if (kDebugMode) {
      print("bearer_token$bearerToken");
    }
    if (kDebugMode) {
      print("category$categoryId");
    }
    if (kDebugMode) {
      print("category$universityId");
    }
    // print("category"+endDate.toString());
    print("cityy$city");

    try {
      final response = await client.postEvent(
          // guid!,
          bearerToken,

          // bearerToken,
          categoryId,
          userId,
          countryId,
          // neighborhoodId,
          universityId,
          programId,
          title,
          description,
          image,
          startDate,
          endDate,
          startTime,
          endTime,
          price,
          ageMin,
          ageMax,
          limitEntrance,
          minEntrance,
          maxEntrance,
          city,
          location,
          latitude,
          longitude,
          publicEvent,
          forFollowers,
          freeTitle,
          freeDescription,
          freeQunatity,
          paidTitle,
          paidDescription,
          paidQunatity,
          tickets,
          is_redirected,
          ticketing_link);

      print("STORE_EVENT_API: ${response.toString()}");

      if (response.code == 200) {
        print("hello");
        return NetworkResponseHandler(
          isSuccess: true,
          data: response,
        );
      } else {
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: response.message ?? 'Unknown error',
        );
      }
    } catch (e) {
      print("An exception was caught: $e");
      if (e is DioError) {
        // Handle Dio specific errors here
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: e.message,
        );
      } else {
        // Handle other kinds of errors
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: 'Message: ${e.toString()}',
        );
      }
    }
  }
}




// final response = await client.postData(
//   "firstName",
//   "lastName",
//   "bio",
//   "abdulha@gmail.com",
//   "123456789",
//   "student",
//   "25",
//   "1",
//   "2",
//   "3",
//   "4",
//   "associationName",
//   "businessName",
//   "businessAddress",
//   "city",
//   "5501",
// );