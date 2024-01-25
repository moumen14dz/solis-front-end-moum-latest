import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/frames/widgets/music_frame_listview.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:newproject/utils/showtoast.dart';

import '../../model/getEventswithFilters.dart';

class MusicFrame extends StatefulWidget {
  const MusicFrame({super.key, required this.categoryID});
  final String categoryID;
  @override
  State<MusicFrame> createState() => _MusicFrameState();
}

class _MusicFrameState extends State<MusicFrame> {
  getTheseEvents() async {
    await APIRequests().getEventsWithFilters(
        int.parse(widget.categoryID), 0, '', setState(() {}));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTheseEvents();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getEventsWithFiltersModel = GetEventWithFilters();
  }

  @override
  Widget build(BuildContext context) {
    print("object${widget.categoryID}");
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title:

        Text(
          getCategories.data!
                  .firstWhere(
                      (element) => element.id.toString() == widget.categoryID)
                  .name ??
              '',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
      ),
      backgroundColor: mainColor,
      body: getEventsWithFiltersModel.data == null
          ? customCentralCircularProgressLoader()
          : SingleChildScrollView(
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: TextFormField(
                        controller: eventsFilterSearch,
                        onChanged: (value) {
                          setState(() {
                            getEventsWithFiltersModel.data =
                                getEventsWithFiltersModelAfterSearch!
                                    .where((element) => element.title!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                            if (value == '') {
                              getEventsWithFiltersModel.data =
                                  getEventsWithFiltersModelAfterSearch;
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
                            hintText: "Search",
                            hintStyle: TextStyle(
                                color: const Color(0xffFFFFFF).withOpacity(.3))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              showToasterror('Loading!');
                              await APIRequests().getEventsWithFilters(
                                  int.parse(widget.categoryID),
                                  0,
                                  '',
                                  setState(() {}));
                              setState(() {
                                selected = 0;
                              });
                            },
                            child: Container(
                              width: 66,
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: selected == 0 ? buttonColor : mainColor,
                                  border: Border.all(
                                      color: selected == 0
                                          ? mainColor
                                          : borderColor)),
                              child: Center(
                                child: Text(
                                  "All".tr,
                                  style: TextStyle(
                                      color: selected == 0
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          InkWell(
                            onTap: () async {
                              showToasterror('Loading!');

                              await APIRequests().getEventsWithFilters(
                                  int.parse(widget.categoryID),
                                  1,
                                  '',
                                  setState(() {}));
                              setState(() {
                                selected = 1;
                              });
                            },
                            child: Container(
                              width: 66,
                              height: 25,
                              decoration: BoxDecoration(
                                  color: selected == 1 ? buttonColor : mainColor,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: selected == 1
                                          ? mainColor
                                          : borderColor)),
                              child: Center(
                                child: Text(
                                  "Today".tr,
                                  style: TextStyle(
                                      color: selected == 1
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          InkWell(
                            onTap: () async {
                              showToasterror('Loading!');
                              await APIRequests().getEventsWithFilters(
                                  int.parse(widget.categoryID),
                                  2,
                                  '',
                                  setState(() {}));
                              setState(() {
                                selected = 2;
                              });
                            },
                            child: Container(
                              width: 90,
                              height: 25,
                              decoration: BoxDecoration(
                                  color: selected == 2 ? buttonColor : mainColor,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: selected == 2
                                          ? mainColor
                                          : borderColor)),
                              child: Center(
                                child: Text(
                                  "This week".tr,
                                  style: TextStyle(
                                      color: selected == 2
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          InkWell(
                            onTap: () async {
                              showToasterror('Loading!');

                              await APIRequests().getEventsWithFilters(
                                  int.parse(widget.categoryID),
                                  3,
                                  '',
                                  setState(() {}));
                              setState(() {
                                selected = 3;
                              });
                            },
                            child: Container(
                              width: 90,
                              height: 25,
                              decoration: BoxDecoration(
                                  color: selected == 3 ? buttonColor : mainColor,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: selected == 3
                                          ? mainColor
                                          : borderColor)),
                              child: Center(
                                child: Text(
                                  "This month".tr,
                                  style: TextStyle(
                                      color: selected == 3
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const MusicFrameListWidget(),
                ],
              ),
          ),
    );
  }

  int selected = 0;
}
