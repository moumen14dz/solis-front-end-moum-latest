import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newproject/screens/events/event_details.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';

class HomeListView extends StatefulWidget {
  const HomeListView({super.key});

  @override
  State<HomeListView> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  @override
  Widget build(BuildContext context) {
    log(getEventsOfCurrentWeek.data!.length.toString());
    return SizedBox(
      height: 250,
      child: getEventsOfCurrentWeek.data == null
          ? customCentralCircularProgressLoader()
          : getEventsOfCurrentWeek.data!.isEmpty
              ? Text(
                  "Cant find any events for this week".tr,
                  style: const TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: getEventsOfCurrentWeek.data!.length,
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    double? price = 0;
                    if (getEventsOfCurrentWeek
                        .data![index].tickets!.isNotEmpty) {
                      getEventsOfCurrentWeek.data![index].tickets
                          ?.forEach((element) {
                        price = element.price;
                      });
                    }

                    String universityName;
                    try {
                      universityName = listOfUniversitiesModel.data!
                          .firstWhere(
                            (element) {
                              if (element.id ==
                                  getEventsOfCurrentWeek
                                      .data![index].universityId) {
                                return true;
                              }
                              return false;
                            },
                          )
                          .name!
                          .trim();
                    } catch (e) {
                      // Handle the BadStateError here
                      universityName = "Unknown University";
                    }
                    print(getEventsOfCurrentWeek.data![index].endDate);
                    return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          height: 170,
                          child: Card(
                            color: const Color(0xff21252A),
                            child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) => EventDetails(
                                                    eventID:
                                                        getEventsOfCurrentWeek
                                                            .data![index].id
                                                            .toString(),
                                                    eventTitle:
                                                        getEventsOfCurrentWeek
                                                            .data![index].title
                                                            .toString())));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 8.0, right: 10),
                                            child: getEventsOfCurrentWeek
                                                        .data![index].image !=
                                                    null
                                                ? Image.network(
                                                    getEventsOfCurrentWeek
                                                        .data![index].image!,
                                                    width: 120,
                                                    height: 150,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        'assets/Mask.png',
                                                        width: 120,
                                                        height: 150,
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  )
                                                : Image.asset(
                                                    "assets/Mask.png",
                                                    width: 120,
                                                    height: 150,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  getEventsOfCurrentWeek
                                                          .data![index].title ??
                                                      '',
                                                  style: const TextStyle(
                                                      color: Color(0xffF9FAFB),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.location_pin,
                                                      color: Color(0xffF9FAFB),
                                                      size: 12,
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        // universityName,
                                                        getEventsOfCurrentWeek
                                                                    .data![
                                                                        index]
                                                                    .location !=
                                                                null
                                                            ? getEventsOfCurrentWeek
                                                                .data![index]
                                                                .location
                                                                .toString()
                                                            : "N/A",
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xffA2A5AA)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            // height: 30,
                                            // width: 50,
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10, bottom: 10),
                                                  height: 24,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      color: const Color(0xff1E4697),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: Center(
                                                    child: Text(
                                                      DateFormat('dd MMM')
                                                          .format(DateTime.parse(
                                                              getEventsOfCurrentWeek
                                                                  .data![index]
                                                                  .startDate!
                                                                  .toString())) /* +
                                                          ' ' +
                                                          (getEventsOfCurrentWeek
                                                                      .data![
                                                                          index]
                                                                      .endDate ==
                                                                  null
                                                              ? ' '
                                                              : DateFormat(
                                                                      'dd MMM')
                                                                  .format(DateTime.parse(getEventsOfCurrentWeek
                                                                      .data![index]
                                                                      .endDate
                                                                      .toString()))) */
                                                      ,
                                                      style: const TextStyle(
                                                          color: textColor),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10, bottom: 10),
                                                  height: 24,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      color: const Color(0xff1E4697),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: Center(
                                                    child: Text(
                                                      price == 0
                                                          ? "Free".tr
                                                          // : 'Paid'.tr,
                                                          : "${price!.toStringAsFixed(2)}\$",
                                                      style: const TextStyle(
                                                          color: textColor),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ));
                  }),
    );
  }
}
