import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newproject/model/countries_model.dart';
import 'package:newproject/screens/account/profile_accout.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/textformfield.dart';

import '../../model/drop_down_item.dart';
import '../../model/programs_model.dart';
import '../../model/universities_model.dart';
import '../../resources/resudable_drop_down.dart';
import '../../utils/buttons.dart';
import '../../utils/start_activity.dart';
import '../../view_models/program_notifier.dart';
import '../../view_models/university_list_notifier.dart';

class AssociatePage extends ConsumerStatefulWidget {
  const AssociatePage(List<Country> countries, {super.key});

  @override
  ConsumerState<AssociatePage> createState() => _AssociatePageState();
}

class _AssociatePageState extends ConsumerState<AssociatePage> {
  int universityId = 1, programId = 1, countryId = 1, stateId = 1;

  String accountType = "association";

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

  @override
  Widget build(BuildContext context) {
    // final observeCountryList = ref.watch(countryListNotifierProvider);
    final observeuniversityList = ref.watch(universityListNotifierProvider);
    final observeProgramList = ref.watch(programNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xff0F1216),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(child: SvgPicture.asset("assets/Logo v.2.svg")),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "You are an association".tr,
                  style: const TextStyle(
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name of association".tr,
                      style: const TextStyle(
                          color: Color(0xffF9FAFB),
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormInputField(
                      textInputType: TextInputType.text,
                      hintText: "Enter name".tr,
                      controller: associationNameController,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "University".tr,
                      style: const TextStyle(
                          color: Color(0xffF9FAFB),
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    universityDropdown1(
                        observeuniversityList, "Select Your university".tr)
                  ],
                ),
              ),
              /*    Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: const Text(
                          "Program",
                          style: TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      programDropdown(observeProgramList, "Select Your Program")
                    ],
                  ),
                ),
              ), */
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(30),
                child: SaveButton(
                  title: "Next",
                  onTap: () {
                    if (validateFields()) {
                      StartActivity().start(
                          context,
                          ProfileAccount(
                            accountType: accountType,
                            associationName: associationNameController.text,
                            universityId: universityId,
                            programId: programId,
                            neighborhoodId: countryId,
                            cityId: stateId,
                          ));
                      associationNameController.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateFields() {
    List<String> errorMessages = [];

    // if (_image == null) {
    //   errorMessages.add("Please select an image.");
    // }

    if (associationNameController.text.isEmpty) {
      errorMessages.add("Please enter the name.");
    }

    if (!universityDropdownsSelected) {
      // Show validation error if any dropdown is not selected
      errorMessages.add("Please select university.");
      // return; // Exit early to prevent further processing
    }
    /*   if (!programDropdownsSelected) {
      // Show validation error if any dropdown is not selected
      errorMessages.add("Please select program.");
      // return; // Exit early to prevent further processing
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
  bool programDropdownsSelected = false;
}
