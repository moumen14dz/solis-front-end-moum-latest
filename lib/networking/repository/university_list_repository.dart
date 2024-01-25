import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/model/universities_model.dart';
import 'package:newproject/networking/rest_client/rest_client.dart';
import 'package:newproject/providers/global_providers.dart';
import 'package:newproject/utils/handler/network_response_handler.dart';

import '../../view_models/university_list_notifier.dart';

abstract class UniversityListRepository {
  Future<NetworkResponseHandler<UniversitiesModel>> getListOfUniversities();
}

final universityListRepositoryProvider =
Provider<UniversityListRepositoryImpl>((ref) {
  return UniversityListRepositoryImpl(RestClient(ref.watch(dioProvider)));
});

class UniversityListRepositoryImpl implements UniversityListRepository {
  RestClient client;

  UniversityListRepositoryImpl(this.client);

  @override
  Future<NetworkResponseHandler<UniversitiesModel>> getListOfUniversities() async{
    try {
      final response = await client.getListOfUniversities();
      print("$TAG : 000 ${response.status}");
      if (response.code == 200) {
        debugPrint("$TAG : 100");
        return NetworkResponseHandler(
          isSuccess: true,
          data: response,
        );
      } else {
        debugPrint("$TAG : 500 ${response.message ?? 'Unknown error'}");
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: response.message ?? 'Unknown error',
        );
      }
    } catch (e) {
      print("An exception was caught: $e");
      debugPrint("$TAG : 1000 $e");
      if (e is DioError) {
        debugPrint("$TAG : 450 $e");
        // Handle Dio specific errors here
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: e.message,
        );
      } else {
        debugPrint("$TAG : 250 $e");
        // Handle other kinds of errors
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: 'Unknown error occurred',
        );
      }
    }
  }
}
