import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/payment_response_model.dart';
import '../../providers/global_providers.dart';
import '../../utils/handler/network_response_handler.dart';
import '../rest_client/rest_client.dart';

abstract class CheckoutRepository {
  Future<NetworkResponseHandler<PaymentResponse>> attemptCheckout(
      {required String token,
      required String cardNumber,
      required String monthExpire,
      required String yearExpire,
      required String cvv,
      required String amount});
}

final checkoutRepositoryProvider = Provider<CheckoutRepositoryImpl>((ref) {
  return CheckoutRepositoryImpl(RestClient(ref.watch(dioProvider)));
});

class CheckoutRepositoryImpl implements CheckoutRepository {
  RestClient client;
  String userToken = '';

  CheckoutRepositoryImpl(this.client);

  @override
  Future<NetworkResponseHandler<PaymentResponse>> attemptCheckout(
      {required String token,
      required String cardNumber,
      required String monthExpire,
      required String yearExpire,
      required String cvv,
      required String amount}) async {
    try {
      final response = await client.performCheckout(
          token, cardNumber, monthExpire, yearExpire, cvv, amount);
      return NetworkResponseHandler(
        isSuccess: true,
        data: response,
      );
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
