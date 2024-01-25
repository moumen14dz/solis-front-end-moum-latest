import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:newproject/common/constant.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/showtoast.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/global_providers.dart';

class FolowersPage extends ConsumerStatefulWidget {
  const FolowersPage({super.key});

  @override
  ConsumerState<FolowersPage> createState() => _FolowersPageState();
}

class _FolowersPageState extends ConsumerState<FolowersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshPage();
    setState(() {});
  }

  refreshPage() async {
    SharedPreferences userpref = await SharedPreferences.getInstance();
    var myId = userpref.getInt("userId");
    setState(() {});
    final service = ref.watch(sharedPreferencesServiceProvider);
    String token = await service.getString(authTokenIdentifier);
    await APIRequests().getMyFollowersList(myId.toString(), token: token);
    // setState(() {});
    const FolowersPage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Followers".tr,
          style: const TextStyle(color: textColor),
        ),
        backgroundColor: mainColor,
      ),
      backgroundColor: mainColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextFormField(
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: mainColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),

                      borderSide: const BorderSide(color: mainTextFormColor),
//<-- SEE HERE
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: mainTextFormColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: mainTextFormColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: mainTextFormColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: mainTextFormColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/search-01.png",
                        height: 12,
                      ),
                    ),
                    hintText: "Search Chat".tr,
                    hintStyle: TextStyle(
                        color: const Color(0xffFFFFFF).withOpacity(.3))),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: ListView.builder(
                itemCount: myFollowersList.data != null
                    ? myFollowersList.data!.length
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  bool canFollow = true;
                  try {
                    if (myFollowingList.data != null) {
                      for (var i in myFollowingList.data!) {
                        if (i.id == myFollowersList.data![index].id) {
                          canFollow = false;
                        }
                      }
                    }
                  } catch (e) {}
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      leading: const CircleAvatar(
                          backgroundImage: AssetImage("assets/Image.png")),
                      title: Text(
                        '${myFollowersList.data![index].firstName} ${myFollowersList.data![index].lastName}',
                        style: const TextStyle(
                            color: Color(0xffF9FAFB),
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      subtitle: Text(
                        myFollowersList.data![index].id.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xffA2A5AA)),
                      ),
                      trailing: SizedBox(
                          height: 35,
                          width: 120,
                          child: SaveButton(
                              title: canFollow ? "Follow".tr : 'Unfollow'.tr,
                              onTap: () async {
                                SharedPreferences userpref =
                                    await SharedPreferences.getInstance();
                                var myId = userpref.getInt("userId");
                                final service =
                                    ref.watch(sharedPreferencesServiceProvider);
                                String token = await service
                                    .getString(authTokenIdentifier);
                                //True For Follow False For Un Follow
                                // My Id and Corresponding User ID will be updated later when User Data Provider is initiated
                                if (loader == false) {
                                  setState(() {
                                    loader = true;
                                  });
                                  if (canFollow) {
                                    await APIRequests().followOrUnfollowAUser(
                                        true,
                                        myId.toString(),
                                        myFollowersList.data![index].id
                                            .toString(),
                                        setState(() {}),
                                        token: token);
                                  } else {
                                    await APIRequests().followOrUnfollowAUser(
                                        false,
                                        myId.toString(),
                                        myFollowersList.data![index].id
                                            .toString(),
                                        setState(() {}),
                                        token: token);
                                  }
                                  await APIRequests().getMyFollowersList(
                                      myId.toString(),
                                      token: token);
                                  setState(() {});
                                } else {
                                  await showToasterror('Loading!');
                                }
                              })),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
