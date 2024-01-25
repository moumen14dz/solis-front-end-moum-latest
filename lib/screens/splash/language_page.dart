import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/accounttype/account_page.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F1216),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/back.png",
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            SvgPicture.asset(
              "assets/Logo v.2.svg",
            ),
            const Spacer(),
            const Text(
              "BONJOUR, HELLO!",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Text(
              "Choisissez une langue préférée / \nChoose a preferred languages ",
              style: TextStyle(
                  color: Colors.white.withOpacity(.6),
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
              textAlign: TextAlign.center,
            ),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: SaveButton(
                  title: "English",
                  onTap: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setBool('language', false);
                    await Get.updateLocale(const Locale('en'));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => const AccountPage()));
                  },
                )),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: SaveButton(
                  title: "French",
                  onTap: () async {
                    SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                    sharedPreferences.setBool('language', true);
                    await Get.updateLocale(const Locale('fr'));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => const AccountPage()));
                  },
                )),
            //
            // InkWell(
            //   onTap: () async {
            //     SharedPreferences sharedPreferences =
            //         await SharedPreferences.getInstance();
            //     sharedPreferences.setBool('language', true);
            //     await Get.updateLocale(const Locale('fr'));
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (builder) => AccountPage()));
            //   },
            //   child: Container(
            //       margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            //       child: Image.asset("assets/frans.png")),
            // ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
