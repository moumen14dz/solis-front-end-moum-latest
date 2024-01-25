import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/showtoast.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/UsersListModel.dart';

class AccountFolowersPage extends StatefulWidget {
  int? id;
  int? index;
  Users? item;
  AccountFolowersPage({super.key, this.id,this.item,this.index});

  @override
  State<AccountFolowersPage> createState() => _AccountFolowersPageState();
}

class _AccountFolowersPageState extends State<AccountFolowersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshPage();
  }
  refreshPage()async{

    await APIRequests().getMyFollowersList1(widget.id.toString());
    AccountFolowersPage();
    setState(() {
    });
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
                    hintStyle:
                    TextStyle(color: const Color(0xffFFFFFF).withOpacity(.3))),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: ListView.builder(
                itemCount: myFollowersList1.data != null
                    ? myFollowersList1.data!.length
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  bool canFollow = true;
                  try {
                    if (myFollowingList1.data != null) {
                      for (var i in myFollowingList1.data!) {
                        if (i.id == myFollowersList1.data![index].id) {
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
                        '${myFollowersList1.data![index].firstName} ${myFollowersList1.data![index].lastName}',
                        style: const TextStyle(
                            color: Color(0xffF9FAFB),
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      subtitle: Text(
                        myFollowersList1.data![index].id.toString(),
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
                                //True For Follow False For Un Follow
                                // My Id and Corresponding User ID will be updated later when User Data Provider is initiated
                                if (loader == false) {
                                  setState(() {
                                    loader = true;
                                  });
                                  if (canFollow) {
                                    await APIRequests().followOrUnfollowAccount(
                                        true,
                                        myId.toString(),
                                        myFollowersList1.data![index].id
                                            .toString(),
                                        setState(() {}));
                                  } else {
                                    await APIRequests().followOrUnfollowAccount(
                                        false,
                                        myId.toString(),
                                        myFollowersList1.data![index].id
                                            .toString(),
                                        setState(() {}));
                                  }
                                  await APIRequests()
                                      .getMyFollowersList1(myId.toString());
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

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getFollowerlist();
//   }
//   getFollowerlist()async{
//     await APIRequests().getMyFollowersList1(widget.id.toString());
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         title: Text(
//           "Followers",
//           style: TextStyle(color: textColor),
//         ),
//         backgroundColor: mainColor,
//       ),
//       backgroundColor: mainColor,
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
//               child: TextFormField(
//                 style: TextStyle(color: Colors.white, fontSize: 14),
//                 decoration: InputDecoration(
//                     filled: true,
//                     fillColor: mainColor,
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(6),
//
//                       borderSide: BorderSide(color: mainTextFormColor),
// //<-- SEE HERE
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: mainTextFormColor),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     disabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: mainTextFormColor),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: mainTextFormColor),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: mainTextFormColor),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     border: InputBorder.none,
//                     prefixIcon: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Image.asset(
//                         "assets/search-01.png",
//                         height: 12,
//                       ),
//                     ),
//                     hintText: "Search Chat",
//                     hintStyle:
//                     TextStyle(color: Color(0xffFFFFFF).withOpacity(.3))),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height / 1.5,
//             child: ListView.builder(
//                 itemCount: myFollowersList1.data != null
//                     ? myFollowersList1.data!.length
//                     : 0,
//                 itemBuilder: (BuildContext context, int index) {
//                   bool canFollow = true;
//                   try {
//                     if (myFollowingList1.data != null) {
//                       for (var i in myFollowingList1.data!) {
//                         if (i.id == myFollowersList1.data![index].id) {
//                           canFollow = false;
//                         }
//                       }
//                     }
//                   } catch (e) {}
//                   return Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                           backgroundImage: AssetImage("assets/Image.png")),
//                       title: Text(
//                         '${myFollowersList1.data![index].firstName} ${myFollowersList1.data![index].lastName}',
//                         style: TextStyle(
//                             color: Color(0xffF9FAFB),
//                             fontWeight: FontWeight.w600,
//                             fontSize: 18),
//                       ),
//                       subtitle: Text(
//                         myFollowersList1.data![index].pivot!.userId.toString(),
//                         style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xffA2A5AA)),
//                       ),
//                       trailing: Container(
//                           height: 32,
//                           width: 112,
//                           child: SaveButton(
//                               title: canFollow ? "Follow".tr : 'Unfollow'.tr,
//                               onTap: () async {
//                                 SharedPreferences userpref =
//                                 await SharedPreferences.getInstance();
//                                 var myId = userpref.getInt("userId");
//                                 //True For Follow False For Un Follow
//                                 // My Id and Corresponding User ID will be updated later when User Data Provider is initiated
//                                 if (loader == false) {
//                                   setState(() {
//                                     loader = true;
//                                   });
//                                   if (canFollow) {
//                                     await APIRequests().followOrUnfollowAccount(
//                                         true,
//                                         myId.toString(),
//                                         widget.id
//                                             .toString(),
//                                         setState(() {}));
//                                   } else {
//                                     await APIRequests().followOrUnfollowAccount(
//                                         false,
//                                         myId.toString(),
//                                         widget.id
//                                             .toString(),
//                                         setState(() {}));
//                                   }
//                                   await APIRequests()
//                                       .getMyFollowersList1(myId.toString());
//                                   setState(() {});
//                                 } else {
//                                   await showToasterror('Loading!');
//                                 }
//                               })),
//                     ),
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }
