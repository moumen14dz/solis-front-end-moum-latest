import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/constant.dart';
import '../../model/log_in_model.dart';
import '../../providers/global_providers.dart';
import '../../utils/handler/network_response_handler.dart';
import '../rest_client/rest_client.dart';

abstract class LogInRepository {
  Future<NetworkResponseHandler<LoginResponseModel>> attemptLogIn({
    required String email,
    required String password,
    String? device_token,
  });
}

final logInRepositoryProvider =
Provider<LogInRepositoryImpl>((ref) {
  return LogInRepositoryImpl(RestClient(ref.watch(dioProvider)));
});

class LogInRepositoryImpl implements LogInRepository {
  RestClient client;
  String userToken='';
  LogInRepositoryImpl(this.client);

  @override
  Future<NetworkResponseHandler<LoginResponseModel>> attemptLogIn({
    required String email,
    required String password,
     String? device_token,

  }) async {
    try {
      final response = await client.attemptToLogIn(email, password,device_token!);
      if (response.code == 200 &&
          response.status.toString() ==
              ApiResponseStatusEnum.success.toString()) {
        userToken = response.data.token;
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
