import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newproject/common/constant.dart';
import 'package:newproject/model/programs_model.dart';
import 'package:newproject/model/state_list_model.dart';
import 'package:newproject/screens/account/profile_accout.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/start_activity.dart';
import 'package:newproject/utils/textformfield.dart';
import 'package:intl/intl.dart';

import '../../model/categories_model.dart';
import '../../model/countries_model.dart';
import '../../model/drop_down_item.dart';
import '../../model/universities_model.dart';
import '../../resources/resudable_drop_down.dart';
import '../../utils/buttons.dart';
import '../../view_models/categories_list_notifies.dart';
import '../../view_models/program_notifier.dart';
import '../../view_models/university_list_notifier.dart';

class StudentSignUp extends ConsumerStatefulWidget {
  List<Country> countries = [];
  List<StateModel> states = [];
  StudentSignUp(this.countries, {super.key});

  @override
  ConsumerState<StudentSignUp> createState() => _StudentSignUpState();
}

class _StudentSignUpState extends ConsumerState<StudentSignUp> {
  int universityId = 1,
      programId = 1,
      countryId = 1,
      categoryId = 1,
      stateId = 1;

  String baseUrl = 'http://piptestnet.com/api/';

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

  final Dio _dio = Dio();
  Future<StateListModel> getStatesListByCountryId2() async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'country_id': countryId};
    final headers = <String, dynamic>{};
    const Map<String, dynamic>? data = null;
    final result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<StateListModel>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(
              _dio.options,
              'cities',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StateListModel.fromJson(result.data!);
    return value;
  }

  Future<StateListModel> getStatesListByCountryId(countryId) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'country_id': countryId};
    final headers = <String, dynamic>{};
    const Map<String, dynamic>? data = null;
    final result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<StateListModel>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(
              _dio.options,
              'states',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StateListModel.fromJson(result.data!);
    return value;
  }

  List<Country> countries = [];

  GetState(int countryId) async {
    //cityControllers.text = "Select State";
    states.clear();
    log("eee");

    StateListModel list = await getStatesListByCountryId2();
    states.addAll(list.data);

    log("eee${states.length}");
  }

  final List<StateModel> states = [];

  @override
  void initState() {
    GetState(0);
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController _typeAheadController = TextEditingController();
  void updateCountry(int selectedCountryId) {
    setState(() {
      countryId = selectedCountryId;
    });
  }

  final countryIdProvider =
      StateProvider<int>((ref) => 0); // Initialize with a default countryId

  String age = "";
  String accountType = "student";
  @override
  Widget build(BuildContext context) {
    // final observeCountryList = ref.watch(countryListNotifierProvider);
    final observeuniversityList = ref.watch(universityListNotifierProvider);
    // final observeCountryList = ref.watch(countryListNotifierProvider);
    final observeCategoryList = ref.watch(CategoryListNotifierProvider);
    // final observeStateList = ref.watch(stateListNotifierProvider(countryId));
    final observeProgramList = ref.watch(programNotifierProvider);
    // final stateListAsyncValue = watch(stateListNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0x0ff0f816),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: SvgPicture.asset("assets/Logo v.2.svg"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 33),
                  child: Center(
                    child: Text(
                      'You are a student'.tr,
                      style: GoogleFonts.publicSans(
                        color: const Color(0xffF9FAFB),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        "First Name".tr,
                        style: const TextStyle(
                            color: Color(0xffFAFAFA),
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormInputField(
                      textInputType: TextInputType.text,
                      hintText: "Enter name".tr,
                      controller: studentNameController,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Last Name".tr,
                          style: const TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormInputField(
                        textInputType: TextInputType.text,
                        hintText: "Enter last name".tr,
                        controller: studentlastNameControllers,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Birthday".tr,
                          style: const TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormInputField(
                        onTap: () {
                          setDate(context, studentBirthdayController);
                        },
                        textInputType: TextInputType.text,
                        hintText: "YYYY/MM/DD",
                        controller: studentBirthdayController,
                        suIcon: const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                      )
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
                      Text(
                        "Bio".tr,
                        style: const TextStyle(
                            color: Color(0xffF9FAFB),
                            fontWeight: FontWeight.w300,
                            fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: studentbioController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white, width: 2.0)),

                          focusColor: Colors.white,
                          hoverColor: Colors.white,

                          hintText: "Enter bio",
                          hintStyle: const TextStyle(color: Color(0xff949494)),
                          fillColor: mainTextFormColor,
                          filled: true,

                          //  border: InputBorder.none
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                /*      Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      TypeAheadFormField(
                        autoFlipDirection: true,
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _typeAheadController,
                          style: const TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 18),
                          decoration: const InputDecoration(
                              labelText: 'Neighborhood',
                              labelStyle: TextStyle(
                                  color: Color(0xffF9FAFB),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18)),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Please select a city' : null,
                        suggestionsCallback: (pattern) {
                          return widget.countries
                              .where((country) => country.name
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()))
                              .toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion.name),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          _typeAheadController.text = suggestion.name;

                          countryId = suggestion.id;

                          print(suggestion);
                          neighborhoodDropdownsSelected = true;

                          GetState(countryId);

                          // Handle the selected suggestion
                          print('Selected country: ${suggestion.name}');
                        },
                      ),
                    ],
                  ),
                ), */

                Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      TypeAheadFormField(
                        autoFlipDirection: true,
                        textFieldConfiguration: TextFieldConfiguration(
                          autofocus: true,
                          controller: cityControllers,
                          style: const TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 18),
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              labelText: 'Neighborhood'.tr,
                              labelStyle: const TextStyle(
                                  color: Color(0xffF9FAFB),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18)),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Please select a city'.tr : null,
                        suggestionsCallback: (pattern) {
                          return states
                              .where((states) => states.name
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()))
                              .toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion.name ?? "Select "),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          cityControllers.text = suggestion.name;
                          stateId = suggestion.id;

                          //  GetState(countryId);

                          // Handle the selected suggestion
                          print('Selected country: ${suggestion.name}');
                          print('Selected country: $countryId');
                        },
                      ),
                    ],
                  ),
                ),
                /*       Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: const Text(
                          "City",
                          style: TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      //   stateDropdown(observeStateList, 'Select City'),
                    ],
                  ),
                ),

          */
                Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          "University".tr,
                          style: const TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      universityDropdown1(
                          observeuniversityList, "Select Your University".tr)
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Program".tr,
                          style: const TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      programDropdown(
                          observeProgramList, "Select Your Program".tr)
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, bottom: 10, top: 10),
                    child: SaveButton(
                      title: "Next".tr,
                      onTap: () {
                        calculateAge();
                        print("age$age");
                        if (validateFields()) {
                          StartActivity().start(
                              context,
                              ProfileAccount(
                                accountType: accountType,
                                studentName: studentNameController.text,
                                studentLastName:
                                    studentlastNameControllers.text,
                                DOB: age,
                                bio: studentbioController.text,
                                cityId: stateId,
                                neighborhoodId: countryId,
                                universityId: universityId,
                                programId: programId,
                                businessCity: cityControllers.text,
                              ));
                          studentlastNameControllers.clear();
                          studentNameController.clear();
                          studentbioController.clear();
                          studentBirthdayController.clear();
                        }
                      },
                    ),
                  ),
                ),

                //   GestureDetector(
                //     onTap: () {
                //       // Navigator.push(
                //       //     context,
                //       //     MaterialPageRoute(
                //       //         builder: (builder) => const ProfileAccount()));
                //
                //       StartActivity().start(context, ProfileAccount(
                //         cityId: stateId, neighborhood: countryId,
                //         universityIds: universityId, programIds: programId
                //       ));
                //
                //     },
                //     child: Container(
                //         margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                //         child: Image.asset("assets/s.png")),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                // Container(
                //   margin: const EdgeInsets.only(bottom: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       const Text(
                //         "Already have an account?",
                //         style: TextStyle(
                //             color: Color(0xffF9FAFB),
                //             fontSize: 14,
                //             fontWeight: FontWeight.w600),
                //       ),
                //       const SizedBox(
                //         width: 5,
                //       ),
                //       // InkWell(
                //       //   onTap: () {
                //       //     Navigator.push(
                //       //         context,
                //       //         MaterialPageRoute(
                //       //             builder: (builder) => const SignInAccount()));
                //       //   },
                //       //   child: Text(
                //       //     " Log in",
                //       //     style: TextStyle(
                //       //         color: buttonColor,
                //       //         fontSize: 14,
                //       //         fontWeight: FontWeight.w600),
                //       //   ),
                //       // ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateAge() {
    String dobString = studentBirthdayController.text;

    // Check if the date of birth string is in the correct format (YYYY-MM-DD)
    if (dobString.isNotEmpty) {
      DateTime dob = DateFormat('yyyy/MM/dd').parse(dobString);
      DateTime currentDate = DateTime.now();
      Duration difference = currentDate.difference(dob);

      int ageInYears = difference.inDays ~/ 365;

      setState(() {
        age = ageInYears.toString();
      });
    } else {
      setState(() {
        age = 'Enter a valid date of birth';
      });
    }
  }

  setDate(context, TextEditingController controller) {
    showDatePicker(
      context: context,
      initialDate: controller.text.isNotEmpty
          ? DateFormat('yyyy/MM/dd').parse(controller.text)
          : DateTime.now(),
      firstDate: DateTime(1980, 01, 01),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        controller.text = DateFormat('yyyy/MM/dd').format(value);
      }
    });
  }

  bool validateFields() {
    List<String> errorMessages = [];

    // if (_image == null) {
    //   errorMessages.add("Please select an image.");
    // }

    if (studentNameController.text.isEmpty) {
      errorMessages.add("Please enter the first name.");
    }

    if (studentlastNameControllers.text.isEmpty) {
      errorMessages.add("Please enter the last name");
    }

    if (studentBirthdayController.text.isEmpty) {
      errorMessages.add("Please enter the birthday");
    }
    if (studentbioController.text.isEmpty) {
      errorMessages.add("Please enter the bio");
    }

    if (!universityDropdownsSelected) {
      // Show validation error if any dropdown is not selected
      errorMessages.add("Please select university.");
      // return; // Exit early to prevent further processing
    }
    /*  if (!neighborhoodDropdownsSelected) {
      // Show validation error if any dropdown is not selected
      errorMessages.add("Please select neighborhood.");
      // return; // Exit early to prevent further processing
    } */
    if (!programDropdownsSelected) {
      // Show validation error if any dropdown is not selected
      errorMessages.add("Please select program.");
      // return; // Exit early to prevent further processing
    }
    if (universityControllers.text.isNotEmpty) {
      errorMessages.add("Please select the university.");
    }

    /* if (neighborControllers.text.isNotEmpty) {
      errorMessages.add("Please select the university.");
    } */

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
            content: Column(
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

  bool universityDropdownsSelected = false;
  bool neighborhoodDropdownsSelected = false;
  bool programDropdownsSelected = false;
  bool categoryDropdownsSelected = false;
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

        return ReusableDropdown<T>(
          hintText: hint,
          items: items,
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
              ref.read(countryIdProvider.notifier).state = countryId;
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

  Widget stateDropdown<T>(AsyncValue<StateListModel> asyncValue, String hint) {
    return asyncValue.when(
      data: (dataModel) {
        final List<DropdownItem<T>> items = dataModel.data
            .map((item) => DropdownItem<T>(item.name, item.id as T))
            .toList();

        if (items.isEmpty) {
          return const Text('No states available');
        }

        return ReusableDropdown<T>(
          hintText: hint,
          items: items,
          onSelected: (selectedItem) {
            if (selectedItem != null) {
              DropdownItem model = selectedItem;
              stateId = model.value as int;
              print(model.value);
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

        return ReusableDropdown<T>(
          hintText: hint,
          items: items,
          onSelected: (selectedItem) {
            if (selectedItem != null) {
              DropdownItem model = selectedItem;
              categoryId = model.value as int;
              print(model.value);
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
}
