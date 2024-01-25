import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/model/logout_model.dart';
import 'package:newproject/networking/rest_client/rest_client.dart';
import 'package:newproject/providers/global_providers.dart';
import 'package:newproject/utils/handler/network_response_handler.dart';

abstract class LogOutRepository {
  Future<NetworkResponseHandler<LogoutResponseModel>> attemptLogOut({
    required String bearerToken,
  });
}

final logOutRepositoryProvider =
Provider<LogOutRepositoryImpl>((ref) {
  return LogOutRepositoryImpl(RestClient(ref.watch(dioProvider)));
});

class LogOutRepositoryImpl implements LogOutRepository {
  RestClient client;

  LogOutRepositoryImpl(this.client);

  @override
  Future<NetworkResponseHandler<LogoutResponseModel>> attemptLogOut(
      { required String bearerToken,
      }) async{
    try {
      final response = await client.attemptToLogOut(
          bearerToken
      );
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
