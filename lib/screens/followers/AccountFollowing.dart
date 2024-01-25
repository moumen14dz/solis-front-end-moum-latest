import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/showtoast.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/UsersListModel.dart';

class AccountsFollowingPage extends StatefulWidget {
  int? id;
  Users? item;
  AccountsFollowingPage({super.key, this.id,this.item});

  @override
  State<AccountsFollowingPage> createState() => _AccountsFollowingPageState();
}

class _AccountsFollowingPageState extends State<AccountsFollowingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshPage();
  }
  refreshPage()async {
    await APIRequests().getMyFollowingList1(widget.id.toString());
    AccountsFollowingPage();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Following".tr,
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
                    hintText: "Search Chat",
                    hintStyle:
                    TextStyle(color: const Color(0xffFFFFFF).withOpacity(.3))),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: ListView.builder(
                itemCount: myFollowingList1.data != null
                    ? myFollowingList1.data!.length
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      leading: const CircleAvatar(
                          backgroundImage: AssetImage("assets/Image.png")),
                      title: Text(
                        '${myFollowingList1.data![index].firstName} ${myFollowingList1.data![index].lastName}',
                        style: const TextStyle(
                            color: Color(0xffF9FAFB),
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      subtitle: Text(
                        myFollowingList1.data![index].id.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xffA2A5AA)),
                      ),
                      trailing: SizedBox(
                          height: 32,
                          width: 112,
                          child: SaveButton(
                              title: "UnFollow",
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
                                  await APIRequests().followOrUnfollowAccount(
                                      false,
                                      myId.toString(),
                                      myFollowingList1.data![index].id
                                          .toString(),
                                      setState(() {}));
                                  await await APIRequests()
                                      .getMyFollowingList1(myId.toString());
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
