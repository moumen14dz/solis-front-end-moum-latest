import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newproject/common/constant.dart';
import 'package:newproject/model/countries_model.dart';
import 'package:newproject/screens/account/profile_accout.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/textformfield.dart';
import '../../utils/buttons.dart';
import '../../utils/start_activity.dart';

class BusinessSignUp extends StatefulWidget {
  const BusinessSignUp(List<Country> countries, {super.key});

  @override
  State<BusinessSignUp> createState() => _BusinessSignUpState();
}

String accountType = "business";
int universityId = 1, programId = 1, countryId = 1, categoryId = 1, stateId = 1;

class _BusinessSignUpState extends State<BusinessSignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x0ff0f816),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  businessAccountCreateTitleString,
                //  "You ARE A BUSIiiNESS".tr,
                  style: const TextStyle(
                      color: Color(0xffF9FAFB),
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
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
                      "Name of business".tr,
                      style: const TextStyle(
                          color: Color(0xffFAFAFA),
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormInputField(
                      textInputType: TextInputType.text,
                      hintText: "Enter Name of business".tr,
                      controller: businessNameController,
                    ),
                    const SizedBox(
                      height: 10,
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
                            child:   Text(
                              "Last Name".tr,
                              style: TextStyle(
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
                            controller: businessLastController,
                          )
                        ],
                      ),
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
                    Text(
                      "Business Address".tr,
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
                      hintText: "Enter Address".tr,
                      controller: businessAddressController,
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
                      "City".tr,
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
                      hintText: "Enter City".tr,
                      controller: businessCityController,
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
                      "Postal Code".tr,
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
                      hintText: "233525s",
                      controller: businessPostalController,
                    )
                  ],
                ),
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
                            studentName: studentNameController.text,
                            businessName: businessNameController.text,
                            studentLastName: businessLastController.text,
                            businessAddress: businessAddressController.text,
                            businessCity: businessCityController.text,
                            postalCode: businessPostalController.text,
                            accountType: accountType,
                            cityId: stateId,
                            neighborhoodId: countryId,
                            universityId: universityId,
                            programId: programId,
                          ));
                      businessNameController.clear();
                      businessAddressController.clear();
                      businessPostalController.clear();
                      businessCityController.clear();
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

    if (businessNameController.text.isEmpty) {
      errorMessages.add("Please enter the name.");
    }
    if (businessAddressController.text.isEmpty) {
      errorMessages.add("Please enter the address.");
    }
    if (businessCityController.text.isEmpty) {
      errorMessages.add("Please enter the city.");
    }
    if (businessPostalController.text.isEmpty) {
      errorMessages.add("Please enter the postal code.");
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
}
