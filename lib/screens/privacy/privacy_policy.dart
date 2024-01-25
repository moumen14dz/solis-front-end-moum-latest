import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/login/sign_in_account.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/textUtils.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Terms & conditions".tr,
          style: const TextStyle(
              color: Color(0xffF9FAFB),
              fontWeight: FontWeight.bold,
              fontSize: 30),
          textAlign: TextAlign.center,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff0F1216),
      ),
      backgroundColor: const Color(0xff0F1216),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              privacyText,
              style: TextStyle(color: textColor),
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SaveButton(
                  title: "Accept".tr,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const SignInAccount([])));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
