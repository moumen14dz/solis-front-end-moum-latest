import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/dashboard/main_dashboard.dart';
import 'package:newproject/screens/setting/setting_screen.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/constant.dart';
import '../../../model/UsersListModel.dart';
import '../../../providers/global_providers.dart';
import '../../../utils/requestAPIController.dart';
import '../../../widgets/accounts_profile_stack_widget.dart';
import '../../../widgets/event_grid_widget_profileaccount.dart';
import '../../../widgets/otheruser_account_follow_widget.dart';
import '../../followers/AccontFollow.dart';
import '../../followers/AccountFollowing.dart';
import 'accountChatPage.dart';

class AccountsProfilePage extends ConsumerStatefulWidget {
  Users? item;
  int? id;
  int index;
  bool? isFollowing;
  AccountsProfilePage(
      {super.key, this.item, this.id, required this.index, this.isFollowing});

  @override
  ConsumerState<AccountsProfilePage> createState() =>
      _AccountsProfilePageState();
}

class _AccountsProfilePageState extends ConsumerState<AccountsProfilePage> {
  late bool isFollowing;

  bool isloading = false;

  @override
  void initState() {
    isFollowing = widget.isFollowing!;

    log("isFollowing$isFollowing");
    //   checkIfFollowing();
    refreshPage();
    // TODO: implement initState
    super.initState();
    // loadIsFollowing(widget.id.toString()).then((value) {
    //   setState(() {
    //     isFollowing = value;
    //   });
    // });
  }

//   void saveIsFollowing(String itemId, bool isFollowing) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('following_$itemId', isFollowing);
//   }
//
// // Function to load the isFollowing state
//   Future<bool> loadIsFollowing(String itemId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('following_$itemId') ?? false;
//   }
  checkIfFollowing() async {
    SharedPreferences userpref = await SharedPreferences.getInstance();
    var myId = userpref.getInt("userId");
    final service = ref.watch(sharedPreferencesServiceProvider);
    String token = await service.getString(authTokenIdentifier);
    await APIRequests().getMyFollowingList(myId.toString(), token: token);
    // Replace this logic with your own API request to check if the user is following the item.
    // bool following = await APIRequests().followOrUnfollowAccount(isFollowing,myId.toString(), widget.id.toString(),setState(() {}));
    print("oidd${widget.item!.id}");
    print("oifd${myFollowingList.data![0].id}");
    isFollowing =
        myFollowingList.data!.any((data) => data.id == widget.item!.id)
            ? true
            : false;

    print("objecttt$isFollowing");
    if (isFollowing == true) {
      setState(() {
        isFollowing = !isFollowing;
        print("objecttt2$isFollowing");
        // saveIsFollowing(isFollowing);
      });
    } else {
      setState(() {
        isFollowing = !isFollowing;
        print("objecttt2$isFollowing");
        // saveIsFollowing(isFollowing);
      });
    }
  }

  void toggleFollow() async {
    SharedPreferences userpref = await SharedPreferences.getInstance();
    var myId = userpref.getInt("userId");
    // print("test"+myFollowingList.data![widget.id!].pivot!.followId.toString());
    // userProfileDetails.data!.user!.coverImage!.contains('http')

    print("isfollow$isFollowing");
    setState(() {
      isloading = true;

      isFollowing = !isFollowing;
      // saveIsFollowing(widget.id.toString(),isFollowing);
    });
    // bool status= userslist.data![widget.id!].id==widget.id?true:false;
    final service = ref.watch(sharedPreferencesServiceProvider);
    String token = await service.getString(authTokenIdentifier);
    await APIRequests().followOrUnfollowAUser(!isFollowing, myId.toString(),
        widget.item!.id.toString(), setState(() {}),
        token: token);
    await APIRequests().getMyFollowersList1(widget.item!.id.toString());
    setState(() {
      isloading = false;
    });
  }

  refreshPage() async {
    setState(() {
      isloading = true;
    });
    // final service = ref.watch(sharedPreferencesServiceProvider);
    //  String token = await service.getString(authTokenIdentifier);
    print("${widget.id}");
    await APIRequests().getMyFollowingList1(widget.id.toString());
    // setState(() {});
    await APIRequests().getMyFollowersList1(widget.id.toString());

    //setState(() {});
    //await APIRequests().getUserProfileDetails(token: token);
    //setState(() {});
    // await APIRequests()
    //   .getHostedEventsOfotherUser(widget.id.toString(), token: token);
    //setState(() {});
    AccountsProfilePage(
      index: widget.index,
    );
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool canFollow = false;
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainScreen(
                        token: true,
                        currentIndexOfMainScreenBottomBar: 3,
                      )));
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const SettingScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/menu-04.png",
                  width: 28,
                  height: 28,
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/search-01.png",
                  width: 28,
                  height: 28,
                ),
              )
            ],
            backgroundColor: mainColor,
          ),
          backgroundColor: mainColor,
          body: userProfileDetails.data == null
              ? customCentralCircularProgressLoader()
              : SingleChildScrollView(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AccountEditProfileStackWidget(
                        item: widget.item!, id: widget.id),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.item!.firstName == null ||
                              widget.item!.lastName == null
                          ? ""
                          : "${widget.item!.firstName!} ${widget.item!.lastName!}",
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.item!.username == null
                          ? ""
                          : widget.item!.username!,
                      // "No Username Yet",
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    UserAccountFollowUnFollowWidget(
                      id: widget.id.toString(),
                      index: widget.index,
                    ),
                    const Divider(
                      color: dividerColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => AccountFolowersPage(
                                            id: widget.id,
                                            item: widget.item,
                                            index: widget.index,
                                          )));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/Avatar Group.png",
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                isloading
                                    ? Shimmer.fromColors(
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.black,
                                        child: Text(
                                          "??  ${"Followers".tr}",
                                          style: const TextStyle(
                                              color: textColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ))
                                    : Text(
                                        "${myFollowersList1.count == null
                                                ? '0'
                                                : myFollowersList1.count
                                                    .toString()} ${"Followers".tr}",
                                        style: const TextStyle(
                                            color: textColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          AccountsFollowingPage(
                                              id: widget.id,
                                              item: widget.item)));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/Avatar Group.png",
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                isloading
                                    ? Shimmer.fromColors(
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.black,
                                        child: Text(
                                          "??  ${"Following".tr}",
                                          style: const TextStyle(
                                              color: textColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ))
                                    : Text(
                                        "${myFollowingList1.count == null
                                                ? '0'
                                                : myFollowingList1.count
                                                    .toString()} ${"Following".tr}",
                                        style: const TextStyle(
                                            color: textColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: dividerColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(340, 49),
                                  backgroundColor: buttonColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: toggleFollow,
                              child: Text(isFollowing ? 'Follow' : 'UnFollow',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: OutlineButton(
                              title: "Message".tr,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AccountChatPage(
                                        item: widget.item,
                                        id: widget.id.toString()),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hosted Events".tr,
                            style: const TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            hostedEventsOfotherUser.count == 0
                                ? 'No Hosted'.tr
                                : "${hostedEventsOfotherUser.count} ${"Events".tr}",
                            style: const TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    EventGridWidgetAccountProfile(id: widget.id.toString()),
                  ],
                )),
        ));
  }
}


//       Flexible(
//         child: canFollow==false
//             ? ElevatedButton(
//                 // title: "Follow",
//                   onPressed: () async {
// SharedPreferences userpref =
// await SharedPreferences.getInstance();
// var myId = userpref.getInt("userId");
// //True For Follow False For Un Follow
// // My Id and Corresponding User ID will be updated later when User Data Provider is initiated
// // if (loader == false) {
// //   setState(() {
// //     loader = true;
// //   });
// await APIRequests().followOrUnfollowAccount(
// true,
// myId.toString(),
// widget.item!.id.toString(),
// setState(() {}));
// setState(() {
// canFollow=true;
// });
// // }
// // else {
// //   await showToasterror('Loading!');
// // }
// }, child: ,
//                 )
//             : SaveButton(
//                 title: "UnFollow",
//                 onTap: () async {
//                   SharedPreferences userpref =
//                       await SharedPreferences.getInstance();
//                   var myId = userpref.getInt("userId");
//                   //True For Follow False For Un Follow
//                   // My Id and Corresponding User ID will be updated later when User Data Provider is initiated
//                   // if (loader == false) {
//                   //   setState(() {
//                   //     loader = true;
//                   //   });
//                     await APIRequests().followOrUnfollowAccount(
//                         false,
//                         myId.toString(),
//                         widget.item!.id.toString(),
//                         setState(() {}));
//                   setState(() {
//                     canFollow=false;
//                   });
//                   // } else {
//                   //   await showToasterror('Loading!');
//                   // }
//                 }),
//       ),