import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';

import '../../utils/requestAPIController.dart';
import '../../utils/showtoast.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Contact us".tr,
          style: const TextStyle(color: textColor),
        ),
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 335,
            height: MediaQuery.of(context).size.height * .8,
            child: Card(
              color: const Color(0xff21252A),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Message for Solis".tr,
                        style: const TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: TextFormField(
                        maxLines: 20,
                        style: const TextStyle(color: Colors.white),
                        controller: contactText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xff32373E),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: mainTextFormColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: mainTextFormColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: mainTextFormColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: mainTextFormColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Enter your message here...".tr,
                          hintStyle: const TextStyle(color: Color(0xff949494)),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: SaveButton(
                            title: "Send".tr,
                            onTap: () async {
                              if (contactText.text.trim() != '') {
                                await APIRequests()
                                    .contactUsApi(contactText.text);
                                contactText.clear();
                                setState(() {});
                              } else {
                                await showToasterror(
                                    'Please Provide A Brief Description!');
                              }
                            })),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
