import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/login/forgot/forgot_password.dart';
import 'package:newproject/screens/login/sign_in_account.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:newproject/utils/showtoast.dart';
import 'package:newproject/utils/textformfield.dart';

class GetEmail extends StatefulWidget {
  const GetEmail({super.key});

  @override
  State<GetEmail> createState() => _GetEmailState();
}

class _GetEmailState extends State<GetEmail> {
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
              "Enter Your Email Address".tr,
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
              "Pleas enter valid email address so that you will get 4 digit code."
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
                    controller: forgotemailCOntroller,
                    hintText: "abc@gmail.com",
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
                        if (forgotemailCOntroller.text == '') {
                          await showToasterror("Please enter the email}");
                        } else {
                          setState(() {
                            isCheck =
                                true; // Set the flag to indicate event creation in progress
                          });
                          bool response = await APIRequests()
                              .forgotPassword(forgotemailCOntroller.text);
                          if (response) {
                            setState(() {
                              isCheck = false; // Event creation is complete
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => ForgotPassword(
                                        email: forgotemailCOntroller.text)));
                          } else {
                            await showToasterror(
                                "error while sending otp to your email");
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
                          forgotemailCOntroller.clear();
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
