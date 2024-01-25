import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newproject/model/getEventDetails.dart';
import 'package:newproject/screens/events/event_fees.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:newproject/utils/showtoast.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetails extends StatefulWidget {
  const EventDetails(
      {super.key, required this.eventID, required this.eventTitle});
  final String eventID;
  final String eventTitle;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  getEventDetailsForThisEvent() async {
    await APIRequests().getEventDetails(widget.eventID, setState(() {}));

    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getEventDetailsModel = GetEventDetails();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEventDetailsForThisEvent();
  }

  @override
  Widget build(BuildContext context) {
    String url = '';
    try {
      print('Here');
      if (getEventDetailsModel.data != null) {
        if (getEventDetailsModel.data!.image != null &&
                getEventDetailsModel.data!.image!.contains('http') ||
            getEventDetailsModel.data!.image!.contains('https')) {
          url = Uri.parse(getEventDetailsModel.data!.image!).toString();
        }
      }
    } catch (e) {
      url = 'https://via.placeholder.com/640x480.png/0099cc?text=odit';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          widget.eventTitle,
          style: const TextStyle(color: textColor, fontSize: 22),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: mainColor,
      body: getEventDetailsModel.data == null
          ? customCentralCircularProgressLoader()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 280,
                    width: 700,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: url == ""
                          ? Image.asset(
                              "assets/Mask.png",
                            )
                          : Image.network(
                              getEventDetailsModel.data!.image!,
fit: BoxFit.cover,                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/Masks.png',
                                    fit: BoxFit.cover);
                              },
                            ),
                    ),
                  ),
                  /*   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getEventDetailsModel.data!.title!,
                      style: TextStyle(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Start Date".tr,
                              style: const TextStyle(
                                  color: Color(0xffF9FAFB),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            (getEventDetailsModel.data!.startDate == null
                                ? const Text("")
                                : Text(
                                    "${getEventDetailsModel.data!.startDate!.toString()} : ${(DateFormat.Hm().format( DateFormat('hh:mm').parse(getEventDetailsModel.data!.startTime!)))}   ",
        style: const TextStyle(
                                        color: Color(0xffF9FAFB),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  )),
                          ],
                        )
                      ],
                    ),
                  ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "End Date".tr,
                              style: const TextStyle(
                                  color: Color(0xffF9FAFB),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            (getEventDetailsModel.data!.endDate == null
                                ? const Text("")
                                : Text(
                                    "${getEventDetailsModel.data!.endDate!.toString()} :   ${(DateFormat.Hm().format( DateFormat('hh:mm').parse(getEventDetailsModel.data!.endTime!)))}   ",
          style: const TextStyle(
                                        color: Color(0xffF9FAFB),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  )),
                          ],
                        )
                      ],
                    ),
                  ),
                  /*      Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timelapse_rounded,
                          size: 28,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Timings".tr,
                              style: TextStyle(
                                  color: Color(0xffF9FAFB),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Wrap(
                              children: [
                                (getEventDetailsModel.data!.startTime == null
                                    ? Text("20:00",
                                        style: TextStyle(
                                          color: Color(0xffF9FAFB),
                                        ))
                                    : Text(
                                        getEventDetailsModel.data!.startTime!
                                            .toString(),
                                        style: TextStyle(
                                            color: Color(0xffF9FAFB),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      )),
                                Text(" -- ",
                                    style: TextStyle(
                                        color: Color(0xffF9FAFB),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)),
                                (getEventDetailsModel.data!.endTime == null
                                    ? Text("22:00",
                                        style: TextStyle(
                                          color: Color(0xffF9FAFB),
                                        ))
                                    : Text(
                                        getEventDetailsModel.data!.endTime!
                                            .toString(),
                                        style: TextStyle(
                                            color: Color(0xffF9FAFB),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ))
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
             */
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
                          getEventDetailsModel.data != null &&
                                  getEventDetailsModel.data!.location != null
                              ? "Location: ".tr +
                                  getEventDetailsModel.data!.location!
                              : "${"Location".tr} N/A",
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
                          // "${getEventDetailsModel.data!.entranceLimitMax ?? ''} ${getEventDetailsModel.data!.entranceLimitMin ?? ''}" +
                          '${"Participants".tr} - ${getEventDetailsModel.data!.participants != null ? getEventDetailsModel.data!.participants! : '0'}',

                        //  '${"Participants".tr} - ${getEventDetailsModel.data!.participants != null ? getEventDetailsModel.data!.participants!.length.toString() : '0'}',
                          style: const TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                        /*      Text(
                          // "${getEventDetailsModel.data!.entranceLimitMax ?? ''} ${getEventDetailsModel.data!.entranceLimitMin ?? ''}" +
                          getEventDetailsModel.data!.tickets!.isNotEmpty &&
                                  getEventDetailsModel
                                          .data!.tickets![0].quantity
                                          .toString() !=
                                      '1000000'
                              // && getEventDetailsModel.data!.tickets![0].quantity                    != null
                              ? "Participants".tr +
                                  ' - ' +
                                  getEventDetailsModel
                                      .data!.tickets![0].quantity
                                      .toString()
                              : "Participants".tr + ' - ' + 'Unlimited'.tr,
                          style: TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ), */
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
                      "Description".tr,
                      style: const TextStyle(
                          color: Color(0xffF9FAFB),
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getEventDetailsModel.data!.description!,
                      style: const TextStyle(
                          color: Color(0xffF9FAFB),
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SaveButton(
                            title: "Participate".tr,
                            onTap: () async {
                              if (getEventDetailsModel.data!.is_redirected ==
                                  "1") {
                                if (getEventDetailsModel.data!.is_redirected ==
                                        "1" &&
                                    getEventDetailsModel.data!.ticketing_link ==
                                        null) {
                                  await showToasterror('invalid URL'.tr);
                                } else {
                                  if (getEventDetailsModel
                                          .data!.ticketing_link !=
                                      null) {
                                    bool a = getEventDetailsModel
                                        .data!.ticketing_link!
                                        .startsWith("https");

                                    bool b = getEventDetailsModel
                                        .data!.ticketing_link!
                                        .startsWith("http");

                                    bool c = getEventDetailsModel
                                                .data!.is_redirected ==
                                            "1" &&
                                        a;
                                    bool d = getEventDetailsModel
                                                .data!.is_redirected ==
                                            "1" &&
                                        b;
                                    log(a.toString());
                                    log(b.toString());
                                    log(c.toString());
                                    log(d.toString());
                                    if (c == false && d == false) {
                                      await showToasterror('invalggid URL'.tr);
                                    } else {
                                      _launchURL( getEventDetailsModel
                                                .data!.ticketing_link!
                                                
                                             
                                      );
                                    }
                                  }
                                }
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            const EventFees()));
                              }
                            })),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _launchInBrowserView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
    Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  _launchURL(String urll) async {
   final Uri url = Uri.parse(urll);
   if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
   }}


}
