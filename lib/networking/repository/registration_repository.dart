import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/model/registration_model.dart';
import 'package:newproject/networking/rest_client/rest_client.dart';
import 'package:newproject/providers/global_providers.dart';
import 'package:newproject/utils/handler/network_response_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class RegistrationRepository {
  Future<NetworkResponseHandler<RegistrationModel>> attemptRegister({
    required String username,
    required String firstName,
    required String lastName,
    required String bio,
    required String email,
    required String password,
    required String userType,
    required String age,
    required String countryId,
    required String stateId,
    required String universityId,
    required String programId,
    required String associationName,
    required String businessName,
    required String businessAddress,
    required String city,
    required String postalCode,
    String? device_token,
  });
}

final regRepositoryProvider = Provider<RegistrationRepositoryImpl>((ref) {
  return RegistrationRepositoryImpl(RestClient(ref.watch(dioProvider)));
});

class RegistrationRepositoryImpl implements RegistrationRepository {
  RestClient client;

  RegistrationRepositoryImpl(this.client);

  @override
  Future<NetworkResponseHandler<RegistrationModel>> attemptRegister({
    required String username,
    required String firstName,
    required String lastName,
    required String bio,
    required String email,
    required String password,
    required String userType,
    required String age,
    required String countryId,
    required String stateId,
    required String universityId,
    required String programId,
    required String associationName,
    required String businessName,
    required String businessAddress,
    required String city,
    required String postalCode,
    String? device_token,
  }) async {
    try {
      final response = await client.postData(
          username,
          firstName,
          lastName,
          bio,
          email,
          password,
          userType,
          age,
          countryId,
          stateId,
          universityId,
          programId,
          associationName,
          businessName,
          businessAddress,
          city,
          postalCode,
          device_token!);

      print("REGISTER_API: ${response.toJson()}");

      SharedPreferences sharedPrefss = await SharedPreferences.getInstance();
      if (response.code == 200) {
        log("ddd$password");

        await sharedPrefss.setString('email', email);
        await sharedPrefss.setString('password', password);
        return NetworkResponseHandler(
          isSuccess: true,
          data: response,
        );
      } else {
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: response.message,
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
