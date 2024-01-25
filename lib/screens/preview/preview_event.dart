import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constant.dart';
import '../../utils/controllers.dart';
import '../../utils/showtoast.dart';
import '../../view_models/event_creation_notifier.dart';

class PreviewScreen extends ConsumerStatefulWidget {
  final String title;
  final XFile? image;
  final String startdate;
  final String endDate;
  final int city;

  final String startTime;
  final String endTime;

  final String description;
  final String location;
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
  final String freeTitle;
  final String freeDescription;
  final String freeQuantity;
  final String paidTitle;
  final String paidDescription;
  final String paidQuantity;
  final List<Map<String, dynamic>> tickets;

  const PreviewScreen(
      {super.key,
      required this.title,
      required this.image,
      required this.startdate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.description,
      required this.location,
      required this.countryId,
      required this.universityId,
      required this.city,
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
      required this.freeTitle,
      required this.freeDescription,
      required this.freeQuantity,
      required this.paidTitle,
      required this.paidDescription,
      required this.paidQuantity,
      required this.tickets});

  @override
  ConsumerState<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends ConsumerState<PreviewScreen> {
  File? file; // Declare the File object as an instance variable

  @override
  void initState() {
    super.initState();

    // Initialize the File object inside initState
    file = File(widget.image!.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title:  Text(
          widget.title,
          style: TextStyle(color: textColor),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(
                width: MediaQuery.of(context).size.width,
                file!,
                fit: BoxFit.cover,
              ),
            ),
            /* Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title.tr,
                style: const TextStyle(
                    color: Color(0xffF9FAFB),
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ), */
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    "assets/calendar-01.png",
                    height: 28,
                    width: 28,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${DateFormat('dd-MM-yyyy').format(DateFormat('yyyy-MM-dd').parse(widget.startdate))} : ${widget.startTime}  /  ${DateFormat('dd-MM-yyyy').format(DateFormat('yyyy-MM-dd').parse(widget.endDate))}  : ${widget.endTime}",
                    style: const TextStyle(
                        color: Color(0xffF9FAFB),
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.pin_drop,
                    color: textColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.location.tr,
                    style: const TextStyle(
                        color: Color(0xffF9FAFB),
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    "assets/users-profiles-02.png",
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    (widget.freeQuantity == "1000000" ||
                            widget.freeQuantity == "1000000")
                        ? "Unilimited Participants"
                        : "${(int.parse(widget.freeQuantity) + int.parse(widget.paidQuantity))} Participants",
                    style: const TextStyle(
                        color: Color(0xffF9FAFB),
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: const Divider(
                color: Color(0xff5F656D),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'description'.tr,
                style: const TextStyle(
                    color: Color(0xffF9FAFB),
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.description,
                style: const TextStyle(
                    color: Color(0xffF9FAFB),
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, bottom: 8, top: 8),
                    child: OutlineButton(
                        title: "Edit".tr,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (builder) => EventCreationWidget()));
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
                        setState(() {
                          isCreatingEvent =
                              true; // Set the flag to indicate event creation in progress
                        });
                        // String bearerToken = await getToken();
                        // int programId = await getProgramId();
                        List<int> imageBytes =
                            await widget.image!.readAsBytes();
                        String base64Image = base64Encode(imageBytes);
                        SharedPreferences userpref =
                            await SharedPreferences.getInstance();
                        var myId = userpref.getInt("userId");
                        final params = Params1(
                            widget.categoryId,
                            myId!,
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
                            widget.tickets,
                            "0",
                            " "

                            // tickets,
                            );
                        ref
                            .read(eventcreationNotifierProvider(userToken)
                                .notifier)
                            .setParams(params);
                        final notifier = ref.read(
                            eventcreationNotifierProvider(userToken).notifier);
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
                          alert();
                        } catch (error) {
                          await showToasterror("error");
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
                // Padding(
                //     padding: const EdgeInsets.only(
                //         left: 30, right: 30, bottom: 8, top: 8),
                //     child: SaveButton(
                //         title: "Publish".tr,
                //         onTap: () async {
                //
                //             String bearerToken = await getToken();
                //             // int programId = await getProgramId();
                //             List<int> imageBytes =
                //             await widget.image!.readAsBytes();
                //             String base64Image = base64Encode(imageBytes);
                //             final params = Params1(
                //               widget.categoryId,
                //               widget.countryId,
                //               widget.universityId,
                //               programId,
                //               widget.title,
                //               widget.description,
                //               base64Image,
                //               widget.startdate,
                //               widget.price,
                //               widget.min_age,
                //               widget.max_age,
                //               widget.limitEntrance,
                //               widget.minEntrance,
                //               widget.maxEntrance,
                //               widget.location,
                //               widget.latitude,
                //               widget.longitude,
                //               widget.isPublic,
                //               widget.followAccount,
                //               widget.freeTitle,
                //               widget.freeDescription,
                //               widget.freeQuantity,
                //               widget.paidTitle,
                //               widget.paidDescription,
                //               widget.paidQuantity
                //               // widget.tickets,
                //             );
                //             ref
                //                 .read(eventcreationNotifierProvider(bearerToken)
                //                     .notifier)
                //                 .setParams(params);
                //             ref
                //                 .read(eventcreationNotifierProvider(bearerToken)
                //                     .notifier)
                //                 .createEvents();
                //
                //             alert();
                //           }
                //         )),
                const SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

//-----------------------------Validations-----------------------------
  bool isCreatingEvent = false;

  void alert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff21252A),
          title: const Text(
            'CONGRATULATIONS!',
            style: TextStyle(
                color: textColor, fontSize: 20, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset('assets/Group.png'),
                const SizedBox(
                  height: 9,
                ),
                const Text(
                  'You have publish the event successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            SaveButton(
                title: "Close",
                onTap: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }
}
