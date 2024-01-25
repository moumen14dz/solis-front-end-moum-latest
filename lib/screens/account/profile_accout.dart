import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/accounttype/associate_signup.dart';
import 'package:newproject/screens/accounttype/bussiness_sigup.dart';
import 'package:newproject/screens/accounttype/student_signup.dart';
import 'package:newproject/screens/login/sign_in_account.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/handler/observe_api_call.dart';
import 'package:newproject/utils/textformfield.dart';
import 'package:newproject/view_models/registration_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/countries_model.dart';
import '../../utils/buttons.dart';

class ProfileAccount extends ConsumerStatefulWidget {
  final int? cityId;
  final int? neighborhoodId;
  final int? universityId;
  final int? programId;
  final String? studentName;

  final String? studentLastName;
  final String? DOB;
  final String? bio;
  final String? associationName;
  final String? businessName;
  final String? businessAddress;
  final String? businessCity;
  final String? postalCode;
  final String accountType;

  const ProfileAccount(
      {super.key,
      required this.accountType,
      this.cityId,
      this.neighborhoodId,
      this.universityId,
      this.programId,
      this.studentName,
      this.studentLastName,
      this.DOB,
      this.bio,
      this.associationName,
      this.businessName,
      this.businessAddress,
      this.businessCity,
      this.postalCode});

  @override
  ConsumerState<ProfileAccount> createState() => _ProfileAccountState();
}

class _ProfileAccountState extends ConsumerState<ProfileAccount> {
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

  Future<CountriesModel> getListOfCountries() async {
    Dio dio = Dio();

    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    const Map<String, dynamic>? data = null;
    final result = await dio
        .fetch<Map<String, dynamic>>(_setStreamType<CountriesModel>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(
              dio.options,
              'countries',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: baseUrl)));
    final value = CountriesModel.fromJson(result.data!);
    return value;
  }

  List<Country> countries = [];

  GetCountry() async {
    CountriesModel list = await getListOfCountries();
    countries.addAll(list.data);

    log(list.data.first.name);
  }

  @override
  void initState() {
    // log(widget.businessCity!);
    GetCountry();
    // TODO: implement initState
    super.initState();
  }

  bool _isPasswordHidden = true; // Default: Password is hidden

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.accountType == "student"
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentSignUp(countries)))
            : widget.accountType == "association"
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AssociatePage(countries)))
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusinessSignUp(countries)));

        return false;
      },
      child: Scaffold(
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
              Center(child: Image.asset("assets/small.png")),
              const SizedBox(
                height: 20,
              ),
                Center(
                child: Text(
                  "Create an account".tr,
                  style: TextStyle(
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
                      "Create username".tr,
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
                      hintText: "UserName".tr,
                      controller: usernameCreateControllers,
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
                      widget.accountType == 'student'
                          ? "Student Email".tr
                          : "Email".tr,
                      style: const TextStyle(
                          color: Color(0xffF9FAFB),
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormInputField(
                      textInputType: TextInputType.emailAddress,
                      hintText: "abc@gmail.com",
                      controller: emailCreateControllers,
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
                          "Password".tr,
                          style: const TextStyle(
                              color: Color(0xffF9FAFB),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          obscureText: _isPasswordHidden,
                          controller: createpassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an password'.tr;
                            }
                            // You can add more email validation checks here if needed
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordHidden
                                    ? Icons.visibility
                                    : Icons
                                        .visibility_off, // Choose icon based on the password visibility status
                                color: iconColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordHidden = !_isPasswordHidden;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: mainTextFormColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: mainTextFormColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: mainTextFormColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: mainTextFormColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            fillColor: const Color(0xff21252A),
                            filled: true,
                            // labelText: "Password",
                            labelStyle: const TextStyle(color: Colors.white),
                            hintText: "Create a password".tr,
                            hintStyle: const TextStyle(color: Color(0xffA2A5AA)),
                            // labelStyle: const TextStyle(color: Color(0xff78E2A7)),
                          ),
                        ),
                      ])),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                    child: SaveButton(
                        title: "SignUp".tr,
                        onTap: () async {
                          if (validateFields()) {
                            String deviceToken = '';
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            deviceToken =
                                pref.getString("fcm_token").toString();
                            print("fcm$deviceToken");
                            final params = Params(
                                usernameCreateControllers.text,
                                widget.studentName.toString(),
                                widget.studentLastName.toString(),
                                widget.bio.toString(),
                                emailCreateControllers.text.toString(),
                                createpassword.text,
                                widget.accountType,
                                widget.DOB.toString(),
                                widget.neighborhoodId.toString(),
                                widget.cityId.toString(),
                                widget.universityId.toString(),
                                widget.programId.toString(),
                                widget.associationName.toString(),
                                widget.businessName.toString(),
                                widget.businessAddress.toString(),
                                widget.businessCity.toString(),
                                widget.postalCode.toString(),
                                deviceToken);

                            SharedPreferences programPref =
                                await SharedPreferences.getInstance();
                            programPref.setInt("programId", programId);
                            ref
                                .read(regNotifierProvider.notifier)
                                .setParams(params);
                            ref
                                .read(regNotifierProvider.notifier)
                                .attemptToRegister();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  //return ObserveApiCall(observeStudentRegistration: observeStudentRegistration);
                                  return const ObserveApiCall();
                                }).then((result) {
                              // This code block will be executed when the dialog is dismissed.
                              // You can clear the input fields here.
                              if (result == "Success") {}
                            });
                            usernameCreateControllers.clear();
                            emailCreateControllers.clear();
                            createpassword.clear();
                          }
                        })),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?".tr,
                      style: const TextStyle(
                          color: Color(0xffF9FAFB),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    SignInAccount(countries)));
                      },
                      child: Text(
                        "Log in".tr,
                        style: const TextStyle(
                            color: buttonColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  bool validateFields() {
    List<String> errorMessages = [];

    // if (_image == null) {
    //   errorMessages.add("Please select an image.");
    // }

    if (usernameCreateControllers.text.isEmpty) {
      errorMessages.add("Please enter the username.");
    }
    if (emailCreateControllers.text.isEmpty) {
      errorMessages.add("Please enter the email address.");
    }
    if (createpassword.text.isEmpty) {
      errorMessages.add("Please enter the password.");
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
