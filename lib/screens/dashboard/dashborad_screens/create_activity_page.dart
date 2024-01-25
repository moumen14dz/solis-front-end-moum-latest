import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/showtoast.dart';
import 'package:newproject/utils/textformfield.dart';
import 'package:newproject/widgets/event_creation_widget.dart';

class CreateActivityPage extends StatefulWidget {
  // final String token;
  const CreateActivityPage({
    Key? key,
    // required this.token,
    // required this.messages,
  }) : super(key: key);

  @override
  State<CreateActivityPage> createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends State<CreateActivityPage> {
  bool isRedirected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          "Create your event".tr,
          style: const TextStyle(color: textColor),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: mainColor,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              //height: 70,
              // width: 400,
              child: Wrap(
            //direction: Axis.vertical,
            //spacing: 30,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * .48,
                  height: 50,
                  child: CheckboxListTile(
                    title: const Text("Not redirected",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                    value: !isRedirected,
                    onChanged: (newValue) {
                      setState(() {
                        isRedirected = false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  )),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                  height: 50,
                  child: CheckboxListTile(
                    contentPadding: const EdgeInsets.all(1),
                    title: const Text("Redirected",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                    value: isRedirected,
                    onChanged: (newValue) {
                      setState(() {
                        isRedirected = true;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ))
            ],
          )),
          /*  isRedirected
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter Event Title",
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
                        hintText: "Enter Event Url",
                        controller: redirectUrlEventController,
                      )
                    ],
                  ),
                )
              : */
          EventCreationWidget(isRedirected),
          /*    isRedirected
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: SaveButton(
                      title: "Create",
                      onTap: () {
                        if (redirectUrlEventController.text.isEmpty) {
                          showToasterror('Please Enter Event Link');
                        } else {}
                        (context);
                      }))
              : Container() */
        ],
      )),
    );
  }
}
