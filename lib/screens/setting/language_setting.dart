import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({super.key});

  @override
  State<LanguageSetting> createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  String locale = '';
  getLang() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    bool? language = sharedPrefs.getBool('language');
    locale = language ?? false ? 'fr' : 'en';
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Language".tr,
          style: const TextStyle(color: textColor),
        ),
        backgroundColor: mainColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: const Color(0xff21252A),
              child: Column(
                children: [
                  ListTile(
                    onTap: () async {
                      if (locale == 'fr') {
                        SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                        sharedPreferences.setBool('language', false);
                        await Get.updateLocale(const Locale('en'));
                        await getLang();
                      }
                    },
                    trailing: locale == 'en'
                        ? const Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                        : null,
                    title: Text(
                      "English".tr,
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () async {
                      if (locale == 'en') {
                        SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                        sharedPreferences.setBool('language', true);
                        await Get.updateLocale(const Locale('fr'));
                        await getLang();
                      }
                    },
                    trailing: locale == 'fr'
                        ? const Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                        : null,
                    title: Text(
                      "French".tr,
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
