import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newproject/common/constant.dart';
import 'package:newproject/model/eventcreationModel.dart';
import 'package:newproject/networking/repository/expansion_provider.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/showtoast.dart';
import 'package:newproject/utils/textformfield.dart';

import '../../utils/buttons.dart';
import '../../view_models/event_creation_notifier.dart';
import '../dashboard/main_dashboard.dart';
import '../preview/preview_event.dart';

class TicketPage extends ConsumerStatefulWidget {
  final bool isFree;

  final String title;
  final XFile? image;
  final String startdate;
  final String endDate;

  final String startTime;
  final String endTime;

  final String description;
  final String location;
  final int city;

  final String min_age;
  final String max_age;
  final String price;
  final int countryId;
  final int universityId;
  final int categoryId;
  final String latitude;
  final String longitude;
  final bool isPublic;
  final bool followAccount;
  final bool limitEntrance;
  final String maxEntrance;
  final String minEntrance;
  const TicketPage({
    super.key,
    required this.isFree,
    required this.title,
    required this.image,
    required this.startdate,
    required this.city,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.location,
    required this.countryId,
    required this.universityId,
    required this.categoryId,
    required this.price,
    required this.min_age,
    required this.max_age,
    required this.latitude,
    required this.longitude,
    required this.isPublic,
    required this.followAccount,
    required this.limitEntrance,
    required this.maxEntrance,
    required this.minEntrance,
  });

  @override
  ConsumerState<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends ConsumerState<TicketPage> {
  final bool _isPasswordHidden = true; // Default: Password is hidden
  final checkboxStateProvider = StateProvider<bool>((ref) => false);
  bool limitSelected = false;
  @override
  Widget build(BuildContext context) {
    log(" location${widget.location}");
    final islimitChecked = ref.watch(checkboxStateProvider);

    final isExpanded1 = ref.watch(expansionpriceStateProvider);
    return WillPopScope(
      onWillPop: () async {
        currentIndexOfMainScreenBottomBar = 2;
        Get.offAll(const MainScreen(
          token: false,
          currentIndexOfMainScreenBottomBar: 0,
        ));
        return await Future.value(false);
      },
      child: Scaffold(
          backgroundColor: const Color(0x0ff0f616),
          body: Container(
            margin:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(
                    child: Text(
                      "Create Ticket",
                      style: TextStyle(
                          color: Color(0xffF9FAFB),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enter Ticket Title",
                          style: TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormInputField(
                          textInputType: TextInputType.text,
                          hintText: "Enter the title",
                          controller: widget.isFree
                              ? ticketTitleController
                              : paidticketTitleController,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  /*      Text(
                    "Quantity",
                    style: TextStyle(
                        color: Color(0xffF9FAFB),
                        fontWeight: FontWeight.w300,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ), 
                  TextFormInputField(
                    textInputType: TextInputType.number,
                    hintText: "2",
                    controller: ticketQuantityController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),*/
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Description",
                          style: TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: widget.isFree
                              ? ticketDescriptionController
                              : paidticketDescriptionController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintText: "Enter description",
                              hintStyle: TextStyle(color: Color(0xff949494)),
                              fillColor: mainTextFormColor,
                              filled: true,
                              border: InputBorder.none),
                          maxLines: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  /*        Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enter Paid Ticket Title",
                          style: TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormInputField(
                          textInputType: TextInputType.text,
                          hintText: "Enter the title",
                          controller: paidticketTitleController,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Quantity",
                    style: TextStyle(
                        color: Color(0xffF9FAFB),
                        fontWeight: FontWeight.w300,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormInputField(
                    textInputType: TextInputType.number,
                    hintText: "2",
                    controller: paidticketQuantityController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Description",
                          style: TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: paidticketDescriptionController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "Enter description",
                              hintStyle:
                                  const TextStyle(color: Color(0xff949494)),
                              fillColor: mainTextFormColor,
                              filled: true,
                              border: InputBorder.none),
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Price",
                          style: TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormInputField(
                          preIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: const EdgeInsets.only(top: 7),
                              child: Text(
                                "\$",
                                style: TextStyle(color: textColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          textInputType:
                              const TextInputType.numberWithOptions(),
                          hintText: "0.00",
                          controller: ticketPriceController,
                        ),
                      ],
                    ),
                  ),
           */ // InkWell(
                  //   onTap: () {
                  //     // Toggle the expansion state using the provider
                  //     ref.read(expansionpriceStateProvider.notifier).toggle();
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.all(8.0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           "Price",
                  //           style: TextStyle(
                  //             color: Color(0xffF9FAFB),
                  //             fontWeight: FontWeight.w300,
                  //             fontSize: 15,
                  //           ),
                  //         ),
                  //         Icon(
                  //           isExpanded1
                  //               ? Icons.keyboard_arrow_up
                  //               : Icons.keyboard_arrow_down,
                  //           color: Color(0xffF9FAFB),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Divider(
                  //   height: 1,
                  //   color: Colors.grey,
                  //   thickness: 0.1,
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // AnimatedContainer(
                  //   duration: const Duration(milliseconds: 300),
                  //   height: isExpanded1
                  //       ? null
                  //       : 0.0, // Set your desired height or null
                  //   child: Visibility(
                  //     visible: isExpanded1,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Column(
                  //         children: [
                  //           GestureDetector(
                  //             onTap: () {
                  //               ref.read(checkboxStateProvider.notifier).state =
                  //                   !islimitChecked;
                  //               limitSelected = true;
                  //             },
                  //             child: Row(
                  //               children: [
                  //                 Container(
                  //                   width: 28.0,
                  //                   height: 28.0,
                  //                   decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(4.0),
                  //                     color: const Color(0xFF32373E),
                  //                   ),
                  //                   child: islimitChecked
                  //                       ? const Center(
                  //                           child: Icon(
                  //                             Icons.check,
                  //                             size: 16.0,
                  //                             color: Colors.white,
                  //                           ),
                  //                         )
                  //                       : null,
                  //                 ),
                  //                 const SizedBox(width: 8.0),
                  //                 Text(
                  //                   'Paid',
                  //                   style: TextStyle(
                  //                     fontSize: 16.0,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           AnimatedContainer(
                  //             duration: const Duration(milliseconds: 300),
                  //             height: islimitChecked ? null : 0.0,
                  //             child: Visibility(
                  //               visible: islimitChecked,
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(8.0),
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Row(
                  //                       children: [
                  //                         Expanded(
                  //                           child: TextFormInputField(
                  //                             textInputType: TextInputType.text,
                  //                             hintText: "Payment",
                  //                             controller: paymentController,
                  //                           ),
                  //                         ),
                  //                         const SizedBox(
                  //                           width: 10,
                  //                         ),
                  //                         Expanded(
                  //                           child: TextFormInputField(
                  //                             preIcon: Padding(
                  //                               padding:
                  //                                   const EdgeInsets.all(8.0),
                  //                               child: Container(
                  //                                 margin: const EdgeInsets.only(
                  //                                     top: 7),
                  //                                 child: Text(
                  //                                   "\$",
                  //                                   style: TextStyle(
                  //                                       color: textColor),
                  //                                   textAlign: TextAlign.center,
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                             textInputType: const TextInputType
                  //                                 .numberWithOptions(),
                  //                             hintText: "0.00",
                  //                             controller: ticketPriceController,
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           Divider(
                  //             height: 1,
                  //             color: Colors.grey,
                  //             thickness: 0.1,
                  //           ),
                  //           SizedBox(
                  //             height: 10,
                  //           ),
                  //           GestureDetector(
                  //             onTap: () {
                  //               ref.read(checkboxStateProvider.notifier).state =
                  //                   false;
                  //               limitSelected = false;
                  //             },
                  //             child: Row(
                  //               children: [
                  //                 Container(
                  //                   width: 28.0,
                  //                   height: 28.0,
                  //                   decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(4.0),
                  //                     color: const Color(0xFF32373E),
                  //                     border: islimitChecked
                  //                         ? Border.all(
                  //                             color: const Color(0xFF32373E))
                  //                         : null,
                  //                   ),
                  //                   child: islimitChecked
                  //                       ? null
                  //                       : const Center(
                  //                           child: Icon(
                  //                             Icons.check,
                  //                             size: 16.0,
                  //                             color: Colors.white,
                  //                           ),
                  //                         ),
                  //                 ),
                  //                 SizedBox(width: 8.0),
                  //                 const Text(
                  //                   'Free',
                  //                   style: TextStyle(
                  //                     fontSize: 16.0,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 8, top: 8),
                          child: OutlineButton(
                              title: "Preview",
                              onTap: () {
                                if (validateFields()) {
                                  log(widget.startdate);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => PreviewScreen(
                                              title: widget.title,
                                              image: widget.image,
                                              city: widget.city,
                                              location: widget.location,
                                              startdate: widget.startdate,
                                              endDate: widget.endDate,
                                              startTime: widget.startTime,
                                              endTime: widget.endTime,
                                              description: widget.description,
                                              countryId: widget.countryId,
                                              universityId: widget.universityId,
                                              categoryId: widget.categoryId,
                                              price: ticketPriceController.text,
                                              min_age: widget.min_age,
                                              max_age: widget.max_age,
                                              latitude: widget.latitude,
                                              longitude: widget.longitude,
                                              limitEntrance:
                                                  widget.limitEntrance,
                                              minEntrance: widget.minEntrance,
                                              maxEntrance: widget.maxEntrance,
                                              isPublic: widget.isPublic,
                                              followAccount:
                                                  widget.followAccount,
                                              freeTitle:
                                                  ticketTitleController.text,
                                              freeDescription:
                                                  ticketDescriptionController
                                                      .text,
                                              freeQuantity:
                                                  ticketQuantityController.text,
                                              paidTitle:
                                                  paidticketTitleController
                                                      .text,
                                              paidDescription:
                                                  paidticketDescriptionController
                                                      .text,
                                              paidQuantity:
                                                  paidticketQuantityController
                                                      .text,
                                              tickets: widget.isFree
                                                  ? [
                                                      Ticket(
                                                              title:
                                                                  ticketTitleController
                                                                      .text,
                                                              description:
                                                                  ticketDescriptionController
                                                                      .text,
                                                              price: 0,
                                                              quantity: int.parse(
                                                                  ticketQuantityController
                                                                      .text))
                                                          .toJson()
                                                    ]
                                                  : [
                                                      Ticket(
                                                              title:
                                                                  paidticketTitleController
                                                                      .text,
                                                              description:
                                                                  paidticketDescriptionController
                                                                      .text,
                                                              price: double.parse(
                                                                  ticketPriceController
                                                                      .text),
                                                              quantity: int.parse(
                                                                  paidticketQuantityController
                                                                      .text))
                                                          .toJson()
                                                    ])));
                                }
                                // }
                              })),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 8, top: 8),
                          child:
                              // SaveButton(
                              //     title: "Publish".tr,
                              //     onTap: () async {}
                              // ),
                              ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(340, 49),
                                backgroundColor: buttonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () async {
                              log(widget.categoryId.toString());
                              if (validateFields()) {
                                setState(() {
                                  isCreatingEvent =
                                      true; // Set the flag to indicate event creation in progress
                                });
                                // int programId = await getProgramId();
                                List<int> imageBytes =
                                    await widget.image!.readAsBytes();
                                String base64Image = base64Encode(imageBytes);
                                final params = Params1(
                                    widget.categoryId,
                                    userId,
                                    widget.countryId,
                                    widget.universityId,
                                    programId,
                                    widget.title,
                                    widget.description,
                                    base64Image,
                                    widget.startdate,
                                    widget.endDate,
                                    widget.startTime,
                                    widget.endTime,
                                    ticketPriceController.text,
                                    widget.min_age,
                                    widget.max_age,
                                    widget.limitEntrance,
                                    widget.minEntrance,
                                    widget.maxEntrance,
                                    widget.city,
                                    widget.location,
                                    widget.latitude,
                                    widget.longitude,
                                    widget.isPublic,
                                    widget.followAccount,
                                    ticketTitleController.text,
                                    ticketDescriptionController.text,
                                    ticketQuantityController.text,
                                    paidticketTitleController.text,
                                    paidticketDescriptionController.text,
                                    paidticketQuantityController.text,
                                    widget.isFree
                                        ? [
                                            Ticket(
                                                    title: ticketTitleController
                                                        .text,
                                                    description:
                                                        ticketDescriptionController
                                                            .text,
                                                    price: 0,
                                                    quantity: int.parse(
                                                        ticketQuantityController
                                                            .text))
                                                .toJson()
                                          ]
                                        : [
                                            Ticket(
                                                    title:
                                                        paidticketTitleController
                                                            .text,
                                                    description:
                                                        paidticketDescriptionController
                                                            .text,
                                                    price: double.parse(
                                                        ticketPriceController
                                                            .text),
                                                    quantity: int.parse(
                                                        paidticketQuantityController
                                                            .text))
                                                .toJson()
                                          ]

                                    // tickets,
                                    ,
                                    "0",
                                    " ");
                                ref
                                    .read(
                                        eventcreationNotifierProvider(userToken)
                                            .notifier)
                                    .setParams(params);
                                final notifier = ref.read(
                                    eventcreationNotifierProvider(userToken)
                                        .notifier);
                                // final response= ref
                                //     .read(
                                //     eventcreationNotifierProvider(userToken)
                                //         .notifier)
                                //     .createEvents();

                                setState(() {});
                                try {
                                  await notifier.createEvents(context);
                                  setState(() {
                                    isCreatingEvent =
                                        false; // Event creation is complete
                                  });
                                  titleEventController.clear();
                                  eventLocation.clear();
                                  eventDateController.clear();
                                  enddateEventController.clear();
                                  eventcityControllers.clear();
                                  startTimeEventController.clear();

                                  endTimedateEventController.clear();

                                  eventDescriptioncController.clear();

                                  moneyController.clear();
                                  minAgeController.clear();
                                  maxAgeController.clear();
                                  minEntranceController.clear();
                                  maxEntranceController.clear();
                                  ticketPriceController.clear();
                                  ticketTitleController.clear();
                                  ticketDescriptionController.clear();
                                  ticketQuantityController.clear();
                                  paidticketTitleController.clear();
                                  paidticketDescriptionController.clear();
                                  paidticketQuantityController.clear();
                                } catch (error) {
                                  await showToasterror("error");
                                }
                              }
                            },
                            child: isCreatingEvent
                                ? const CircularProgressIndicator() // Show a progress indicator when creating the event
                                : Text(
                                    "Publish".tr,
                                    style: const TextStyle(
                                        fontFamily: "Mulish",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  bool isCreatingEvent = false;

//-----------------------------Validations-----------------------------
  bool validateFields() {
    List<String> errorMessages = [];

    if (ticketTitleController.text.isEmpty) {
      errorMessages.add("Please enter the ticket title.");
    }

    if (ticketQuantityController.text.isEmpty) {
      errorMessages.add("Please enter the ticket quantity");
    }

    if (ticketDescriptionController.text.isEmpty) {
      errorMessages.add("Please enter the ticket description.");
    }

    if (ticketPriceController.text.isEmpty) {
      errorMessages.add("Please enter the  ticket price.");
    }
    /*    if (ticketPriceController.text.isNotEmpty &&
        int.parse(ticketPriceController.text) <= 0) {
      errorMessages.add("Price must be greater than 0.".tr);
    } */
    if (paidticketQuantityController.text.isEmpty) {
      errorMessages.add("Please enter the  ticket quantity");
    }

    if (paidticketDescriptionController.text.isEmpty) {
      errorMessages.add("Please enter the  ticket description.");
    }
    if (paidticketTitleController.text.isEmpty) {
      errorMessages.add("Please enter the ticket title.");
    }
    if (limitSelected == true) {
      if (ticketPriceController.text.isEmpty) {
        errorMessages.add("Please enter price");
      }
    }

    if (errorMessages.isNotEmpty) {
      // Display an alert or error message with the errorMessages
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xff21252A),
            title: const Text(
              "Validation Error",
              style: TextStyle(
                  color: textColor, fontSize: 20, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: errorMessages
                    .map((message) => Text(
                          message,
                          style: const TextStyle(
                              color: textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ))
                    .toList(),
              ),
            ),
            actions: <Widget>[
              SaveButton(
                  title: "OK",
                  onTap: () {
                    Navigator.pop(context);
                  })
            ],
          );
        },
      );
      return false; // Validation failed
    }
    return true; // Validation succeeded
  }
}
