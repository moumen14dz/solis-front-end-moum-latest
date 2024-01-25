import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/model/payment_response_model.dart';
import 'package:newproject/networking/repository/checkout_repository.dart';
import 'package:newproject/utils/controllers.dart';

import '../model/getEventDetails.dart';
import '../screens/dashboard/main_dashboard.dart';

class CheckoutParams {
  late final String token;
  late List<Tickets> selectedTickets;
  late final String cardNumber;
  late final String cardName;

  late final String event_id;

  late final String booking_date;
  late final String booking_end_date;
  late final String start_time;
  late final String end_time;
  late final String customer_id;

  late final String monthExpire;
  late final String yearExpire;
  late final String cvv;
  late final String amount;

  CheckoutParams(
      this.token,
      this.selectedTickets,
      this.event_id,
      this.booking_date,
      this.booking_end_date,
      this.start_time,
      this.end_time,
      this.customer_id,
      this.cardName,
      this.cardNumber,
      this.monthExpire,
      this.yearExpire,
      this.cvv,
      this.amount);
}

final checkoutNotifierProvider =
    StateNotifierProvider.autoDispose<CheckoutNotifier, CheckoutState>(
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

  Future<void> attemptToCheckout(context, bool rememberme) async {
    log("checkoutParams${checkoutParams!.selectedTickets.first.quantity}");
    if (!mounted) return; // Return early if not mounted

    if (checkoutParams == null) {
      state = CheckoutError('CheckoutParams not set');
      return;
    }
    try {
      state = CheckoutLoading();

      final response = await _repository.attemptCheckout(
        token: checkoutParams!.token,
        selectedTickets: checkoutParams!.selectedTickets,
        event_id: checkoutParams!.event_id,
        customer_id: checkoutParams!.customer_id,
        booking_date: checkoutParams!.booking_date,
        booking_end_date: checkoutParams!.booking_end_date,
        start_time: checkoutParams!.start_time,
        end_time: checkoutParams!.end_time,
        cardName: checkoutParams!.cardName,
        cardNumber: checkoutParams!.cardNumber,
        monthExpire: checkoutParams!.monthExpire,
        yearExpire: checkoutParams!.yearExpire,
        cvv: checkoutParams!.cvv,
        amount: checkoutParams!.amount,
      );

      log("succcdata${response.data!.message}");
      log("succcdata${response.data!.message2}");
      log("succcdataa${response.errorMessage}");

      if (response.isSuccess) {
        if (!rememberme) {
          cardName.clear();
          cardDate.clear();
          cvv.clear();
          cardName.clear();
        }
        //    state = CheckoutSuccess(response.data!);
        //
        /*       if (response.data!.message2 == "success") {
          Navigator.pop(context);
          log("successsss");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreen(
                        token: true,
                        currentIndexOfMainScreenBottomBar: 0,
                      )));
        } */
      }
      if (mounted) {
        // Check again before setting state
        if (response.data!.message2 == "success") {
          Navigator.pop(context);

          state = CheckoutSuccess(response.data!);

          log("successsss");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainScreen(
                        token: true,
                        currentIndexOfMainScreenBottomBar: 0,
                      )));
        } else {
          state = CheckoutError(response.data!.message.toString());
        }
      }
    } catch (error) {
      if (mounted) {
        // Check again before setting state
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
