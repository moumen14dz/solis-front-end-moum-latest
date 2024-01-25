import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/utils/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "Terms & conditions".tr,
            style: const TextStyle(color: textColor),
          ),
          backgroundColor: mainColor,
        ),
        body: Container(child: SfPdfViewer.asset('assets/terms.pdf'))
        // SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Center(
        //         child: Container(
        //           margin: EdgeInsets.all(10),
        //           child: SizedBox(
        //             width: 335,
        //             height: 830,
        //             child: Card(
        //               color: Color(0xff21252A),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   SizedBox(
        //                     height: 10,
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Container(
        //                       margin: EdgeInsets.only(left: 10),
        //                       child: Text(
        //                         "1.2. Only businesses are allowed to:".tr,
        //                         style: TextStyle(
        //                             color: textColor,
        //                             fontSize: 14,
        //                             fontWeight: FontWeight.w600),
        //                       ),
        //                     ),
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Container(
        //                       margin: EdgeInsets.only(left: 10, right: 10),
        //                       child: Text(
        //                         longTextTerm,
        //                         style: TextStyle(
        //                             color: Color(0xffC2C2C2),
        //                             fontSize: 12,
        //                             fontWeight: FontWeight.w600),
        //                         textAlign: TextAlign.justify,
        //                       ),
        //                     ),
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Container(
        //                       margin: EdgeInsets.only(left: 10),
        //                       child: Text(
        //                         "1.2. Only businesses are allowed to:".tr,
        //                         style: TextStyle(
        //                             color: textColor,
        //                             fontSize: 14,
        //                             fontWeight: FontWeight.w600),
        //                       ),
        //                     ),
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Container(
        //                       margin: EdgeInsets.only(left: 10, right: 10),
        //                       child: Text(
        //                         longTextTerm,
        //                         style: TextStyle(
        //                             color: Color(0xffC2C2C2),
        //                             fontSize: 12,
        //                             fontWeight: FontWeight.w600),
        //                         textAlign: TextAlign.justify,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
