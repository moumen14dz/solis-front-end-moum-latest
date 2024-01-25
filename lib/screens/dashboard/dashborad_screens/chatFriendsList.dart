import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constant.dart';
import '../../../model/UsersListModel.dart';
import '../../../providers/global_providers.dart';
import '../../../utils/buttons.dart';
import '../../../utils/requestAPIController.dart';
import 'package:shimmer/shimmer.dart';

import 'accountChatPage.dart';

class ChatEmogiPage extends ConsumerStatefulWidget {
  const ChatEmogiPage({super.key});

  @override
  ConsumerState<ChatEmogiPage> createState() => _EmogiPageState();
}

class _EmogiPageState extends ConsumerState<ChatEmogiPage> {
  String otherId = '';

  bool userLoading = false;
  bool meLoading = false;

  getTheseAccounts() async {
    setState(() {
      meLoading = true;
    });
    SharedPreferences userpref = await SharedPreferences.getInstance();
    var myId = userpref.getInt("userId");

    final service = ref.watch(sharedPreferencesServiceProvider);
    String token = await service.getString(authTokenIdentifier);

    await APIRequests().getMyFollowingList(myId.toString(), token: token);
    setState(() {
      meLoading = false;
    });
  }

  List<Users> list_student = [];
  List<Users> list_association = [];
  List<Users> list_busniss = [];
  @override
  void initState() {
    super.initState();

    getUsersList();

    getTheseAccounts();
  }

  getHotestedevents(String userId) async {
    log(userId);
    log("$userslist");

    final service = ref.watch(sharedPreferencesServiceProvider);
    String token = await service.getString(authTokenIdentifier);
    await APIRequests().getHostedEventsOfotherUser(userId, token: token);
  }

  getUsersList() async {
    setState(() {
      userLoading = true;
    });
    await APIRequests().getUsersList();
    setState(() {
      list_student = userslist.data!
          .where((element) => element.userType == 'student')
          .toList();
      list_association = userslist.data!
          .where((element) => element.userType == 'association')
          .toList();
      list_busniss = userslist.data!
          .where((element) => element.userType == 'business')
          .toList();

      userLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // myFollowingList = MyFollowingList();
  }

  @override
  Widget build(BuildContext context) {
    if (userslist.data != null) {}
    // otherId = myFollowersList.data!.firstWhere((element) => element.id==hostedEventsOfotherUser.data![0].id).id.toString();
    print("other$otherId");
    return Scaffold(
      backgroundColor: mainColor,
      body: userslist.data == null
          ? customCentralCircularProgressLoader()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: TextFormField(
                        controller: followerSearch,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            userslist.data = getUserListSearch!
                                .where((element) =>
                                    element.firstName != null &&
                                    element.firstName!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                .toList();
                            if (value == '') {
                              // await showToasterror('User Name Cannot Be Empty!');
                              userslist.data = getUserListSearch;
                            }
                          });
                        },
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
                            hintText: "Search an Account".tr,
                            hintStyle: TextStyle(
                                color: const Color(0xffFFFFFF).withOpacity(.3))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromARGB(133, 15, 14, 14),
                      child: Text(
                        "My Friends".tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xffF9FAFB),
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  meLoading
                      ? SizedBox(
                          height: 300.0,
                          child: ListView.builder(
                              itemCount: 3,
                              // itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                return Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 231, 224, 224),
                                  highlightColor:
                                      const Color.fromARGB(255, 92, 91, 86),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/profileblue.png"),
                                      ),
                                      title: Text(
                                        // "Alfredo Calzoni",

                                        "Loading ..",
                                        style: TextStyle(
                                            color: Color(0xffF9FAFB),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                );
                              }))
                      : SizedBox(
                          height: myFollowingList.data!.length < 3
                              ? myFollowingList.data!.length * 90
                              : 250,
                          child: ListView.builder(
                              itemCount: myFollowingList.data!.length,
                              // itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                log("${myFollowingList.data![index].toJson()}");
                                String image = '';

                                if (myFollowingList.data![index].image !=
                                    null) {
                                  if (myFollowingList.data![index].image!
                                          .contains('http') ||
                                      myFollowingList.data![index].image!
                                          .contains('https')) {
                                    image = Uri.parse(
                                            myFollowingList.data![index].image!)
                                        .toString();
                                  }
                                }
                                return GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AccountChatPage(
                                                  item: userslist.data!
                                                      .where((element) =>
                                                          element.id ==
                                                          myFollowingList
                                                              .data![index].id)
                                                      .first,
                                                  // userslist.data![index],
                                                  id: userslist.data!
                                                      .where((element) =>
                                                          element.id ==
                                                          myFollowingList
                                                              .data![index].id)
                                                      .first
                                                      .id
                                                      .toString(),
                                                )));

                                    //  ProfilePage()
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: image != ''
                                            ? NetworkImage(image)
                                                as ImageProvider
                                            : const AssetImage(
                                                "assets/profileblue.png"),
                                      ),
                                      title: Text(
                                        // "Alfredo Calzoni",
                                        myFollowingList.data![index] != null ||
                                                myFollowingList.data![index]
                                                        .lastName !=
                                                    null
                                            ? "${myFollowingList
                                                    .data![index].firstName} ${myFollowingList
                                                    .data![index].lastName}"
                                            : "",
                                        style: const TextStyle(
                                            color: Color(0xffF9FAFB),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                      /*     subtitle: Text(
                                          // myFollowingList.data![index].pivot!.followId.toString()??"",
                                          myFollowingList.data![index].eventCount == 0
                                              ? 'No Hosted Events'
                                              : myfollowinglist!.data![index]
                                                      .eventCount
                                                      .toString() +
                                                  " " +
                                                  "events".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffA2A5AA)),
                                        ) */
                                    ),
                                  ),
                                );
                              }),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromARGB(133, 15, 14, 14),
                      child: Text(
                        "Student".tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xffF9FAFB),
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  userLoading
                      ? SizedBox(
                          height: 300.0,
                          child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                return Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 231, 224, 224),
                                  highlightColor:
                                      const Color.fromARGB(255, 92, 91, 86),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/profileblue.png"),
                                      ),
                                      title: Text(
                                        // "Alfredo Calzoni",

                                        "Loading ..",
                                        style: TextStyle(
                                            color: Color(0xffF9FAFB),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : SizedBox(
                          height: list_student.length < 2
                              ? list_student.length * 90
                              : 250,
                          child: ListView.builder(
                              itemCount: list_student.length,
                              // itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                String image = '';

                                if (list_student[index].image != null &&
                                        list_student[index]
                                            .image!
                                            .contains('http') ||
                                    list_student[index]
                                        .image!
                                        .contains('https')) {
                                  image = Uri.parse(list_student[index].image!)
                                      .toString();
                                }
                                return GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AccountChatPage(
                                                  item: list_student[index],
                                                  id: list_student[index]
                                                      .id
                                                      .toString(),
                                                )));

                                    //  ProfilePage()
                                  },
                                  child: list_student[index].userType ==
                                          "student"
                                      ? Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ListTile(
                                              leading: CircleAvatar(
                                                  backgroundImage: image != ''
                                                      ? NetworkImage(image)
                                                          as ImageProvider
                                                      : const AssetImage(
                                                          "assets/profileblue.png")),
                                              title: Text(
                                                // "Alfredo Calzoni",
                                                list_student[index].firstName !=
                                                            null ||
                                                        list_student[index]
                                                                .lastName !=
                                                            null
                                                    ? "${list_student[index]
                                                            .firstName} ${list_student[index]
                                                            .lastName}"
                                                    : "",
                                                style: const TextStyle(
                                                    color: Color(0xffF9FAFB),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                              subtitle: Text(
                                                // myFollowingList.data![index].pivot!.followId.toString()??"",
                                                list_student[index]
                                                            .eventCount ==
                                                        0
                                                    ? 'No Hosted Events'
                                                    : "${list_student[index]
                                                            .eventCount} ${"events".tr}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xffA2A5AA)),
                                              )),
                                        )
                                      : Container(),
                                );
                              }),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromARGB(133, 15, 14, 14),
                      child: Text(
                        "My Associations".tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xffF9FAFB),
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  userLoading
                      ? SizedBox(
                          height: 300.0,
                          child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                return Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 231, 224, 224),
                                  highlightColor:
                                      const Color.fromARGB(255, 92, 91, 86),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/profileblue.png"),
                                      ),
                                      title: Text(
                                        // "Alfredo Calzoni",

                                        "Loading ..",
                                        style: TextStyle(
                                            color: Color(0xffF9FAFB),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : SizedBox(
                          height: list_association.length < 2
                              ? list_association.length * 90
                              : 250,
                          child: ListView.builder(
                              itemCount: list_association.length,
                              // itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                String image = '';
                                if (list_association[index].image != null &&
                                        list_association[index]
                                            .image!
                                            .contains('http') ||
                                    list_association[index]
                                        .image!
                                        .contains('https')) {
                                  image =
                                      Uri.parse(list_association[index].image!)
                                          .toString();
                                }
                                return GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AccountChatPage(
                                                  item:
                                                      list_association[index],
                                                  id: list_association[index]
                                                      .id
                                                      .toString(),
                                                )));
                                    //  ProfilePage()
                                  },
                                  child: list_association[index].userType ==
                                          "association"
                                      ? Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ListTile(
                                              leading: CircleAvatar(
                                                  backgroundImage: image !=
                                                          'null'
                                                      ? NetworkImage(image)
                                                          as ImageProvider
                                                      : const AssetImage(
                                                          "assets/profileblue.png")),
                                              title: Text(
                                                // "Alfredo Calzoni",
                                                list_association[index]
                                                                .firstName !=
                                                            null ||
                                                        list_association[index]
                                                                .lastName !=
                                                            null
                                                    ? "${list_association[index]
                                                            .firstName} ${userslist.data![index]
                                                            .lastName}"
                                                    : "",
                                                style: const TextStyle(
                                                    color: Color(0xffF9FAFB),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                              subtitle: Text(
                                                // myFollowingList.data![index].pivot!.followId.toString()??"",
                                                list_association[index]
                                                            .eventCount ==
                                                        0
                                                    ? 'No Hosted Events'
                                                    : "${userslist.data![index]
                                                            .eventCount} ${"events".tr}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xffA2A5AA)),
                                              )),
                                        )
                                      : Container(),
                                );
                              }),
                        ),
                  userLoading
                      ? SizedBox(
                          height: 300.0,
                          child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                return Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 231, 224, 224),
                                  highlightColor:
                                      const Color.fromARGB(255, 92, 91, 86),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/profileblue.png"),
                                      ),
                                      title: Text(
                                        // "Alfredo Calzoni",

                                        "Loading ..",
                                        style: TextStyle(
                                            color: Color(0xffF9FAFB),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width,
                            color: const Color.fromARGB(133, 15, 14, 14),
                            child: Text(
                              "My Professionals".tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Color(0xffF9FAFB),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: list_busniss.length < 2
                        ? list_busniss.length * 90
                        : 250,
                    child: ListView.builder(
                        itemCount: list_busniss.length,
                        // itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          String image = '';
                          if (list_busniss[index].image != null &&
                                  list_busniss[index].image!.contains('http') ||
                              list_busniss[index].image!.contains('https')) {
                            image = Uri.parse(list_busniss[index].image!)
                                .toString();
                          }

                          // String hostedevents = '';
                          // if (hostedEventsOfotherUser != null && hostedEventsOfotherUser.data != null) {
                          //   int index = 0; // You should replace this with the appropriate index value
                          //
                          //   if (hostedEventsOfotherUser.data![index] != null && hostedEventsOfotherUser.data![index].id != null) {
                          //     String idAsString = hostedEventsOfotherUser.data![index].id.toString();
                          //
                          //     if (userslist != null && userslist.data != null && userslist.data![index] != null && userslist.data![index].id != null) {
                          //       String usersListIdAsString = userslist.data![index].id.toString();
                          //
                          //       if (idAsString.contains(usersListIdAsString)) {
                          //         hostedevents = hostedEventsOfotherUser.count.toString();
                          //       }
                          //     }
                          //   }
                          // }
                          // print("hoste"+hostedevents.toString());
                          return GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AccountChatPage(
                                            item: list_busniss[index],
                                            id: list_busniss[index]
                                                .id
                                                .toString(),
                                          )));

                              //  ProfilePage()
                            },
                            child: list_busniss[index].userType == "business"
                                ? Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ListTile(
                                        leading: CircleAvatar(
                                            backgroundImage: image != ''
                                                ? NetworkImage(image)
                                                    as ImageProvider
                                                : const AssetImage(
                                                    "assets/profileblue.png")),
                                        title: Text(
                                          // "Alfredo Calzoni",
                                          list_busniss[index].firstName !=
                                                      null ||
                                                  list_busniss[index]
                                                          .lastName !=
                                                      null
                                              ? "${list_busniss[index]
                                                      .firstName} ${userslist
                                                      .data![index].lastName}"
                                              : "",
                                          style: const TextStyle(
                                              color: Color(0xffF9FAFB),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        subtitle: Text(
                                          // hostedevents==0?"N/A":hostedevents,
                                          // myFollowingList.data![index].pivot!.followId.toString()??"",
                                          hostedEventsOfotherUser.count == 0
                                              ? 'No Hosted Events'
                                              : "${hostedEventsOfotherUser.count} ${"events".tr}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffA2A5AA)),
                                        )),
                                  )
                                : Container(),
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
