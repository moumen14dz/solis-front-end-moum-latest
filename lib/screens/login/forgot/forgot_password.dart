import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/login/forgot/change_password.dart';
import 'package:newproject/screens/login/sign_in_account.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:newproject/utils/showtoast.dart';
import 'package:newproject/utils/textformfield.dart';

class ForgotPassword extends StatefulWidget {
  final String email;
  const ForgotPassword({super.key, required this.email});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text(
              "Enter the Code".tr,
              style: const TextStyle(
                  color: Color(0xffF9FAFB),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "A code should have come to your \nemail address that you indicated."
                  .tr,
              style: const TextStyle(
                  color: Color(0xffF9FAFB),
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 35),
                child: TextFormInputField(
                    controller: forgotpassCOntroller,
                    hintText: "000000",
                    textInputType: TextInputType.emailAddress),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(340, 49),
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () async {
                        if (forgotpassCOntroller.text == '') {
                          await showToasterror("Please enter the password}");
                        } else {
                          setState(() {
                            isCheck =
                                true; // Set the flag to indicate event creation in progress
                          });
                          bool response = await APIRequests().verifyOTP(
                              widget.email,
                              int.parse(forgotpassCOntroller.text));
                          if (response) {
                            setState(() {
                              isCheck = false; // Event creation is complete
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        ChangePassword(email: widget.email)));
                          } else {
                            await showToasterror("Incorrect OTP");
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
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: OutlineButton(
                        title: "Cancel".tr,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const SignInAccount([])));
                        })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
