import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

String studentAccountCreateTitleString = "You are a student".tr;
String associationAccountCreateTitleString = "You are an association".tr;
String businessAccountCreateTitleString = "You are a business".tr;

const String universalBaseUrl = "http://piptestnet.com/api/";
String userToken = '';
int userId = 0;
int programId = 0;
getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  userToken = pref.getString("token")!;
  return userToken;
}

getUserId() async {
  SharedPreferences userpref = await SharedPreferences.getInstance();
  userId = userpref.getInt("userId")!;
  return userId;
}

getProgramId() async {
  SharedPreferences programPref = await SharedPreferences.getInstance();
  programId = programPref.getInt("programId")!;
  return programId;
}

enum ApiResponseStatusEnum { failure, success }

const String authTokenIdentifier = "AUTH_TOKEN";

enum UserTypeEnum { student, assosication, business }

String dummyToken =
    "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vcGlwdGVzdG5ldC5jb20vYXBpL2xvZ2luIiwiaWF0IjoxNjk3NTU1MDg1LCJleHAiOjE2OTc1NTg2ODUsIm5iZiI6MTY5NzU1NTA4NSwianRpIjoienRLb0k1bU9WQmJ4RmdwcSIsInN1YiI6IjQ4IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.oUuldYfBJ5Omx_-QpRpDOK0HrzgkJ_SGGjQ7QFLxers";
