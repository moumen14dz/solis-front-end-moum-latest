import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/login/sign_in_account.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:newproject/utils/showtoast.dart';
import 'package:newproject/utils/textformfield.dart';

class ChangePassword extends StatefulWidget {
  final String email;
  const ChangePassword({super.key, required this.email});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isCheck = false;
  bool passwordsMatch = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Handle the back button press here
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignInAccount([])),
          );
          return false; // Return false to prevent default back button behavior
        },
        child: Scaffold(
          backgroundColor: mainColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                SvgPicture.asset("assets/Logo v.2.svg"),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Change Your Password",
                  style: TextStyle(
                      color: Color(0xffF9FAFB),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Password",
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
                        hintText: "Create a new passsword",
                        controller: newPassword,
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
                        "Confrim Passowrd",
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
                        hintText: "Confirm new password",
                        controller: confirmPassword,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(340, 49),
                                backgroundColor: buttonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () async {
                              if (newPassword.text == '' ||
                                  confirmPassword.text == '') {
                                await showToasterror(
                                    "Please enter both new password and confirm password}");
                              } else {
                                if (newPassword.text == confirmPassword.text) {
                                  setState(() {
                                    passwordsMatch = true;
                                  });
                                  setState(() {
                                    isCheck =
                                        true; // Set the flag to indicate event creation in progress
                                  });
                                  bool response = await APIRequests()
                                      .resetPassword(
                                          newPassword.text, widget.email);
                                  if (response) {
                                    setState(() {
                                      isCheck =
                                          false; // Event creation is complete
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                const SignInAccount([])));
                                  } else {
                                    await showToasterror(
                                        "Error While resetting password");
                                  }
                                } else {
                                  setState(() {
                                    passwordsMatch = false;
                                  });
                                  showToasterror("Password doesn't match");
                                  setState(() {
                                    isCheck =
                                        false; // Set the flag to indicate event creation in progress
                                  });
                                }
                              }
                            },
                            child: isCheck
                                ? const CircularProgressIndicator() // Show a progress indicator when creating the event
                                : Text(
                                    "Continue".tr,
                                    style: const TextStyle(
                                        fontFamily: "Mulish",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
