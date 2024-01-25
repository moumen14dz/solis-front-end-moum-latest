import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/networking/rest_client/rest_client.dart';
import 'package:newproject/providers/global_providers.dart';
import 'package:newproject/utils/handler/network_response_handler.dart';

import '../../model/programs_model.dart';

abstract class ProgramsRepository {
  Future<NetworkResponseHandler<ProgramsModel>> getListOfPrograms();
}

final programsRepositoryProvider =
Provider<ProgramsRepositoryImpl>((ref) {
  return ProgramsRepositoryImpl(RestClient(ref.watch(dioProvider)));
});

class ProgramsRepositoryImpl implements ProgramsRepository {
  RestClient client;

  ProgramsRepositoryImpl(this.client);

  @override
  Future<NetworkResponseHandler<ProgramsModel>> getListOfPrograms() async{
    try {
      final response = await client.getListOfPrograms();
      if (response.code == 200) {
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
          errorMessage: 'Unknown error occurred',
        );
      }
    }
  }
}
