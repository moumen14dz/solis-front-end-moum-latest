import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/common/constant.dart';
import 'package:newproject/model/myFollowingListMidel.dart';
import 'package:newproject/resources/button_factory.dart';
import 'package:newproject/screens/account/edit_profile.dart';
import 'package:newproject/utils/controllers.dart';

import '../utils/start_activity.dart';

class EditProfileStackWidget extends StatefulWidget {
  DataFollowing? item;
  int? id;
  EditProfileStackWidget({super.key, this.item, this.id});

  @override
  State<EditProfileStackWidget> createState() => EditProfileStackWidgetState();
}

class EditProfileStackWidgetState extends State<EditProfileStackWidget> {
  @override
  Widget build(BuildContext context) {
    String image = '';
    String coverImager = '';
    try {
      if (userProfileDetails.data!.user!.coverImage != null &&
              userProfileDetails.data!.user!.coverImage!.contains('http') ||
          userProfileDetails.data!.user!.coverImage!.contains('https')) {
        coverImager =
            Uri.parse(userProfileDetails.data!.user!.coverImage!).toString();
      }
      if (userProfileDetails.data!.user!.image != null &&
              userProfileDetails.data!.user!.image!.contains('http') ||
          userProfileDetails.data!.user!.image!.contains('https')) {
        image = Uri.parse(userProfileDetails.data!.user!.image!).toString();
      }
    } catch (e) {
      image = '';
      coverImager = '';
    }
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          coverImager == ''
              ? Image.asset(
                  "assets/bg.png",
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  userProfileDetails.data!.user!.coverImage!,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
          widget.id != userId
              ? const SizedBox.shrink()
              : Positioned(
                  top: 5,
                  right: 0,
                  child: Container(
                    height: 52,
                    width: 150,
                    margin: const EdgeInsets.only(right: 15),
                    child: ButtonFactory().showTextBtn(
                        title: "Edit Profile".tr,
                        titleColor: Colors.white,
                        context: context,
                        boarderColor: const Color(0xffB0CAFF),
                        backgroundColor: Colors.black,
                        boarderThickness: 1.0,
                        textSize: 14,
                        isEnabled: true,
                        onButtonPressed: () {
                          StartActivity().start(context, const EditProfile());
                        }),
                  ),
                ),
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width * 0.5 -
                60, // To center the CircleAvatar

            child: Center(
                child: CachedNetworkImage(
                    imageUrl: userProfileDetails.data!.user!.image!,
                    imageBuilder: (context, imageProvider) => Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //      borderRadius:
                            //        const BorderRadius.all(Radius.circular(30)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              // colorFilter: ColorFilter.mode(
                              //   Colors.red, BlendMode.colorBurn)
                            ),
                          ),
                        ),
                    placeholder: (context, url) => Container(
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            //      borderRadius:
                            //        const BorderRadius.all(Radius.circular(30)),
                            image: DecorationImage(
                                image: AssetImage(
                              "assets/user.jpg",
                            )))),
                    errorWidget: (context, url, error) => Container(
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            //      borderRadius:
                            //        const BorderRadius.all(Radius.circular(30)),
                            image: DecorationImage(
                                image: AssetImage(
                              "assets/user.jpg",
                            )))))),
          ),
        ],
      ),
    );
  }
}
