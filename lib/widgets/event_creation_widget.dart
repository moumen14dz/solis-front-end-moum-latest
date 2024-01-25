import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:newproject/common/constant.dart';

import 'package:newproject/model/categories_model.dart';
import 'package:newproject/model/countries_model.dart';
import 'package:newproject/resources/resudable_drop_down.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/textformfield.dart';
import 'package:newproject/view_models/event_creation_notifier.dart';
import 'package:permission_handler/permission_handler.dart';
import '../model/drop_down_item.dart';
import '../model/programs_model.dart';
import '../model/state_list_model.dart';
import '../model/universities_model.dart';
import '../networking/repository/expansion_provider.dart';
import '../screens/Tickets/ticketsPage.dart';
import '../utils/showtoast.dart';
import '../utils/start_activity.dart';
import '../view_models/categories_list_notifies.dart';
import '../view_models/country_list_notifier.dart';
import '../view_models/program_notifier.dart';
import '../view_models/university_list_notifier.dart';
import 'package:http/http.dart' as http;

class EventCreationWidget extends ConsumerStatefulWidget {
  bool isRedirected =  false;

  EventCreationWidget(this.isRedirected, {super.key});

  @override
  ConsumerState<EventCreationWidget> createState() =>
      _EventCreationWidgetState();
}

class _EventCreationWidgetState extends ConsumerState<EventCreationWidget> {
  final picker = ImagePicker();
  XFile? _image;
  String latitude = '';
  String longitude = '';
  int universityId = 1, programId = 1, categoryId = 1;
  int countryId = 1;
  int cityId = 1;

  bool isPublic = true; // Default value for "Public"
  bool followAccount = false;
  bool limitEntrance = false;
  final checkboxStateProvider = StateProvider<bool>((ref) => false);
  final checkpublicStateProvider = StateProvider<bool>((ref) => true);
  final checkfollowStateProvider = StateProvider<bool>((ref) => true);
  final checkboxStateProviderNo = StateProvider<bool>((ref) => false);
  final checkboxStateProvider2 = StateProvider<bool>((ref) => false);
  final checkboxStateProviderNo2 = StateProvider<bool>((ref) => false);
  final showAgeFieldsProvider = StateProvider<bool>((ref) => false);
  final isCheckedProvider = StateProvider<bool>((ref) => false);
  final expansionStateProvider12 = StateProvider<bool>((ref) => false);

  final List<StateModel> states = [];

  String baseUrl = 'http://piptestnet.com/api/';

  bool isFree = true;

  bool isCreatingEvent = false;
  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  GetState(int countryId) async {
    //cityControllers.text = "Select State";
    states.clear();
    log("eee");

    StateListModel list = await getStatesListByCountryId2();
    states.addAll(list.data);

    log("eee${states.length}");
  }

  Future<StateListModel> getStatesListByCountryId2() async {
    Dio dio = Dio();

    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'country_id': countryId};
    final headers = <String, dynamic>{};
    const Map<String, dynamic>? data = null;
    final result = await dio
        .fetch<Map<String, dynamic>>(_setStreamType<StateListModel>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(
              dio.options,
              'cities',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: baseUrl ?? dio.options.baseUrl)));
    final value = StateListModel.fromJson(result.data!);
    return value;
  }

  @override
  void initState() {
    GetState(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //-----------------------------Notifiers-----------------------------

    final observeuniversityList = ref.watch(universityListNotifierProvider);
    final observeCountryList = ref.watch(countryListNotifierProvider);
    final observeCategoryList = ref.watch(CategoryListNotifierProvider);
    final observeProgramList = ref.watch(programNotifierProvider);
    final isExpanded = ref.watch(expansionStateProvider);
    final isExpanded1 = ref.watch(expansionStateProvider1);
    final islimitChecked = ref.watch(checkboxStateProvider);
    final ispublicChecked = ref.watch(checkpublicStateProvider);
    final isfollowChecked = ref.watch(checkfollowStateProvider);
    // final isChecked = ref.watch(isCheckedProvider);
    DateTime? lastBackPressed;
    return WillPopScope(
        onWillPop: () async {
          if (lastBackPressed == null ||
              DateTime.now().difference(lastBackPressed!) >
                  const Duration(seconds: 3)) {
            // If it's been more than 3 seconds since the last back button press,
            // show a toast message
            lastBackPressed = DateTime.now();
            await showToasterror("Press back button again to exit");
            return false;
          } else {
            // If the user presses the back button again within 3 seconds, exit the app
            SystemNavigator.pop();
            return true;
          }
        },
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                if (Platform.isAndroid) {
                  bool status = false;

                  final deviceInfo = await DeviceInfoPlugin().androidInfo;

                  if (deviceInfo.version.sdkInt > 32) {
                    status = await Permission.photos.request().isGranted;
                  } else {
                    status = await Permission.storage.request().isGranted;
                  }

                  if (status) {
                    _getImage();
                  } else if (!status) {
                    _showPermissionDialog(context);
                  } else {
                    await showToasterror('Permission not granted');
                  }
                } else if (Platform.isIOS) {
                  // iOS-specific code

                  final status = await Permission.storage.request();
                  print("status$status");
                  if (status.isGranted) {
                    _getImage();
                  } else if (status.isPermanentlyDenied) {
                    _showPermissionDialog(context);
                  } else {
                    await showToasterror('Permission not granted');
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // Set the height as needed
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: _image == null
                      ? Image.asset("assets/Cards.png")
                      : Image.file(File(_image!.path)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter Event Title",
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
                    controller: titleEventController,
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  "Event Date",
                                  style: TextStyle(
                                      color: Color(0xffF9FAFB),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormInputField(
                              onTap: () {
                                setDate(eventDateController);
                              },
                              suIcon: const Icon(
                                Icons.calendar_month,
                                color: Color(0xffF9FAFB),
                              ),
                              textInputType: TextInputType.datetime,
                              hintText: "YYYY-MM-dd",
                              controller: eventDateController,
                            ),
                          ],
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  "End Date",
                                  style: TextStyle(
                                      color: Color(0xffF9FAFB),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormInputField(
                              onTap: () {
                                setEndDate(enddateEventController);
                              },
                              suIcon: const Icon(
                                Icons.calendar_month,
                                color: Color(0xffF9FAFB),
                              ),
                              textInputType: TextInputType.datetime,
                              hintText: "YYYY-MM-dd",
                              controller: enddateEventController,
                            ),
                          ],
                        )),
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    /*     Text(
                    "Event Timing",
                    style: TextStyle(
                        color: Color(0xffF9FAFB),
                        fontWeight: FontWeight.w300,
                        fontSize: 15),
                  ), */
                    Wrap(
                  spacing: 8,

                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.spaceBetween,
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Start Time",
                                style: TextStyle(
                                    color: Color(0xffF9FAFB),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              ),
                              Center(
                                  child: TextFormInputField(
                                onTap: () {
                                  setStartTime(startTimeEventController);
                                },
                                suIcon: const Icon(
                                  Icons.timer,
                                  color: Color(0xffF9FAFB),
                                ),
                                textInputType: TextInputType.text,
                                hintText: "HH : MM",
                                controller: startTimeEventController,
                              ))
                            ])),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "End Time",
                                style: TextStyle(
                                    color: Color(0xffF9FAFB),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              ),
                              TextFormInputField(
                                onTap: () {
                                  setEndTime(endTimedateEventController);
                                },
                                suIcon: const Icon(
                                  Icons.timer,
                                  color: Color(0xffF9FAFB),
                                ),
                                textInputType: TextInputType.datetime,
                                hintText: "HH : MM",
                                controller: endTimedateEventController,
                              )
                            ])),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Location",
                    style: TextStyle(
                        color: Color(0xffF9FAFB),
                        fontWeight: FontWeight.w300,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormInputField(
                    onTap: () async {
                      final selectedLocation = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LocationSearchOverlay(),
                        ),
                      );
                      // Set the selected location in the TextFormField
                      if (selectedLocation != null) {
                        eventLocation.text = selectedLocation;
                        convertLocationToLatLng();
                      }
                    },
                    // },
                    suIcon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xffF9FAFB),
                    ),
                    textInputType: TextInputType.streetAddress,
                    hintText: "Location",
                    controller: eventLocation,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description (300 mots)",
                    style: TextStyle(
                        color: Color(0xffF9FAFB),
                        fontWeight: FontWeight.w300,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: eventDescriptioncController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Enter description",
                        hintStyle: TextStyle(color: Color(0xff949494)),
                        fillColor: mainTextFormColor,
                        filled: true,
                        border: InputBorder.none),
                    maxLines: 5,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Text(
                  //         "Price",
                  //         style: TextStyle(
                  //             color: Color(0xffF9FAFB),
                  //             fontWeight: FontWeight.w300,
                  //             fontSize: 15),
                  //       ),
                  //       const SizedBox(
                  //         height: 10,
                  //       ),
                  //       Row(
                  //         children: [
                  //           Expanded(
                  //             child: TextFormInputField(
                  //               suIcon: const Icon(
                  //                 Icons.keyboard_arrow_down,
                  //                 color: Color(0xffF9FAFB),
                  //               ),
                  //               textInputType: TextInputType.streetAddress,
                  //               hintText: "Payment",
                  //               controller: paymentController,
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           Expanded(
                  //             child: TextFormInputField(
                  //               preIcon: Padding(
                  //                 padding: const EdgeInsets.all(8.0),
                  //                 child: Container(
                  //                   margin: const EdgeInsets.only(top: 7),
                  //                   child: Text(
                  //                     "\$",
                  //                     style: TextStyle(color: textColor),
                  //                     textAlign: TextAlign.center,
                  //                   ),
                  //                 ),
                  //               ),
                  //               textInputType: const TextInputType.numberWithOptions(),
                  //               hintText: "0.00",
                  //               controller: moneyController,
                  //             ),
                  //           ),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Choose the Category",
                          style: TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        categoryDropdown(observeCategoryList, "Choose Category")
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      // Toggle the expansion state using the provider
                      ref.read(expansionStateProvider.notifier).toggle();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Do you want to limit the entrance",
                            style: TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                          ),
                          /* Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: const Color(0xffF9FAFB),
                          ), */
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                    thickness: 0.1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isExpanded
                        ? null
                        : null ,// Set your desired height or null
                    child: Visibility(
                      visible: true,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref.read(checkboxStateProvider.notifier).state =
                                    !islimitChecked;
                                limitSelected = true;
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 28.0,
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: const Color(0xFF32373E),
                                    ),
                                    child: islimitChecked
                                        ? const Center(
                                            child: Icon(
                                              Icons.check,
                                              size: 16.0,
                                              color: Colors.white,
                                            ),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Text(
                                    'Yes',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: islimitChecked ? null : 0.0,
                              child: Visibility(
                                visible: islimitChecked,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            /*  Expanded(
                                              child: TextFormInputField(
                                                textInputType:
                                                    TextInputType.number,
                                                hintText: "min",
                                                controller:
                                                    minEntranceController,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ), */
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: TextFormInputField(
                                                textInputType:
                                                    TextInputType.number,
                                                hintText: "max",
                                                controller:
                                                    maxEntranceController,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              height: 1,
                              color: Colors.grey,
                              thickness: 0.1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                ref.read(checkboxStateProvider.notifier).state =
                                    false;
                                limitSelected = false;
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 28.0,
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: const Color(0xFF32373E),
                                      border: islimitChecked
                                          ? Border.all(
                                              color: const Color(0xFF32373E))
                                          : null,
                                    ),
                                    child: islimitChecked
                                        ? null
                                        : const Center(
                                            child: Icon(
                                              Icons.check,
                                              size: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Text(
                                    'No',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      // Toggle the expansion state using the provider
                      // ref.read(expansionStateProvider1.notifier).toggle1();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Public",
                            style: TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                          ),
                          /* Icon(
                            isExpanded1
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: const Color(0xffF9FAFB),
                          ), */
                        ],
                      ),
                    ),
                  ),

                  const Divider(
                    height: 1,
                    color: Colors.grey,
                    thickness: 0.1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height:
                        //  isExpanded1
                        // ? null
                        // :
                        120.0, // Set your desired height or null
                    child: Visibility(
                      visible: true,
                      // isExpanded1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(checkpublicStateProvider.notifier)
                                    .state = !ispublicChecked;
                                publicSelected = true;
                              },
                              child: Row(
                                children: [
                                  Container(
                                      width: 28.0,
                                      height: 28.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        color: const Color(0xFF32373E),
                                      ),
                                      child: !ispublicChecked
                                          ? null
                                          : const Center(
                                              child: Icon(
                                                Icons.check,
                                                size: 16.0,
                                                color: Colors.white,
                                              ),
                                            )),
                                  const SizedBox(width: 8.0),
                                  const Text(
                                    'Yes',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 1,
                              color: Colors.grey,
                              thickness: 0.1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(checkpublicStateProvider.notifier)
                                    .state = false;
                                publicSelected = false;
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 28.0,
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        color: const Color(0xFF32373E),
                                        border: !ispublicChecked
                                            ? null
                                            : Border.all(
                                                color:
                                                    const Color(0xFF32373E))),
                                    child: !ispublicChecked
                                        ? const Center(
                                            child: Icon(
                                              Icons.check,
                                              size: 16.0,
                                              color: Colors.white,
                                            ),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Text(
                                    'No',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // SizedBox(height: 10,),
                            const Divider(
                              height: 1,
                              color: Colors.grey,
                              thickness: 0.1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: !ispublicChecked ? null : 0.0,
                    child: Visibility(
                      visible: !ispublicChecked,
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Only accounts i follow",
                                style: TextStyle(
                                  color: Color(0xffF9FAFB),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                              ),
                              Icon(
                                // isExpanded1
                                //     ? Icons.keyboard_arrow_up
                                //     :
                                Icons.keyboard_arrow_down,
                                color: Color(0xffF9FAFB),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            height: 1,
                            color: Colors.grey,
                            thickness: 0.1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            // height: isExpanded1
                            //   ? null
                            //  : 0.0, // Set your desired height or null
                            child: Visibility(
                              visible: ispublicChecked ? isExpanded1 : true,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // ref
                                      //     .read(checkpublicStateProvider
                                      //         .notifier)
                                      //     .state = false;
                                      ref
                                          .read(
                                              checkfollowStateProvider.notifier)
                                          .state = true;
                                      followSelected = true;
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 28.0,
                                          height: 28.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              color: const Color(0xFF32373E),
                                              border: isfollowChecked
                                                  // null
                                                  ? Border.all(
                                                      color: const Color(
                                                          0xFF32373E))
                                                  : null),
                                          child: isfollowChecked
                                              ? const Center(
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 16.0,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 8.0),
                                        const Text(
                                          'Yes',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.grey,
                                    thickness: 0.1,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // if(ispublicChecked) {
                                      // ref
                                      //     .read(checkpublicStateProvider
                                      //         .notifier)
                                      //     .state = false;
                                      ref
                                          .read(
                                              checkfollowStateProvider.notifier)
                                          .state = false;
                                      followSelected = false;
                                      // }
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 28.0,
                                          height: 28.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              color: const Color(0xFF32373E),
                                              border: !isfollowChecked
                                                  // null
                                                  ? Border.all(
                                                      color: const Color(
                                                          0xFF32373E))
                                                  : null),
                                          child: !isfollowChecked
                                              ? const Center(
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 16.0,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 8.0),
                                        const Text(
                                          'No',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: !isfollowChecked ? null : 0.0,
                                    child: Visibility(
                                      visible: !isfollowChecked,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'Age'.tr,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Color(0xffF9FAFB),
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormInputField(
                                                    textInputType:
                                                        TextInputType.number,
                                                    hintText: "18",
                                                    controller:
                                                        minAgeController,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: TextFormInputField(
                                                    textInputType:
                                                        TextInputType.number,
                                                    hintText: "25",
                                                    controller:
                                                        maxAgeController,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 14),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    TypeAheadFormField(
                                                      autoFlipDirection: true,
                                                      textFieldConfiguration:
                                                          TextFieldConfiguration(
                                                        controller:
                                                            eventcityControllers,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xffF9FAFB),
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 18),
                                                        decoration: const InputDecoration(
                                                            labelText: 'City',
                                                            labelStyle: TextStyle(
                                                                color: Color(
                                                                    0xffF9FAFB),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 18)),
                                                      ),
                                                      validator: (value) => value!
                                                              .isEmpty
                                                          ? 'Please select a city'
                                                          : null,
                                                      suggestionsCallback:
                                                          (pattern) {
                                                        return states
                                                            .where((states) => states
                                                                .name
                                                                .toLowerCase()
                                                                .contains(pattern
                                                                    .toLowerCase()))
                                                            .toList();
                                                      },
                                                      itemBuilder: (context,
                                                          suggestion) {
                                                        return ListTile(
                                                          title: Text(
                                                              suggestion.name ??
                                                                  "Select "),
                                                        );
                                                      },
                                                      onSuggestionSelected:
                                                          (suggestion) {
                                                        eventcityControllers
                                                                .text =
                                                            suggestion.name;
                                                        cityId = suggestion.id;

                                                        // Handle the selected suggestion
                                                        print(
                                                            'Selected country: ${suggestion.name}');
                                                        print(
                                                            'Selected country: $countryId');
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              /*     const Text(
                                                          "Neighborhood",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffF9FAFB),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 15),
                                                        ),
                                                   */ /*     const SizedBox(
                                                          height: 10,
                                                        ),
                                                        neighbourhoodDropdown(
                                                            observeCountryList,
                                                            "Select Neighbourhood") */
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 14),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5),
                                                  child: const Text(
                                                    "University",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffF9FAFB),
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                universityDropdown1(
                                                    observeuniversityList,
                                                    "Select Your University"),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  top: 14),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: const Text(
                                                        "Program",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffF9FAFB),
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    programDropdown(
                                                        observeProgramList,
                                                        "Select Your Program")
                                                  ]))
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.grey,
                                    thickness: 0.1,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.isRedirected
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Enter Event Title",
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
                                hintText: "Enter Event Url",
                                controller: redirectUrlEventController,
                              )
                            ],
                          ),
                        )
                      : Container(),

                  /*              Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: CheckboxListTile(
                                    activeColor: const Color(0xff474F57),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      'Free'.tr,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    value: isFree,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isFree = !isFree;
                                      });
                                      log(isFree.toString());
                                    },
                                  )),
                              SizedBox(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: CheckboxListTile(
                                    activeColor: const Color(0xff474F57),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      'Paid'.tr,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    value: !isFree,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isFree = !isFree;
                                        log(isFree.toString());
                                      });
                                    },
                                  )),
                            ],
                          )), */
                  /*          Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /*      SizedBox(
                              //height: 40,
                              width: MediaQuery.of(context).size.width * .30,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
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
                                    TextField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "10",
                                        hintStyle: TextStyle(
                                            color: Color(0xffF9FAFB)
                                                .withOpacity(.5),
                                            fontWeight: FontWeight.w100,
                                            fontSize: 15),
                                      ),
                                      style: TextStyle(
                                          color: Color(0xffF9FAFB),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15),
                                      controller: !isFree
                                          ? paidticketQuantityController
                                          : ticketQuantityController,
                                    ),
                                  ])),
                  */
                          !isFree
                              ? SizedBox(
                                  //height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * .30,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                        TextField(
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: "10",
                                            hintStyle: TextStyle(
                                                color: const Color(0xffF9FAFB)
                                                    .withOpacity(.5),
                                                fontWeight: FontWeight.w100,
                                                fontSize: 15),
                                          ),
                                          style: const TextStyle(
                                              color: Color(0xffF9FAFB),
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15),

                                          //hintText: "10.00",
                                          controller: ticketPriceController,
                                        ),
                                      ]))
                              : Container(),
                        ],
                      )), */
                  const SizedBox(height: 20),

//-----------------------------Buttons-----------------------------

                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 30),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(340, 49),
                                  backgroundColor: buttonColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: widget.isRedirected
                                  ? isCreatingEvent
                                      ? CircularProgressIndicator() // Show a progress indicator when creating the event
                                      : Text(
                                          "Publish".tr,
                                          style: const TextStyle(
                                              fontFamily: "Mulish",
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        )
                                  : Text(
                                      "Next".tr,
                                      style: const TextStyle(
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                              onPressed: () async {
                                log(categoryId.toString());

                                if (validateFields()) {
                                  if (minAgeController.text.isEmpty) {
                                    minAgeController.text = "0";
                                  }
                                  if (maxAgeController.text.isEmpty) {
                                    maxAgeController.text = "0";
                                  }
                                  log(categoryId.toString());

                                  if (widget.isRedirected) {
                                    List<int> imageBytes =
                                        await _image!.readAsBytes();
                                    String base64Image =
                                        base64Encode(imageBytes);

                                    setState(() {
                                      isCreatingEvent =
                                          true; // Set the flag to indicate event creation in progress
                                    });
                                    // int programId = await getProgramId();

                                    final params = Params1(
                                        categoryId,
                                        await getUserId(),
                                        countryId,
                                        universityId,
                                        programId,
                                        titleEventController.text,
                                        eventDescriptioncController.text,
                                        base64Image,
                                        eventDateController.text,
                                        enddateEventController.text,
                                        startTimeEventController.text,
                                        endTimedateEventController.text,
                                        ticketPriceController.text,
                                        minAgeController.text,
                                        maxAgeController.text,
                                        islimitChecked,
                                        minEntranceController.text,
                                        maxEntranceController.text,
                                        cityId,
                                        eventLocation.text,
                                        latitude,
                                        longitude,
                                        isPublic,
                                        followAccount,
                                        ticketTitleController.text,
                                        ticketDescriptionController.text,
                                        ticketQuantityController.text,
                                        paidticketTitleController.text,
                                        paidticketDescriptionController.text,
                                        paidticketQuantityController.text,
                                        [],
                                        "1",
                                        redirectUrlEventController.text
                                        // tickets,
                                        );
                                    ref
                                        .read(eventcreationNotifierProvider(
                                                userToken)
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
                                  } else {
                                    StartActivity().start(
                                        context,
                                        TicketPage(
                                          isFree: isFree,
                                          title: titleEventController.text,
                                          image: _image,
                                          location: eventLocation.text,
                                          city: cityId,
                                          startdate: eventDateController.text,
                                          endDate: enddateEventController.text,
                                          startTime:
                                              startTimeEventController.text,
                                          endTime:
                                              endTimedateEventController.text,
                                          description:
                                              eventDescriptioncController.text,
                                          countryId: countryId,
                                          universityId: universityId,
                                          categoryId: categoryId,
                                          price: moneyController.text,
                                          min_age: minAgeController.text,
                                          max_age: maxAgeController.text,
                                          latitude: latitude,
                                          longitude: longitude,
                                          limitEntrance: islimitChecked,
                                          minEntrance:
                                              minEntranceController.text,
                                          maxEntrance:
                                              maxEntranceController.text,
                                          isPublic: ispublicChecked,
                                          followAccount: isfollowChecked,
                                        ));
                                  }
                                }
                              }

                              // }
                              )),
//                   Padding(
//                       padding: const EdgeInsets.only(
//                           left: 30, right: 30, bottom: 30),
//                       child: SaveButton(
//                           title: "Publish",
//                           onTap: () async {
//                             if (validateFields()) {
//                               String bearerToken = await getToken();
//                               // int userId = await getUserId();
//                               List<int> imageBytes =
//                                   await _image!.readAsBytes();
//                               String base64Image = base64Encode(imageBytes);
//                               print("img" + base64Image.toString());
//                               // int programId = await getProgramId();
//
// // -----------------------------Setting Parameters-----------------------------
//                               final params = Params(
//                                 categoryId,
//                                 countryId,
//                                 universityId,
//                                 programId,
//                                 titleEventController.text,
//                                 eventDescriptioncController.text,
//                                 base64Image,
//                                 eventDateController.text,
//                                 moneyController.text,
//                                 minAgeController.text,
//                                 maxAgeController.text,
//                                 islimitChecked,
//                                 minEntranceController.text,
//                                 maxEntranceController.text,
//                                 eventLocation.text,
//                                 latitude,
//                                 longitude,
//                                 ispublicChecked,
//                                 isfollowChecked,
//                               );
//                               ref
//                                   .read(
//                                       eventcreationNotifierProvider(bearerToken)
//                                           .notifier)
//                                   .setParams(params);
//                               ref
//                                   .read(
//                                       eventcreationNotifierProvider(bearerToken)
//                                           .notifier)
//                                   .createEvents();
//                               alert();
//                             }
//                           })),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
//-----------------------------Set Date-----------------------------

  void setDate(TextEditingController dateEventController) {
    showDatePicker(
      context: context,
      initialDate: dateEventController.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(dateEventController.text)
          : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100, 01, 01),
    ).then((value) {
      if (value != null) {
        dateEventController.text = DateFormat('yyyy-MM-dd').format(value);
      }
    });
  }
  //-----------------------------Set End Date-----------------------------

  void setEndDate(TextEditingController dateEventController) {
    showDatePicker(
      context: context,
      initialDate: enddateEventController.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(enddateEventController.text)
          : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100, 01, 01),
    ).then((value) {
      if (value != null) {
        enddateEventController.text = DateFormat('yyyy-MM-dd').format(value);
      }
    });
  }

  //-----------------------------Set Start Time-----------------------------

  void setStartTime(TextEditingController dateEventController) {
    showTimePicker(
      context: context,
      initialTime: startTimeEventController.text.isNotEmpty
          ? TimeOfDay(
              hour: int.parse(startTimeEventController.text.split(":")[0]),
              minute: int.parse(startTimeEventController.text.split(":")[1]))
          : TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        log("value$value");
        log("valuestart${'${value.hour}:${value.minute}'}");

        startTimeEventController.text = '${value.hour}:${value.minute}';
      }
    });
  }
  //-----------------------------Set End Time-----------------------------

  void setEndTime(TextEditingController dateEventController) {
    showTimePicker(
      context: context,
      initialTime: endTimedateEventController.text.isNotEmpty
          ? TimeOfDay(
              hour: int.parse(endTimedateEventController.text.split(":")[0]),
              minute: int.parse(endTimedateEventController.text.split(":")[1]))
          : TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        log("valueend$value");
        log("valueend${'${value.hour}:${value.minute}'}");
        endTimedateEventController.text = '${value.hour}:${value.minute}';
      }
    });
  }

//-----------------------------Validations-----------------------------
  bool validateFields() {
    List<String> errorMessages = [];
    if (_image == null) {
      errorMessages.add("Please select an image.");
    }

    if (widget.isRedirected && redirectUrlEventController.text.isEmpty) {
      errorMessages.add("Please enter event Link.");
    } else {
      if ((widget.isRedirected &&
              !redirectUrlEventController.text.startsWith("http")) &&
          (widget.isRedirected &&
              !redirectUrlEventController.text.startsWith("https"))) {
        errorMessages.add("Event Link must start with http or https");
      }
    }

    if (titleEventController.text.isEmpty) {
      errorMessages.add("Please enter the event title.");
    }

    if (eventDateController.text.isEmpty) {
      errorMessages.add("Please enter event date");
    }
    if (startTimeEventController.text.isEmpty) {
      errorMessages.add("Please enter start time");
    }
    if (endTimedateEventController.text.isEmpty) {
      errorMessages.add("Please enter end time");
    }

    if (enddateEventController.text.isNotEmpty &&
        enddateEventController.text != "") {
      log("ffff${enddateEventController.text}");
      if (DateTime.parse(enddateEventController.text)
          .isBefore(DateTime.parse(eventDateController.text))) {
        errorMessages.add("Please enter correct Date");
      }
    }
    if (endTimedateEventController.text.isNotEmpty) {
      log(endTimedateEventController.text);
      log(DateFormat("hh:mm")
          .parse(endTimedateEventController.text)
          .toString());
      log(DateFormat("hh:mm").parse(startTimeEventController.text).toString());

      if (DateTime.parse(enddateEventController.text)
              .isAtSameMomentAs(DateTime.parse(eventDateController.text)) &&
          DateFormat("hh:mm").parse(endTimedateEventController.text).isBefore(
              DateFormat("hh:mm").parse(startTimeEventController.text))) {
        errorMessages.add("Please enter correct Time");
      }
    }

    if (eventLocation.text.isEmpty) {
      errorMessages.add("Please enter the event location.");
    }

    if (eventDescriptioncController.text.isEmpty) {
      errorMessages.add("Please enter the event description.");
    }

    if (latitude == '' || longitude == '') {
      errorMessages.add("Please reselect Location.");
    }

    // if (moneyController.text.isEmpty) {
    //   errorMessages.add("Please enter the event price.");
    // }
    if (limitSelected == true) {
      if (minEntranceController.text.isEmpty) {
        minEntranceController.text = '0';
        //     errorMessages.add("Please enter min entrance.");
      }
      if (maxEntranceController.text.isEmpty) {
        errorMessages.add("Please enter max entrance.");
      } else {
        if (isFree) {
          ticketQuantityController.text = maxEntranceController.text;
          paidticketQuantityController.text = '0';
        } else if (!isFree) {
          paidticketQuantityController.text = maxEntranceController.text;
          ticketQuantityController.text = '0';
        }
      }
    } else if (limitSelected == false) {
      if (isFree) {
        ticketQuantityController.text = "1000000";
        paidticketQuantityController.text = '0';
      } else if (!isFree) {
        paidticketQuantityController.text = "1000000";
        ticketQuantityController.text = '0';
      }
    }
    if (publicSelected == false) {
      if (followSelected == false) {
        if (!universityDropdownsSelected) {
          // Show validation error if any dropdown is not selected
          //  errorMessages.add("Please select university.");
          // return; // Exit early to prevent further processing
        }
        /*   if (!neighborhoodDropdownsSelected) {
          // Show validation error if any dropdown is not selected
          errorMessages.add("Please select neighborhood.");
          // return; // Exit early to prevent further processing
        } */
        if (eventcityControllers.text == "") {
          // Show validation error if any dropdown is not selected
          errorMessages.add("Please select City.");
          // return; // Exit early to prevent further processing
        }
        if (!programDropdownsSelected) {
          // Show validation error if any dropdown is not selected
          //   errorMessages.add("Please select program.");
          // return; // Exit early to prevent further processing
        }
        if (minAgeController.text.isEmpty) {
          errorMessages.add("Please enter min age.");
        }
        if (maxAgeController.text.isEmpty) {
          errorMessages.add("Please enter max age.");
        }
      }
    } else {}
    if (!categoryDropdownsSelected) {
      // Show validation error if any dropdown is not selected
      errorMessages.add("Please select category.");
      // return; // Exit early to prevent further processing
    }
    if (isFree) {
      paidticketQuantityController.text = "0";

      ticketPriceController.text = "0";
      paidticketDescriptionController.text = " ";
      paidticketTitleController.text = " ";
      //if (ticketQuantityController.text.isEmpty ||
      //  ticketQuantityController.text == "0")

      // errorMessages.add("Please Add free Ticket Quantity.");
    }
    if (!isFree) {
      ticketQuantityController.text = "0";
      ticketDescriptionController.text = " ";
      ticketTitleController.text = " ";
      //  ticketPriceController.text = "0";
      //  if (paidticketQuantityController.text.isEmpty ||
      ////errorMessages.add("Please Add Paid Ticket Quantity.");
      if (ticketPriceController.text.isEmpty ||
          int.parse(ticketPriceController.text) == 0) {
        errorMessages.add("Please Add paid Ticket Price.");
      }
    }
    //log(ticketQuantityController.text);
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

//-----------------------------Alert-----------------------------
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
  //-----------------------------DropDown Widgets-----------------------------

  bool universityDropdownsSelected = false;
  bool neighborhoodDropdownsSelected = false;
  bool programDropdownsSelected = false;
  bool categoryDropdownsSelected = false;
  bool publicSelected = true;
  bool followSelected = true;
  bool limitSelected = false;

  Widget universityDropdown1<T>(
      AsyncValue<UniversitiesModel> asyncValue, String hint) {
    return asyncValue.when(
      data: (dataModel) {
        final List<DropdownItem<T>> items = dataModel.data
            .map((item) => DropdownItem<T>(item.name, item.id as T))
            .toList();

        if (items.isEmpty) {
          return const Text('No universities available');
        }

        // Ensure unique values by converting items to a Set and then back to a List.
        final uniqueItems = items.toSet().toList();

        return ReusableDropdown<T>(
          hintText: hint,
          items: uniqueItems,
          onSelected: (selectedItem) {
            if (selectedItem != null) {
              DropdownItem model = selectedItem;
              universityId = model.value as int;
              print(model.value);
              universityDropdownsSelected = true;
            }
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, st) => const Text('An error occurred'),
    );
  }

  Widget neighbourhoodDropdown<T>(
      AsyncValue<CountriesModel> asyncValue, String hint) {
    return asyncValue.when(
      data: (dataModel) {
        final List<DropdownItem<T>> items = dataModel.data
            .map((item) => DropdownItem<T>(item.name, item.id as T))
            .toList();

        if (items.isEmpty) {
          return const Text('No Neighborhood available');
        }

        return ReusableDropdown<T>(
          hintText: hint,
          items: items,
          onSelected: (selectedItem) {
            if (selectedItem != null) {
              DropdownItem model = selectedItem;
              countryId = model.value as int;
              print(model.value);
              neighborhoodDropdownsSelected = true;
            }
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, st) => const Text('An error occurred'),
    );
  }

  Widget categoryDropdown<T>(
      AsyncValue<CategoriesModel> asyncValue, String hint) {
    return asyncValue.when(
      data: (dataModel) {
        final List<DropdownItem<T>> items = dataModel.data
            .map((item) => DropdownItem<T>(item.name, item.id as T))
            .toList();

        if (items.isEmpty) {
          return const Text('No categories available');
        }
        final uniqueItems1 = items.toSet().toList();

        return ReusableDropdown<T>(
          hintText: hint,
          items: uniqueItems1,
          onSelected: (selectedItem) {
            if (selectedItem != null) {
              DropdownItem model = selectedItem;

              setState(() {
                categoryId = model.value as int;
              });
              print(model.value);
              print(categoryId);

              categoryDropdownsSelected = true;
            }
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, st) => const Text('An error occurred'),
    );
  }

  Widget programDropdown<T>(AsyncValue<ProgramsModel> asyncValue, String hint) {
    return asyncValue.when(
      data: (dataModel) {
        final List<DropdownItem<T>> items = dataModel.data
            .map((item) => DropdownItem<T>(item.name, item.id as T))
            .toList();

        if (items.isEmpty) {
          return const Text('No programs available');
        }

        return ReusableDropdown<T>(
          hintText: hint,
          items: items,
          onSelected: (selectedItem) {
            if (selectedItem != null) {
              DropdownItem model = selectedItem;
              programId = model.value as int;
              print(model.value);
              programDropdownsSelected = true;
            }
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, st) => const Text('An error occurred'),
    );
  }

  //-----------------------------Select Image-----------------------------

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile;
    });
  }

  Future<void> _showPermissionDialog(BuildContext context) async {
    final isGranted = await Permission.photos.isGranted;

    if (!isGranted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permission Required'),
            content: const Text(
                'Please grant access to the photo gallery in settings to continue.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  // Open app settings
                  await openAppSettings();
                  Navigator.of(context).pop();
                },
                child: const Text('Open Settings'),
              ),
            ],
          );
        },
      );
    }
  }
//-----------------------------Convert Location-----------------------------

  void convertLocationToLatLng() async {
    final query = eventLocation.text;
    List<Location> locations = await locationFromAddress(query);
    if (locations.isNotEmpty) {
      final lat = locations[0].latitude;
      final lng = locations[0].longitude;
      print("lat${locations[0].latitude}");
      setState(() {
        latitude = lat.toString();
        longitude = lng.toString();
      });
      print("lat$latitude");
    } else {
      setState(() {
        latitude = 'Not found';
        longitude = 'Not found';
      });
    }
  }
}
//-----------------------------Getting Location Class-----------------------------

class LocationSearchOverlay extends StatefulWidget {
  const LocationSearchOverlay({super.key});

  @override
  _LocationSearchOverlayState createState() => _LocationSearchOverlayState();
}

class _LocationSearchOverlayState extends State<LocationSearchOverlay> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];

  // Your Google Places API key
  final String apiKey = 'AIzaSyDk1CcmJGWJMSu_jZz3WzU1SZzw4UNileU';

  // Function to fetch suggestions from Google Places API
  Future<void> fetchSuggestions(String query) async {
    log("query$query");
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    print("res${response.statusCode}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("res1$data");

      final predictions = data['predictions'] as List<dynamic>;
      print("pred$predictions");
      setState(() {
        _suggestions = predictions
            .map((prediction) => prediction['description'].toString())
            .toList();
      });
    } else {
      throw Exception('Failed to load suggestions');
    }
  } // Replace with your actual suggestions data.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Location',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
      ),
      body: Container(
        // Wrap Scaffold with a Container
        color: Colors.black, // Set background color to black
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (query) {
                fetchSuggestions(query); // Call the API when the text changes.
              },
              style: const TextStyle(
                  color: Colors.white), // Set text color to white
              decoration: const InputDecoration(
                hintText: 'Search for a location',
                hintStyle: TextStyle(
                    color: Colors.white), // Set hint text color to white
                prefixIcon: Icon(Icons.search,
                    color: Colors.white), // Set icon color to white
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _suggestions[index],
                      style: const TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                    onTap: () {
                      // Set the selected location in the TextFormField
                      Navigator.pop(context, _suggestions[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
