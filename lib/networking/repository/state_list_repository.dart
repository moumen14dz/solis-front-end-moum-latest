import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/networking/rest_client/rest_client.dart';
import 'package:newproject/providers/global_providers.dart';
import 'package:newproject/utils/handler/network_response_handler.dart';

import '../../model/state_list_model.dart';

abstract class StateListRepository {
  Future<NetworkResponseHandler<StateListModel>> getListOfStateByCountryId({required int countryId});
}

final stateListRepositoryProvider =
Provider<StateListRepositoryImpl>((ref) {
  return StateListRepositoryImpl(RestClient(ref.watch(dioProvider)));
});

class StateListRepositoryImpl implements StateListRepository {
  RestClient client;

  StateListRepositoryImpl(this.client);

  @override
  Future<NetworkResponseHandler<StateListModel>> getListOfStateByCountryId(
      {required int countryId}
      ) async{
    try {
      final response = await client.getStatesListByCountryId(countryId);
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
