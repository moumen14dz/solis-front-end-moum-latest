import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/dashboard/main_dashboard.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/showtoast.dart';
import 'package:newproject/utils/textformfield.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/constant.dart';
import '../providers/global_providers.dart';

class EditProfileTextWidgets extends ConsumerStatefulWidget {
  const EditProfileTextWidgets({super.key});

  @override
  ConsumerState<EditProfileTextWidgets> createState() =>
      _EditProfileTextWidgetsState();
}

class _EditProfileTextWidgetsState
    extends ConsumerState<EditProfileTextWidgets> {
  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    editProfilePasswordController.text = prefs.getString('password') ?? '';
  }

  bool _isPasswordHidden = true; // Default: Password is hidden
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }

  refresh() async {
    editImage;
    editBackgrondImage;
    editFirstNameController.text =
        userProfileDetails.data!.user!.firstName ?? '';
    if (editFirstNameController.text == 'null') {
      editFirstNameController.text = '';
    }
    editLastNameController.text = userProfileDetails.data!.user!.lastName ?? '';
    if (editLastNameController.text == 'null') {
      editLastNameController.text = '';
    }
    editProfileUserNameController.text =
        userProfileDetails.data!.user!.username ?? '';
    editProfileEmailController.text =
        userProfileDetails.data!.user!.email ?? '';
    editProfilePhoneController.text =
        userProfileDetails.data!.user!.phone ?? '';
    editDescriptioncController.text = loginResponseModel.data!.user!.bio ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "First Name".tr,
                            style: const TextStyle(
                                color: Color(0xffF9FAFB),
                                fontWeight: FontWeight.w300,
                                fontSize: 15),
                          ),
                          TextFormInputField(
                            textInputType: TextInputType.streetAddress,
                            hintText: "Fawad",
                            controller: editFirstNameController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Last Name".tr,
                            style: const TextStyle(
                                color: Color(0xffF9FAFB),
                                fontWeight: FontWeight.w300,
                                fontSize: 15),
                          ),
                          TextFormInputField(
                            textInputType: TextInputType.text,
                            hintText: "Kaleem",
                            controller: editLastNameController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "UserName".tr,
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
                  hintText: "Fawad Kaleeem",
                  controller: editProfileUserNameController,
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
                  "Email".tr,
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
                  hintText: "abc@gmail.com",
                  controller: editProfileEmailController,
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
                      controller: editProfilePasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an password';
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
                        hintText: "******",
                        hintStyle: const TextStyle(color: Color(0xffA2A5AA)),
                        // labelStyle: const TextStyle(color: Color(0xff78E2A7)),
                      ),
                    ),
                  ])),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Phone".tr,
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
                  hintText: "+124 535 5235",
                  controller: editProfilePhoneController,
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
                  "Bio (max 100 words)".tr,
                  style: const TextStyle(
                      color: Color(0xffF9FAFB),
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: editDescriptioncController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      hintText: "Enter description",
                      hintStyle: TextStyle(color: Color(0xff949494)),
                      fillColor: mainTextFormColor,
                      filled: true,
                      border: InputBorder.none),
                  maxLines: 5,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SaveButton(
                title: "Save Changes".tr,
                onTap: () async {
                  if (editProfileUserNameController.text.trim == '') {
                    await showToasterror('User Name Cannot Be Empty!');
                  } else if (editProfileEmailController.text.trim == '') {
                    await showToasterror('Email Cannot Be Empty!');
                  } else if (editProfilePhoneController.text.trim() == '') {
                    await showToasterror('Phone Number Cannot Be Empty!');
                  } else if (editFirstNameController.text.trim() == '' ||
                          editLastNameController.text.trim() == ''
                      //||           editDescriptioncController.text.trim() == ''
                      ) {
                    await showToasterror('Please Fill All The Fields!');
                  } else {
                    // if (loader == false) {
                    //   setState(() {
                    //     loader == true;
                    //   });
                    final service = ref.watch(sharedPreferencesServiceProvider);
                    String token = await service.getString(authTokenIdentifier);
                    bool res = await updateProfileDetails();
                    if (res) {
                      setState(() {});
                      await APIRequests().getUserProfileDetails(token: token);
                      setState(() {});
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen(
                                    token: true,
                                    currentIndexOfMainScreenBottomBar: 0,
                                  )));
                      setState(() {});
                    }
                    // } else {
                    //   await showToasterror('Loading!');
                    // }
                  }
                }),
          )
        ],
      ),
    ));
  }

  Future<bool> updateProfileDetails() async {
    print("object");
    try {
      await showToasterrorLongLength('Loading!');
      var response = await APIRequests().sendRequest();
      log("respppp${response.data['data']}");
      log("respppp${response.data.toString()}");

      if (response.statusCode == 200) {
        if (response.data['code'] == 422) {
          if (response.data['message'] == 'Validation error'.tr) {
            await showToasterror('Some Fields Are Missing. Please Try Again!');
          } else {
            await showToasterror(response.data['data']
                    .toString()
                    .replaceAll('{', "")
                    .replaceAll('}', "")
                    .replaceAll("[", "")
                    .replaceAll(']', "")

                //  'Error Something Went Wrong. Please Try Again!'
                );
          }
          return false;
          print(response.data.toString());
        } else if (response.data['code'] == 200) {
          await showToasterror('Profile Updated Successfully!');
          log(response.data.toString());
          return true;
        }
      } else {
        await showToasterror('Error Please Try Again!');
        return false;
      }
      setState(() {
        loader = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        loader = false;
      });
      log("respp${e.toString()}");
      showToasterror('Something Went Wrong!');
      return false;
    }
    return false;
  }
}
