import 'package:shared_preferences/shared_preferences.dart';

getToken ()async{
  String? token;
  final SharedPreferences pref = await SharedPreferences.getInstance();
  token = pref.getString("token");
  return;
}