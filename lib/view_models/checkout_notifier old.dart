/* import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/model/log_in_model.dart';
import 'package:newproject/model/payment_response_model.dart';
import 'package:newproject/networking/repository/checkout_repository.dart';
import 'package:newproject/networking/repository/log_in_repository.dart';

import 'checkout_notifier.dart';

class CheckoutParams {
  late final String token;
  late final String cardNumber;
  late final String monthExpire;
  late final String yearExpire;
  late final String cvv;
  late final String amount;

  CheckoutParams(this.token, this.cardNumber,this.monthExpire, this.yearExpire, this.cvv, this.amount);
}

final checkoutNotifierProvider = StateNotifierProvider.autoDispose<CheckoutNotifier, CheckoutState>(
      (ref) {
    return CheckoutNotifier(ref.watch(checkoutRepositoryProvider));
  },
);

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  final CheckoutRepository _repository;
  CheckoutParams? checkoutParams;

  CheckoutNotifier(this._repository) : super(CheckoutInitial());

  void setCheckoutParams(CheckoutParams p) {
    checkoutParams = p;
  }

  Future<void> attemptToCheckout() async {
    if (!mounted) return;  // Return early if not mounted

    if (checkoutParams == null) {
      state = CheckoutError('CheckoutParams not set');
      return;
    }

    try {
      state = CheckoutLoading();

      final response = await _repository.attemptCheckout(
        token: checkoutParams!.token,
        cardNumber: checkoutParams!.cardNumber,
        monthExpire: checkoutParams!.monthExpire,
        yearExpire: checkoutParams!.yearExpire,
        cvv: checkoutParams!.cvv,
        amount: checkoutParams!.amount,
      );

      if (mounted) {  // Check again before setting state
        if (response.isSuccess) {
          state = CheckoutSuccess(response.data!);
        } else {
          state = CheckoutError(response.errorMessage.toString());
        }
      }
    } catch (error) {
      if (mounted) {  // Check again before setting state
        state = CheckoutError(error.toString());
      }
    }
  }
}


class CheckoutState {}
class CheckoutInitial extends CheckoutState {}
class CheckoutLoading extends CheckoutState {}
class CheckoutSuccess extends CheckoutState {
  final PaymentResponse response;

  CheckoutSuccess(this.response);
}
class CheckoutError extends CheckoutState {
  final String errorMessage;

  CheckoutError(this.errorMessage);
}
 */