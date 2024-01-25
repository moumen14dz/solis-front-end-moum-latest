import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:newproject/providers/global_providers.dart';
import 'package:newproject/screens/dashboard/main_dashboard.dart';
import 'package:newproject/screens/splash/language_page.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:newproject/utils/start_activity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/notification_services.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

NotificationServices notificationServices = NotificationServices();

class _SplashScreenState extends ConsumerState<SplashScreen> {
  getData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? email = sharedPrefs.getString('email');
    String? password = sharedPrefs.getString('password');
    bool? language = sharedPrefs.getBool('language');
    await Get.updateLocale(Locale(language ?? false ? 'fr' : 'en'));
    // if (email != null && password != null) {
    //   bool response = await APIRequests().login(email, password);
    //   if (response) {
    //     Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(
    //           builder: (builder) => MainScreen(
    //                 token: true,
    //               )),
    //       (Route<dynamic> route) => false,
    //     );
    //   }
    // } else {
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (builder) => LanguagePage()),
    //     (Route<dynamic> route) => false,
    //   );
    // }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(const Duration(seconds: 3), () async {
      //  _checkTokenAndNavigate();
    });
  }

  Future<void> _checkTokenAndNavigate() async {
    try {
      bool isTokenExist = await ref.read(tokenExistsProvider.future);
      if (isTokenExist) {
        debugPrint("CHECKING_TOKEN: EXIST");
        StartActivity().start(
            context,
            const MainScreen(
              token: true,
              currentIndexOfMainScreenBottomBar: 0,
            ));
      } else {
        debugPrint("CHECKING_TOKEN: NOT EXIST");
        StartActivity().start(context, const LanguagePage());
      }
    } catch (error) {
      debugPrint("CHECKING_TOKEN: ERROR ${error.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      // getData();
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      bool? language = sharedPrefs.getBool('language');
      await Get.updateLocale(Locale(language ?? false ? 'fr' : 'en'));
      // getData();
      await getUserLocation();
      final FirebaseMessaging fcm = FirebaseMessaging.instance;
      final token = await fcm.getToken();
      print("fcm$token");
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("fcm_token", token!);
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (builder) => LanguagePage()),
      //       (Route<dynamic> route) => false,
      // );
      // final token = await _fcm.getToken();
      // print( "fcm"+token.toString());
      // SharedPreferences pref = await SharedPreferences.getInstance();
      // pref.setString("fcm_token", token!);
      notificationServices.requestNotificationPermission();
      notificationServices.forgroundMessage();
      notificationServices.firebaseInit(context);
      notificationServices.setupInteractMessage(context);
      notificationServices.isTokenRefresh();

      notificationServices.getDeviceToken().then((value) {
        if (kDebugMode) {
          print('device token');
          print(value);
        }
      });
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (builder) => LanguagePage()),
      //       (Route<dynamic> route) => false,
      // );
      checkAuthenticationStatus(context);
    });
  }

  Future<void> checkAuthenticationStatus(BuildContext context) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? email = sharedPrefs.getString('email');
    String? password = sharedPrefs.getString('password');

    log("password$password");
    bool? language = sharedPrefs.getBool('language');
    await Get.updateLocale(Locale(language ?? false ? 'fr' : 'en'));
    if (email != null && password != "") {
      bool response = await APIRequests().login(email, password!);
      if (response) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (builder) => const MainScreen(
                    token: true,
                    currentIndexOfMainScreenBottomBar: 0,
                  )),
          (Route<dynamic> route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const LanguagePage()),
          (Route<dynamic> route) => false,
        );
      }
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => const LanguagePage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("dfasdfads ${ref.watch(authTokenProvider.future)}");
    return Scaffold(
      backgroundColor: const Color(0xff0F1216),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/bg.png",
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/logo.png",
                height: 200,
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:newproject/screens/dashboard/main_dashboard.dart';
// import 'package:newproject/screens/splash/language_page.dart';
// import 'package:newproject/utils/controllers.dart';
// import 'package:newproject/utils/requestAPIController.dart';
// import 'package:newproject/utils/showtoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   getData() async {
//     SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
//     String? email = sharedPrefs.getString('email');
//     String? password = sharedPrefs.getString('password');
//     bool? language = sharedPrefs.getBool('language');
//     await Get.updateLocale(Locale(language ?? false ? 'fr' : 'en'));
//     if (email != null && password != null) {
//       bool response = await APIRequests().login(email, password);
//       await getUserLocation();
//       if (response) {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//               builder: (builder) => MainScreen(
//                 token: "",
//               )),
//               (Route<dynamic> route) => false,
//         );
//       }
//     } else {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (builder) => LanguagePage()),
//             (Route<dynamic> route) => false,
//       );
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       // getData();
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (builder) => LanguagePage()),
//             (Route<dynamic> route) => false,);
//       getUserLocation();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff0F1216),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage(
//                 "assets/bg.png",
//               ),
//               fit: BoxFit.cover),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               child: Center(
//                 child: Image.asset(
//                   "assets/logo.png",
//                   height: 200,
//                   width: 200,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
