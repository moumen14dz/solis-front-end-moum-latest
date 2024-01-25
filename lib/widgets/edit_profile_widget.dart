
import 'package:flutter/material.dart';
import 'package:newproject/screens/account/edit_profile_image.dart';
import 'package:newproject/utils/controllers.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => EditProfileWidgetState();
}

class EditProfileWidgetState extends State<EditProfileWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }

  refresh() async {
    // editImage =
    //     await userProfileDetails.data!.user!.image ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const EditProfileImage())).then((_) {
                setState(() {});
              });
            },
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
          )
        ],
      ),
    );
  }
}
// backgroundImage: userProfileDetails.data!.user!.image !=
// null
// ? NetworkImage(userProfileDetails.data!.user!.image!)
//     : editImage != null
// ? FileImage(editImage!)
//     : const AssetImage("assets/Image.png")
// as ImageProvider)),