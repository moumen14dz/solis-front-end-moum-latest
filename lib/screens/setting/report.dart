import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:newproject/utils/showtoast.dart';
import 'package:newproject/utils/textformfield.dart';

class ReportAccount extends StatefulWidget {
  const ReportAccount({super.key});

  @override
  State<ReportAccount> createState() => _ReportAccountState();
}

class _ReportAccountState extends State<ReportAccount> {
  int? selected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Report".tr,
          style: const TextStyle(color: textColor),
        ),
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: 335,
                height: 700,
                child: Card(
                  color: const Color(0xff21252A),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Account Name".tr,
                            style: const TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormInputField(
                              controller: nameControllerReportAAcc,
                              hintText: "Account Name",
                              textInputType: TextInputType.text)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Event name (if applicable)".tr,
                            style: const TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormInputField(
                            controller: eventNamenControllerReportAAcc,
                            hintText: "Event Name",
                            textInputType: TextInputType.text),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(left: 0, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nature du problème".tr,
                                style: const TextStyle(
                                    color: textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              CheckboxListTile(
                                activeColor: const Color(0xff474F57),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Transform.translate(
                                  offset: const Offset(-20, 0),
                                  child: const Text(
                                    'During the event',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                value: selected == 0 ? true : false,
                                onChanged: (bool? value) {
                                  setState(() {
                                    selected = 0;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                activeColor: const Color(0xff474F57),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Transform.translate(
                                  offset: const Offset(-20, 0),
                                  child: Text(
                                    'Messaging'.tr,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                value: selected == 1 ? true : false,
                                onChanged: (bool? value) {
                                  setState(() {
                                    selected = 1;
                                  });
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: CheckboxListTile(
                                  activeColor: const Color(0xff474F57),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Transform.translate(
                                    offset: const Offset(-20, 0),
                                    child: Text(
                                      'Mobile app issue'.tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  value: selected == 2 ? true : false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      selected = 2;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Description of the issue".tr,
                            style: const TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: TextFormField(
                          maxLines: 3,
                          style: const TextStyle(color: Colors.white),
                          controller: description,
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
                            hintText: "Description".tr,
                            hintStyle: const TextStyle(color: Color(0xff949494)),
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
                                  if (nameControllerReportAAcc.text.trim() ==
                                          '' /* ||
                                      eventNamenControllerReportAAcc.text
                                              .trim() ==
                                          '' */
                                      ||
                                      description.text.trim() == '') {
                                    showToasterror(
                                        'Please Provide The Relevant Details Above!');
                                    return;
                                  } else {
                                    if (selected == null) {
                                      showToasterror(
                                          'Please Select The Nature Of The Problem!');
                                      return;
                                    }
                                  }
                                  await APIRequests().reportAAcc(
                                      nameControllerReportAAcc.text,
                                      eventNamenControllerReportAAcc.text,
                                      selected == 0
                                          ? 'During The Event'
                                          : selected == 1
                                              ? 'Messaging'
                                              : 'Mobile App Issue',
                                      description.text,
                                      '33');
                                  nameControllerReportAAcc.clear();
                                  eventNamenControllerReportAAcc.clear();
                                  description.clear();
                                  Navigator.of(context).pop();
                                })),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
