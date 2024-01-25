
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:newproject/common/constant.dart';
import 'package:newproject/screens/followers/follower_page.dart';
import 'package:newproject/screens/followers/following_page.dart';
import 'package:newproject/screens/setting/setting_screen.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:newproject/widgets/edit_profile_stack_widget.dart';
import 'package:newproject/widgets/event_grid_widget_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/global_providers.dart';
import '../../../widgets/account_follow_unfollow_detial_widget.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshPage();
  }

  refreshPage() async {
    final service = ref.watch(sharedPreferencesServiceProvider);
    String token = await service.getString(authTokenIdentifier);
    SharedPreferences userpref = await SharedPreferences.getInstance();
    var myId = userpref.getInt("userId");
    await APIRequests().getUserProfileDetails(token: token);
    await APIRequests().getHostedEventsOfUser(token: token);
    await APIRequests().getMyFollowersList(myId.toString(), token: token);
    //await APIRequests().getMyFollowingList(myId.toString());
    const ProfilePage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        /*   actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/search-01.png",
              width: 28,
              height: 28,
            ),
          )
        ], */
        backgroundColor: mainColor,
      ),
      backgroundColor: mainColor,
      body: userProfileDetails.data == null
          ? customCentralCircularProgressLoader()
          : SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EditProfileStackWidget(
                  id: userId,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  userProfileDetails.data!.user!.firstName == null ||
                          userProfileDetails.data!.user!.lastName == null
                      ? "No username Yet"
                      : "${userProfileDetails.data!.user!.firstName!} ${userProfileDetails.data!.user!.lastName!}",
                  style: const TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  userProfileDetails.data!.user!.username == null
                      ? ""
                      : userProfileDetails.data!.user!.username!,
                  style: const TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const AccountFollowUnFollowWidget(),
                listOfUniversitiesModel.data != null
                    ? const Divider(
                        color: dividerColor,
                      )
                    : const SizedBox(),
                listOfUniversitiesModel.data != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          listOfUniversitiesModel.data != null
                              ? listOfUniversitiesModel.data![0].name.toString()
                              : "",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    : const SizedBox(),
                const Divider(
                  color: dividerColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    userProfileDetails.data!.user!.bio!,
                    style: const TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
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
                                  builder: (builder) => const FolowersPage()));
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
                            Text(
                              '${myFollowersList.count == null
                                      ? '0'
                                      : myFollowersList.count.toString()} ${"Followers".tr}',
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
                                  builder: (builder) => const FollowingPage()));
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
                            Text(
                              '${myFollowingList.count == null
                                      ? '0'
                                      : myFollowingList.count.toString()} ${"Following".tr}',
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
                        hostedEventsOfUser.count! == 0
                            ? ''.tr
                            : "${hostedEventsOfUser.count!} ${"Events".tr}",
                        style: const TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const EventGridWidgetProfile(),
              ],
            )),
    );
  }
}
