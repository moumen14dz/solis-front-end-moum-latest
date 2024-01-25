import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/frames/widgets/amazing_grid_widget.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/requestAPIController.dart';

class EventNearByYourFrame extends StatefulWidget {
  const EventNearByYourFrame({super.key});

  @override
  State<EventNearByYourFrame> createState() => _EventNearByYourFrameState();
}

class _EventNearByYourFrameState extends State<EventNearByYourFrame> {
  int selected = 0;
  @override
  void initState() {
    super.initState();
    getCategoriess();
    setState(() {});
  }

  getCategoriess() async {
    await APIRequests().getCategoriesOfEvents();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Discover amazing events".tr,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
      ),
      body: allFutureEventsList.data == null
          ? customCentralCircularProgressLoader()
          : SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      controller: eventbyyouSearch,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          getCategories.data = getCtaegoriesDataAfterSearch!
                              .where((element) => element.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                          if (value == '') {
                            getCategories.data = getCtaegoriesDataAfterSearch;
                          }
                        });
                      },
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xff32373E),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),

                            borderSide: const BorderSide(color: mainTextFormColor),
                            //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: mainTextFormColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: mainTextFormColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: mainTextFormColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: mainTextFormColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/search-01.png",
                              height: 12,
                            ),
                          ),
                          hintText: "Search".tr,
                          hintStyle: TextStyle(
                              color: const Color(0xffFFFFFF).withOpacity(.3))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Categories".tr,
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       children: [
                //         InkWell(
                //           onTap: () {
                //             setState(() {
                //               selected = 0;
                //             });
                //           },
                //           child: Container(
                //             width: 66,
                //             height: 25,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(6),
                //                 color: selected == 0 ? buttonColor : mainColor,
                //                 border: Border.all(
                //                     color: selected == 0 ? mainColor : borderColor)),
                //             child: Center(
                //               child: Text(
                //                 "All",
                //                 style: TextStyle(
                //                     color:
                //                         selected == 0 ? Colors.black : Colors.white),
                //               ),
                //             ),
                //           ),
                //         ),
                //         SizedBox(
                //           width: 7,
                //         ),
                //         InkWell(
                //           onTap: () {
                //             setState(() {
                //               selected = 1;
                //             });
                //           },
                //           child: Container(
                //             width: 66,
                //             height: 25,
                //             decoration: BoxDecoration(
                //                 color: selected == 1 ? buttonColor : mainColor,
                //                 borderRadius: BorderRadius.circular(6),
                //                 border: Border.all(
                //                     color: selected == 1 ? mainColor : borderColor)),
                //             child: Center(
                //               child: Text(
                //                 "Today",
                //                 style: TextStyle(
                //                     color:
                //                         selected == 1 ? Colors.black : Colors.white),
                //               ),
                //             ),
                //           ),
                //         ),
                //         SizedBox(
                //           width: 7,
                //         ),
                //         InkWell(
                //           onTap: () {
                //             setState(() {
                //               selected = 2;
                //             });
                //           },
                //           child: Container(
                //             width: 90,
                //             height: 25,
                //             decoration: BoxDecoration(
                //                 color: selected == 2 ? buttonColor : mainColor,
                //                 borderRadius: BorderRadius.circular(6),
                //                 border: Border.all(
                //                     color: selected == 2 ? mainColor : borderColor)),
                //             child: Center(
                //               child: Text(
                //                 "This week",
                //                 style: TextStyle(
                //                     color:
                //                         selected == 2 ? Colors.black : Colors.white),
                //               ),
                //             ),
                //           ),
                //         ),
                //         SizedBox(
                //           width: 7,
                //         ),
                //         InkWell(
                //           onTap: () {
                //             setState(() {
                //               selected = 3;
                //             });
                //           },
                //         Découvrez des événements extraordinaires= 3 ? mainColor : borderColor)),
                //             child: Center(
                //               child: Text(
                //                 "This month",
                //                 style: TextStyle(
                //                     color:
                //                         selected == 3 ? Colors.black : Colors.white),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                const AmazingGridWidget()
              ]),
            ),
    );
  }
}
