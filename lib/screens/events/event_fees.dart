import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/events/widgets/payment_textfield_widget.dart';
import 'package:newproject/utils/colors.dart';

import '../../model/getEventDetails.dart';
import '../../utils/controllers.dart';

class EventFees extends StatefulWidget {
  const EventFees({super.key});

  @override
  State<EventFees> createState() => _EventFeesState();
}

class _EventFeesState extends State<EventFees> {
  List<double> ticketValue =
      List.filled(getEventDetailsModel.data!.tickets!.length, 0);

  double total = 0;
  int totalQnt = 0;

  List<int> ticketqnt =
      List.filled(getEventDetailsModel.data!.tickets!.length, 0);

  var dropdownValues2 = [0, 1, 2, 3, 4, 5]; // Example dropdown values
  // int selectedDropdownValue = 1; // Initial selected dropdown value

  @override
  void initState() {
    selectedQuantityController.clear();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //log("taxx${getEventDetailsModel.data!.tickets!.first.taxes!.first.toJson()}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          "Payment".tr,
          style: const TextStyle(color: textColor),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: getEventDetailsModel.data!.tickets!.length * 160,
                    // width: 600,
                    child: ListView.builder(
                      itemCount: getEventDetailsModel
                          .data!.tickets!.length, // Number of ListTiles
                      itemBuilder: (context, index2) {
                        selectedTickets = getEventDetailsModel.data!.tickets;
                        List<Tax>? taxes =
                            getEventDetailsModel.data!.tickets![index2].taxes!;
                        log("index $index2");
                        log("indexxx ${selectedTickets!.length}");

                        log("11");
                        log("11${selectedTickets![index2]}");

                        selectedTickets![index2].quantity = ticketqnt[index2];
                        log("12");
                        List<int> dropdownValues = [];

                        for (var i = 1;
                            i <=
                                getEventDetailsModel
                                    .data!.tickets![index2].quantity!;
                            i++) {
                          dropdownValues.add(i);
                        }
                        log("quannn${getEventDetailsModel.data!.tickets![index2].toJson()}");

                        return getEventDetailsModel
                                    .data!.tickets![index2].price !=
                                "0"
                            ? Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        //  height: 100,
                                        //width: 600,
                                        child: Row(
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Leading widget with two lines of text
                                            SizedBox(
                                                //  height: 100,
                                                width: 100,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      getEventDetailsModel
                                                          .data!
                                                          .tickets![index2]
                                                          .title!,
                                                      style: const TextStyle(
                                                          color: textColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    getEventDetailsModel
                                                                .data!
                                                                .tickets![
                                                                    index2]
                                                                .price! !=
                                                            '0.00'
                                                        ? Text(
                                                            " ${getEventDetailsModel.data!.tickets![index2].price!} \$",
                                                            style: const TextStyle(
                                                                color:
                                                                    textColor,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                )),
                                            // Dropdown button with numbers as options
                                            SizedBox(
                                                width: 100,
                                                //height: 100,
                                                child: TextField(
                                                    textAlign: TextAlign.center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        ticketqnt[index2] =
                                                            int.parse(value);
                                                        selectedTickets?[index2]
                                                                .quantity =
                                                            int.parse(value);

                                                        ticketValue[
                                                            index2] = int.parse(
                                                                value) *
                                                            double.parse(
                                                                getEventDetailsModel
                                                                    .data!
                                                                    .tickets![
                                                                        index2]
                                                                    .price!);

                                                        total = ticketValue
                                                            .reduce((a, b) =>
                                                                a + b);
                                                        totalQnt = ticketqnt
                                                            .reduce((a, b) =>
                                                                a + b);
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText: "Quantity".tr,
                                                      hintStyle: TextStyle(
                                                          color: const Color(
                                                                  0xffF9FAFB)
                                                              .withOpacity(.5),
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontSize: 15),
                                                    ),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffF9FAFB),
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 15),
                                                    controller:
                                                        selectedQuantityController)),
                                            /*   Container(
                                                width: 100,
                                                //height: 100,
                                                child: DropdownButton<int>(
                                                  // padding: EdgeInsets.only(right: 20),
                                                  isExpanded: true,
                                                  dropdownColor: Colors.black,
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  value:
                                                      ticketqnt[index2].toInt(),
                                                  items: dropdownValues2
                                                      .map((int value) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .centerEnd,
                                                      value: value,
                                                      child: Center(
                                                          child: Text(
                                                        '$value',
                                                        style: TextStyle(
                                                            color: textColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      ticketqnt[index2] =
                                                          value!;
                                                      selectedTickets?[index2]
                                                          .quantity = value;

                                                      ticketValue[index2] = value *
                                                          double.parse(
                                                              getEventDetailsModel
                                                                  .data!
                                                                  .tickets![
                                                                      index2]
                                                                  .price!);

                                                      total =
                                                          ticketValue.reduce(
                                                              (a, b) => a + b);
                                                      totalQnt =
                                                          ticketqnt.reduce(
                                                              (a, b) => a + b);
                                                    });
                                                  },
                                                )),
                                      */ // Trailing widget displaying price text
                                            getEventDetailsModel
                                                        .data!
                                                        .tickets![index2]
                                                        .price! !=
                                                    '0.00'
                                                ? SizedBox(
                                                    // padding: EdgeInsets.only(right: 8),
                                                    width: 100,
                                                    child: Center(
                                                        child: Text(
                                                      "${ticketValue[index2].toStringAsFixed(2)} \$",
                                                      style: const TextStyle(
                                                          color: textColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                                  )
                                                : const SizedBox()
                                          ],
                                        ),
                                      ),
                                      Column(
                                          children: List.generate(taxes.length,
                                              (index2) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    taxes[index2].title,
                                                    style: const TextStyle(
                                                        color: textColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )),
                                              Container(width: 100),
                                              SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    "${taxes[index2].rate} \$ ",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: textColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ))
                                            ],
                                          ),
                                        );
                                      }))
                                    ]))
                            : Container();
                      },
                    ))),
            /*      Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ticket classique x1",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "\$ 20.00",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ), */

            total != 0
                ? Container(
                    margin: const EdgeInsets.only(left: 8, right: 8),
                    child: const Divider(
                      color: Color(0xff94999E),
                    ),
                  )
                : const SizedBox(),
            total != 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "${total.toString()}\$",
                          style: const TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
            total != 0
                ? Container(
                    margin: const EdgeInsets.only(left: 8, right: 8),
                    child: const Divider(
                      color: Color(0xff94999E),
                    ),
                  )
                : const SizedBox(),
            PaymentTextFieldWidget(
              booking_date: getEventDetailsModel.data!.startDate.toString(),
              booking_enddate: getEventDetailsModel.data!.endDate.toString(),
              booking_startTime:
                  getEventDetailsModel.data!.startTime.toString(),
              booking_endTime: getEventDetailsModel.data!.endTime.toString(),
              amount: total.toStringAsFixed(2),
              ticketCounts: '1',
              eventId: getEventDetailsModel.data!.id.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
