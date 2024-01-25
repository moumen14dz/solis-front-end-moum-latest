
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/common/constant.dart';
import 'package:newproject/screens/dashboard/dashborad_screens/create_activity_page.dart';
import 'package:newproject/screens/dashboard/dashborad_screens/emogi_page.dart';
import 'package:newproject/screens/dashboard/dashborad_screens/home_page.dart';
import 'package:newproject/screens/dashboard/dashborad_screens/message_page.dart';
import 'package:newproject/screens/dashboard/dashborad_screens/profie_page.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/global_providers.dart';
import '../../utils/controllers.dart';
import '../../utils/requestAPIController.dart';

class MainScreen extends ConsumerStatefulWidget {
  final bool token;
  final int currentIndexOfMainScreenBottomBar;

  const MainScreen(
      {Key? key,
      required this.token,
      required this.currentIndexOfMainScreenBottomBar
      // required this.messages,
      })
      : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

late int currentIndexOfMainScreenBottomBar;

class _MainScreenState extends ConsumerState<MainScreen> {
  // late List<Widget> _screens;

  // getUserData() async {
  //   // if (widget.token == true) {
  //
  //     await APIRequests().eventsOfCurrentWeek();
  //     await APIRequests().allFutureEvents();
  //     await APIRequests().getHostedEventsOfUser();
  //     // await APIRequests().getUserProfileDetails();
  //     // await APIRequests()
  //     //     .getMyFollowingList(loginResponseModel.data!.user!.id.toString());
  //     // await APIRequests()
  //     //     .getMyFollowersList(loginResponseModel.data!.user!.id.toString());
  //     await APIRequests().getCategoriesOfEvents();
  //     await APIRequests().getCountriesFromAPICall();
  //     await APIRequests().getAllUniversities();
  //     SharedPreferences userpref =
  //     await SharedPreferences.getInstance();
  //     var myId = userpref.getInt("userId");
  //     await APIRequests().followOrUnfollowAUser(
  //        true, myId.toString(), "6", setState(() {}));
  //     var followId = myFollowingList.data!.first.pivot!.userId.toString();
  //     print("fooloe" + followId.toString());
  //     await APIRequests().getMyFollowingList(myId.toString());
  //     await APIRequests().getMyFollowingList1(followId);
  //     await APIRequests().getMyFollowersList(myId.toString());
  //
  //     // await APIRequests().getMessages();
  //     // print("inboc"+APIRequests().getinbox().toString());
  //     // await ChatMessageService().getMessageThreads();
  //     // await ChatMessageService().getMessages();
  //     if (userLocation == null) {
  //       await getUserLocation();
  //     }
  //
  //     setState(() {});
  //   // }
  // }

  getUserData() async {
    if (widget.token == true) {
      SharedPreferences userpref = await SharedPreferences.getInstance();
      final service = ref.watch(sharedPreferencesServiceProvider);
      String token = await service.getString(authTokenIdentifier);
      debugPrint("AUTH_TOKEN: $token");
      var myId = userpref.getInt("userId");
      await APIRequests().eventsOfCurrentWeek(token: token);
      await APIRequests().allFutureEvents(token: token);
      await APIRequests().getHostedEventsOfUser(token: token);
      await APIRequests().getMyFollowersList(myId.toString(), token: token);
      await APIRequests().getMyFollowingList(myId.toString(), token: token);
      await APIRequests().getUserProfileDetails(token: token);
      await APIRequests().getCategoriesOfEvents();
      ///////////////////////////////////////////////////////
      // await APIRequests().getUsersList();
      // var userId = userslist.data;
      // await APIRequests().getHostedEventsOfUser();
      // await APIRequests().getHostedEventsOfotherUser(userId![0].id.toString());
      // await APIRequests().getUserProfileDetails();
      // await APIRequests()
      //     .getMyFollowingList(loginResponseModel.data!.user!.id.toString());
      // await APIRequests()
      //     .getMyFollowersList(loginResponseModel.data!.user!.id.toString());
      // await APIRequests().getCategoriesOfEvents();
      // await APIRequests().getCountriesFromAPICall();
      // await APIRequests().getAllUniversities();

      // await APIRequests()
      //     .followOrUnfollowAUser(true, myId.toString(), "6", setState(() {}));
      // var followId = myFollowingList.data!.first.pivot!.userId.toString();
      // print("fooloe" + followId.toString());
      // await APIRequests().getMyFollowingList(myId.toString());
      // await APIRequests().getMyFollowingList1(followId);
      // await APIRequests().getMyFollowersList(myId.toString());
      //  await APIRequests().getinbox();
      // print("inboc"+APIRequests().getinbox().toString());
      // await ChatMessageService().getMessageThreads();
      // await ChatMessageService().getMessages();
      if (userLocation == null) {
        await getUserLocation();
      }

      setState(() {});
    } else {
      debugPrint("AUTH_TOKEN: aaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    }
  }

  @override
  void initState() {
    currentIndexOfMainScreenBottomBar =
        widget.currentIndexOfMainScreenBottomBar;
    super.initState();
    getUserData();
    // Timer.periodic(const Duration(minutes: 5), (timer) async {
    //   SharedPreferences sharedPrefss = await SharedPreferences.getInstance();
    //   await APIRequests().login(sharedPrefss.getString('email') ?? '',
    //       sharedPrefss.getString('password') ?? '');
    // });
  }

  final List<Widget> _screens = [
    const HomePage(), // Replace with your screen widgets
    const MessagePage(),
    const CreateActivityPage(),
    // FollowingPage(),
    const EmogiPage(),
    const ProfilePage()
  ];
  DateTime? lastBackPressed;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (lastBackPressed == null ||
              DateTime.now().difference(lastBackPressed!) >
                  const Duration(seconds: 3)) {
            // If it's been more than 2 seconds since the last back button press,
            // show a toast message
            lastBackPressed = DateTime.now();
            await showToasterror("Press back button again to exit");
            return false;
          } else {
            SystemNavigator.pop();
            return true;
          }
        },
        child: allFutureEventsList.data == null
            ? Scaffold(
                backgroundColor: mainColor,
                body: customCentralCircularProgressLoader())
            : Scaffold(
                body: _screens[currentIndexOfMainScreenBottomBar],
                bottomNavigationBar: Container(
                  height: 60, // Give your desired height here
                  color: mainColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          child: buildNavItem(0, 'assets/homeblue.png',
                              'assets/home.png', 'Home')),
                      Container(
                          alignment: Alignment.center,
                          child: buildNavItem(1, 'assets/mcolor.png',
                              'assets/message.png', 'Message')),
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: buildNavItem(
                              2, 'assets/add.png', 'assets/add.png', '')),
                      Container(
                        alignment: Alignment.center,
                        child: buildNavItem(3, 'assets/blue.png',
                            'assets/smiley-happy-plus.png', 'Follow'),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: buildNavItem(4, 'assets/profileblue.png',
                            'assets/user-profile-02.png', 'Account'),
                      ),
                    ],
                  ),
                ),
              ));
  }

  Widget buildNavItem(int index, String activeIcon, String icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Add this line
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              currentIndexOfMainScreenBottomBar = index;
            });
          },
          child: Image.asset(
            currentIndexOfMainScreenBottomBar == index ? activeIcon : icon,
            fit: BoxFit.contain,
            height: index == 2 ? 50 : 24, // Adjust the height as per your need
            width: index == 2 ? 50 : 24, // Adjust the height as per your need
          ),
        ),
        if (label.isNotEmpty)
          Text(
            label,
            style: TextStyle(
              color: currentIndexOfMainScreenBottomBar == index
                  ? buttonColor
                  : Colors.transparent,
            ),
          )
      ],
    );
  }
}
// return Scaffold(
//   body: _screens[_currentIndex],
//   bottomNavigationBar: BottomNavigationBar(
//     type: BottomNavigationBarType.fixed,
//     currentIndex: _currentIndex,
//     onTap: (index) {
//       setState(() {
//         _currentIndex = index;
//       });
//     },
//     items: [
//       BottomNavigationBarItem(
//         icon: Image.asset(
//           _currentIndex == 0 ? 'assets/homeblue.png' : 'assets/home.png',
//         ),
//         label: 'Home',
//       ),
//       BottomNavigationBarItem(
//         icon: Image.asset(
//           _currentIndex == 1 ? 'assets/mcolor.png' : 'assets/message.png',
//         ),
//         label: 'Message',
//       ),
//       BottomNavigationBarItem(
//         label: "",
//         icon: Image.asset(
//           _currentIndex == 2 ? 'assets/add.png' : 'assets/add.png',
//         ),
//       ),
//       BottomNavigationBarItem(
//         label: "Follow",
//         icon: Image.asset(
//           _currentIndex == 3
//               ? 'assets/blue.png'
//               : 'assets/smiley-happy-plus.png',
//         ),
//       ),
//       BottomNavigationBarItem(
//         label: "Account",
//         icon: Image.asset(
//           _currentIndex == 4
//               ? 'assets/profileblue.png'
//               : 'assets/user-profile-02.png',
//         ),
//       )
//     ],
//     backgroundColor: mainColor, // Set your desired background color here
//     selectedItemColor: buttonColor, // Set the color for selected item
//     unselectedItemColor:
//         Colors.transparent, // Set the color for unselected items
//   ),
// );
