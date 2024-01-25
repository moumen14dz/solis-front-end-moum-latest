import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/login/sign_in_account.dart';
import 'package:newproject/screens/setting/contact_us.dart';
import 'package:newproject/screens/setting/language_setting.dart';
import 'package:newproject/screens/setting/report.dart';
import 'package:newproject/screens/setting/terms.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/showtoast.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Setting".tr,
          style: const TextStyle(color: textColor),
        ),
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              color: const Color(0xff21252A),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const ReportAccount()));
                    },
                    leading: Image.asset(
                      "assets/Left Icon.png",
                      height: 20,
                      width: 20,
                    ),
                    trailing: Image.asset(
                      "assets/chevron-right.png",
                      height: 25,
                      width: 24,
                    ),
                    title: Text(
                      "Report".tr,
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => const ContactUs()));
                    },
                    leading: Image.asset(
                      "assets/contact.png",
                      height: 20,
                      width: 20,
                    ),
                    trailing: Image.asset(
                      "assets/chevron-right.png",
                      height: 25,
                      width: 24,
                    ),
                    title: Text(
                      "Contact us".tr,
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => const Terms()));
                    },
                    leading: Image.asset(
                      "assets/note.png",
                      height: 20,
                      width: 20,
                    ),
                    trailing: Image.asset(
                      "assets/chevron-right.png",
                      height: 25,
                      width: 24,
                    ),
                    title: Text(
                      "Terms & conditions".tr,
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const LanguageSetting()));
                    },
                    leading: Image.asset(
                      "assets/translate_FILL0_wght300_GRAD0_opsz20 1.png",
                      height: 20,
                      width: 20,
                    ),
                    trailing: Image.asset(
                      "assets/chevron-right.png",
                      height: 25,
                      width: 24,
                    ),
                    title: Text(
                      "Language".tr,
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () async {
                      // await LogOutRepositoryImpl.attemptLogOut(bearerToken: userToken);
                      bool response = await APIRequests().logout();

                      if (response) {
                        SharedPreferences sharedPrefss =
                            await SharedPreferences.getInstance();
                        try {
                          await sharedPrefss.remove('email');
                          await sharedPrefss.remove('password');
                        } catch (e) {
                          print(e);
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const SignInAccount([])));
                      }
                    },
                    leading: Image.asset(
                      "assets/logout-48.ico",
                      height: 20,
                      width: 20,
                    ),
                    trailing: Image.asset(
                      "assets/chevron-right.png",
                      height: 25,
                      width: 24,
                    ),
                    title: Text(
                      "Logout".tr,
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 200,
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete your Account?'),
                            content: const Text(
                                '''If you select Delete we will delete your account on our server.

Your app data will also be deleted and you won't be able to retrieve it.

Since this is a security-sensitive operation, you eventually are asked to login before your account can be deleted.'''),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                  child: isLoading
                                      ? const CircularProgressIndicator()
                                      : const Text('Delete',
                                          style: TextStyle(
                                            color: Colors.red,
                                          )),
                                  onPressed: () async {
                                    // bool response =
                                    //   await APIRequests().logout();
                                    isLoading
                                        ? {}
                                        : () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            bool response = await APIRequests()
                                                .deleteAcount();

                                            if (response) {
                                              SharedPreferences sharedPrefss =
                                                  await SharedPreferences
                                                      .getInstance();
                                              try {
                                                await sharedPrefss
                                                    .remove('email');
                                                await sharedPrefss
                                                    .remove('password');
                                              } catch (e) {
                                                print(e);
                                              }
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          const SignInAccount([])));
                                            } else {
                                              await showToasterror(
                                                  'Somethink went wrong. Please try again!');

                                              setState(() {
                                                isLoading = false;
                                              });
                                            }
                                          };
                                  }
                                  // Call the delete account function

                                  ),
                            ],
                          );
                        },
                      );
                      // await LogOutRepositoryImpl.attemptLogOut(bearerToken: userToken);
                    },
                    leading: Image.asset(
                      "assets/logout-48.ico",
                      height: 20,
                      width: 20,
                    ),
                    trailing: Image.asset(
                      "assets/chevron-right.png",
                      height: 25,
                      width: 24,
                    ),
                    title: Text(
                      "Delete Account".tr,
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
