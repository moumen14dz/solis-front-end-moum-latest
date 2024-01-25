import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickAVideo() async {
  var pickedimage = await ImagePicker().pickVideo(source: ImageSource.gallery);
  if (pickedimage != null) {
    var profilePicture = File(pickedimage.path);
    return profilePicture;
  }
  return null;
}

Future<File?> pickAImage() async {
  var pickedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedimage != null) {
    var profilePicture = File(pickedimage.path);
    return profilePicture;
  }
  return null;
}
