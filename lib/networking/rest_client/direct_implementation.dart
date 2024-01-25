import 'dart:convert';
import 'dart:developer';

import 'package:newproject/common/constant.dart';
import 'package:newproject/model/loginResponse.dart';
import 'package:newproject/utils/controllers.dart';

import '../../model/log_in_model.dart';
import '../../utils/handler/network_response_handler.dart';
import 'package:http/http.dart' as http;

class ImplementRestClient {
  Future<NetworkResponseHandler<LoginResponseModel>> attemptLogIn({
    required String email,
    required String password,
    String? device_token,
  }) async {
    log("ff");

    final request =
        http.MultipartRequest('POST', Uri.parse("${universalBaseUrl}login"));
    //request.headers['Authorization'] = 'Bearer ${await getToken()}';

    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['device_token'] = device_token!;
    final response = await http.Response.fromStream(await request.send());
    log(response.body.toString());
    log(response.body[0]);

    log(jsonEncode(response.body));

    // log(jsonDecode(response.body.toString()));
    try {
      final jsonResponse = jsonDecode(response.body);
      final signInModel = LoginResponseModel.fromJson(jsonResponse);

      if (signInModel.code == 200) {
        loginResponseModel = LoginResponse.fromJson(jsonDecode(response.body));
        userToken = loginResponseModel.data!.token!;
        return NetworkResponseHandler(
          isSuccess: true,
          data: signInModel,
        );
      } else {
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: signInModel.message ?? 'Unknown error',
        );
      }
    } catch (e) {
      return NetworkResponseHandler(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
}



// import 'dart:convert';
//
// import 'package:newproject/common/constant.dart';
// import 'package:newproject/model/loginResponse.dart';
// import 'package:newproject/utils/controllers.dart';
//
// import '../../model/log_in_model.dart';
// import '../../utils/handler/network_response_handler.dart';
// import 'package:http/http.dart' as http;
//
// class ImplementRestClient {
//   Future<NetworkResponseHandler<LoginResponseModel>> attemptLogIn({
//     required String email,
//     required String password,
//      String? device_token,
//   }) async {
//     final request =
//         http.MultipartRequest('POST', Uri.parse("${universalBaseUrl}login"));
//     //request.headers['Authorization'] = 'Bearer ${await getToken()}';
//
//     request.fields['email'] = email;
//     request.fields['password'] = password;
//     request.fields['device_token']= device_token!;
//     final response = await http.Response.fromStream(await request.send());
//
//     try {
//       final jsonResponse = jsonDecode(response.body);
//       final signInModel = LoginResponseModel.fromJson(jsonResponse);
//
//       if (signInModel.code == 200) {
//         loginResponseModel = LoginResponse.fromJson(jsonDecode(response.body));
//         userToken = loginResponseModel.data!.token!;
//         return NetworkResponseHandler(
//           isSuccess: true,
//           data: signInModel,
//         );
//       } else {
//         return NetworkResponseHandler(
//           isSuccess: false,
//           errorMessage: signInModel.message ?? 'Unknown error',
//         );
//       }
//     } catch (e) {
//       return NetworkResponseHandler(
//         isSuccess: false,
//         errorMessage: e.toString(),
//       );
//     }
//   }
// }
