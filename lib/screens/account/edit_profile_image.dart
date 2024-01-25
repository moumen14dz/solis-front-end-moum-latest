import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/networking/repository/image_picker_controller.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';

import 'package:newproject/utils/showtoast.dart';

class EditProfileImage extends StatefulWidget {
  const EditProfileImage({super.key});

  @override
  State<EditProfileImage> createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: textColor),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Update Image".tr,
            style: const TextStyle(color: textColor),
          ),
        ),
        backgroundColor: mainColor,
      ),
      backgroundColor: mainColor,
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                editBackgrondImage != null
                    ? Image.file(
                        editBackgrondImage!,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/bg.png",
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                InkWell(
                  child: Container(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                            radius: 60,
                            backgroundImage: editImage != null
                                ? FileImage(editImage!)
                                : const AssetImage("assets/Image.png")
                                    as ImageProvider)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "CUSTOMIZE YOUR PROFILE".tr,
            style: const TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Add the images you want to personalize \nyour profile.",
            style: TextStyle(
                color: Colors.white.withOpacity(.6),
                fontWeight: FontWeight.w400,
                fontSize: 15),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          SaveButton(
              title: "Upload new profile image".tr,
              onTap: () async {
                editImage = await pickAImage();
                if (editImage != null) {
                  setState(() {});
                } else {
                  await showToasterror('Error Picking Image!');
                }
              }),
          const SizedBox(
            height: 15,
          ),
          SaveButton(
              title: "Upload new background image".tr,
              onTap: () async {
                editBackgrondImage = await pickAImage();
                if (editBackgrondImage != null) {
                  setState(() {});
                } else {
                  await showToasterror('Error Picking Image!');
                }
              })
        ],
      ),
    );
  }
}
