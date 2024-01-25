import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:newproject/common/constant.dart';
import 'package:newproject/providers/global_providers.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/showtoast.dart';
import '../../../view_models/checkout_notifier.dart';

class PaymentTextFieldWidget extends ConsumerStatefulWidget {
  final String amount;

  final String booking_date;
  final String booking_enddate;
  final String booking_startTime;
  final String booking_endTime;
  final String ticketCounts;
  final String eventId;

  const PaymentTextFieldWidget(
      {super.key,
      required this.amount,
      required this.booking_date,
      required this.booking_enddate,
      required this.booking_startTime,
      required this.booking_endTime,
      required this.ticketCounts,
      required this.eventId});

  @override
  ConsumerState<PaymentTextFieldWidget> createState() =>
      _PaymentTextFieldWidgetState();
}

class _PaymentTextFieldWidgetState
    extends ConsumerState<PaymentTextFieldWidget> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool? rememberme = true;

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      //navigatorKey: _dialogNavigatorKey,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Checking Payment info..."),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //final observeCheckout = ref.watch(checkoutNotifierProvider);
    final tokenFuture = ref.read(authTokenProvider.future);
    

    ref.listen<CheckoutState>(checkoutNotifierProvider,
        (prevState, currentState) {
      print("Received state: $currentState"); // Log this
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (currentState is CheckoutLoading) {
        } else if (currentState is CheckoutSuccess) {
          scaffoldMessengerKey.currentState!
              .hideCurrentSnackBar(); // Dismiss the loading snackbar
          showToasterror(currentState.response.message);
          Navigator.pop(scaffoldMessengerKey.currentContext!);
        } else if (currentState is CheckoutError) {
          scaffoldMessengerKey.currentState!
              .hideCurrentSnackBar(); // Dismiss the loading snackbar
          String errorMessage = currentState.errorMessage;
          showToasterror(errorMessage.toString());
        }
      });
    });

    return ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Column(
          children: [
            widget.amount == '0.00'
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Nom du titulaire de la carte",
                          style: TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: cardName,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: const Color(0xff32373E),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: mainTextFormColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: mainTextFormColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: mainTextFormColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: mainTextFormColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: "Entrer le nom",
                            hintStyle: const TextStyle(color: Color(0xff949494)),
                          ),
                        )
                      ],
                    ),
                  ),
            widget.amount == '0.00'
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Number'.tr,
                          style: const TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: cardNumber,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/Visa.png",
                                width: 35,
                                height: 24,
                              ),
                            ),
                            border: InputBorder.none,
                            fillColor: const Color(0xff32373E),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: mainTextFormColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: mainTextFormColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: mainTextFormColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: mainTextFormColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: "Card Number".tr,
                            hintStyle: const TextStyle(color: Color(0xff949494)),
                          ),
                        )
                      ],
                    ),
                  ),
            widget.amount == '0.00'
                ? Container()
                : Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Date d’expiration",
                                style: TextStyle(
                                    color: Color(0xffF9FAFB),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: cardDate,
                                keyboardType: TextInputType.text,
                                maxLength: 5,
                                // Limiting to MMYY format
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  MaskTextInputFormatter(mask: '##/##'),
                                  // This will add the '/' separator
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: const Color(0xff32373E),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: mainTextFormColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: mainTextFormColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: mainTextFormColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: mainTextFormColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  counterText: '',
                                  // to hide the counter, even though we're limiting length
                                  hintText: "MM/YY",
                                  hintStyle:
                                      const TextStyle(color: Color(0xff949494)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "CVV",
                                style: TextStyle(
                                    color: Color(0xffF9FAFB),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: cvv,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: const Color(0xff32373E),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: mainTextFormColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: mainTextFormColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: mainTextFormColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: mainTextFormColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: "000",
                                  hintStyle:
                                      const TextStyle(color: Color(0xff949494)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
            widget.amount == '0.00'
                ? Container()
                : CheckboxListTile(
                    activeColor: const Color(0xff474F57),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                      'Se rappeler de ma carte',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: rememberme,
                    onChanged: (bool? value) {
                      setState(() {
                        rememberme = value;
                      });
                    },
                  ),
            widget.amount == '0.00'
                ? Container()
                : const SizedBox(
                    height: 20,
                  ),
            SaveButton(
                title: widget.amount == '0.00' ? 'Sign Up'.tr : "Pay".tr,
                onTap: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Row(
                        children: [
                          CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text("Checking Payment info..."),
                          )
                        ],
                      ),
                    ),
                  );
                  String authToken ='';
// Make sure you're inside a build method or another location where you can use 'watch'
                await  tokenFuture.then((token) async {
                  if (token.isEmpty) {
                            SharedPreferences userpref = await SharedPreferences.getInstance();
       authToken =    userpref.getString(authTokenIdentifier)!;

                    log('authToken$authToken');
                   // _performCheckout(ref, token);
                  }
                  else{ authToken = token;}
                
                  _performCheckout(ref,authToken);
                });
   }) ],
        ));
  }

  setDate(context, TextEditingController controller) {
    showDatePicker(
      context: context,
      initialDate: controller.text.isNotEmpty
          ? DateFormat('dd/MM/yyyy').parse(controller.text)
          : DateTime.now(),
      firstDate: DateTime(1950, 01, 01),
      lastDate: DateTime(2100, 01, 01),
    ).then((value) {
      if (value != null) {
        controller.text = DateFormat('dd/MM/yyyy').format(value);
      }
    });
  }

  Future<void> _performCheckout(WidgetRef ref, String token) async {
    log(selectedTickets!.length.toString());
    if (selectedQuantityController.text.isEmpty ||
        selectedQuantityController.text == "0") {
      showToasterror("Please add Quantity");
    } else if (selectedTickets!.isEmpty) {
      //  showToasterror("Please Select Ticket");
    } else if (widget.amount == '0.00') {
      debugPrint("Bearer $token");
      //_showLoadingDialog();

      SharedPreferences userpref = await SharedPreferences.getInstance();
      int userIdd = userpref.getInt("userId")!;
      final checkoutNotifier = ref.read(checkoutNotifierProvider.notifier);
      print("token$userToken");
      CheckoutParams params = CheckoutParams(
          "Bearer$token",
          selectedTickets!,
          widget.eventId,
          widget.booking_date,
          widget.booking_enddate,
          widget.booking_startTime,
          widget.booking_endTime,
          userIdd.toString(),
          //userToken,
          "abc",
          "4242424242424242",
          "12",
          "24",
          "234",
          widget.amount);

      checkoutNotifier.setCheckoutParams(params);
      checkoutNotifier.attemptToCheckout(context, rememberme!);
      selectedQuantityController.text = '0';
    } else {
      if (cardName.text == "") {
        showToasterror("Invalid Card Name");
      } else if (cardNumber.text == "" || cardNumber.text.length < 10) {
        showToasterror("Invalid Card Number");
      } else if (cvv.text == "" || cardNumber.text.length < 3) {
        showToasterror("Invalid cvv");
      } else if (cardNumber.text == "") {
        showToasterror("Invalid CardNumber");
      } else {
        debugPrint("Bearer $token");
        //_showLoadingDialog();
        String input = cardDate.text; // "MM/YY" format

        List<String> parts = input.split('/');

        if (parts.length == 2) {
          int? month = int.tryParse(parts[0]);
          int? year = int.tryParse(parts[1]);

          if (month != null && year != null) {
            if (month >= 1 &&
                month <= 12 &&
                year >= DateTime.now().year - 2000) {
              print("Month: $month, Year: $year");
              SharedPreferences userpref =
                  await SharedPreferences.getInstance();
              int userIdd = userpref.getInt("userId")!;
              final checkoutNotifier =
                  ref.read(checkoutNotifierProvider.notifier);
              print("token$userToken");
              CheckoutParams params = CheckoutParams(
                  "Bearer$token",
                  selectedTickets!,
                  widget.eventId,
                  widget.booking_date,
                  widget.booking_enddate,
                  widget.booking_startTime,
                  widget.booking_endTime,
                  userIdd.toString(),
                  //userToken,
                  cardName.text.trim().toString(),
                  cardNumber.text.trim().toString(),
                  month.toString(),
                  year.toString(),
                  cvv.text.trim().toString(),
                  widget.amount);

              checkoutNotifier.setCheckoutParams(params);
              checkoutNotifier.attemptToCheckout(context, rememberme!);
              selectedQuantityController.clear();
            } else {
              // Navigator.pop(context);
              print("Invalid month or year");
              showToasterror("Invalid month or year");
            }
          } else {
            //  Navigator.pop(context);
            print("Parsing error!");
            showToasterror("Parsing error!");
          }
        } else {
          showToasterror("Add all Fields");
        }
      }
    }
  }
}
