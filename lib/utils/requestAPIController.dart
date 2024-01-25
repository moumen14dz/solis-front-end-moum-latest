import 'dart:convert';
import 'dart:math';
import 'dart:developer' as log;
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:newproject/common/constant.dart';
import 'package:newproject/model/UsersListModel.dart';
import 'package:newproject/model/chatmessageModel.dart';
import 'package:newproject/model/eventsOfCurrentWeek.dart';
import 'package:newproject/model/getCategories.dart';
import 'package:newproject/model/getCountries.dart';
import 'package:newproject/model/getEventDetails.dart';
import 'package:newproject/model/listOfUniversitiesModel.dart';
import 'package:newproject/model/loginResponse.dart';
import 'package:newproject/model/myFollowingListMidel.dart';
import 'package:newproject/model/userProfileDetails.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/AccountFollowingListModel.dart';
import '../model/getEventswithFilters.dart';
import '../model/getHostedEvent.dart';
import '../model/message_response_model.dart';

class APIRequests {
  reportAAcc(String name, String eventName, String issue, String description,
      String reportedPersonId) async {
    try {
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $userToken'
      };
      var data = {
        'reported_by': userId,
        'account_name': name,
        'event': eventName,
        'nature_of_problem': issue,
        'description': description,
        'account_id': reportedPersonId
      };
      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/report-account',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        if (response.data['code'] == 200) {
          showToasterror('Reported Successfully!');
        }
      } else {
        showToasterror('Something Went Wrong Try Again!');
      }
    } catch (e) {
      showToasterror('Something Went Wrong Try Again!');
    }
  }

  getCategoriesOfEvents() async {
    try {
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'x-Localization': sharedPrefs.getBool('language') ?? false ? 'fr' : 'en'
      };
      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/categories',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['code'] == 200) {
          getCategories = GetCategories.fromJson(response.data);
          getCtaegoriesDataAfterSearch = getCategories.data!;
        }
      } else {
        await getCategoriesOfEvents();
        return;
      }
    } catch (e) {
      print(e);
      await getCategoriesOfEvents();
      return;
    }
  }

  sendRequest() async {
    List<int> imageBytes = [];
    List<int> imageBytes1 = [];

    log.log("edittt${editProfileUserNameController.text}");
    if (editImage != null) {
      imageBytes = await editImage!.readAsBytes();
    }
    String base64Image = base64Encode(imageBytes);
    if (editBackgrondImage != null) {
      imageBytes1 = await editBackgrondImage!.readAsBytes();
    }
    String base64Image1 = base64Encode(imageBytes1);

    try {
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'x-Localization':
            sharedPrefs.getBool('language') ?? false ? 'fr' : 'en',
        'Authorization': 'Bearer $userToken'
      };
      //Bearer Token To Be Of Current Users Needs To Be Updted Later On
      var data = FormData.fromMap({
        // editImage == null && editBackgrondImage == null ? '' : 'files': [
        //   editImage == null
        //       ? ''
        //       : await MultipartFile.fromFile(editImage!.path,
        //           filename: '${editImage!.path.split('.').first}/image.png'),
        //   editBackgrondImage == null
        //       ? ''
        //       : await MultipartFile.fromFile(editBackgrondImage!.path,
        //           filename:
        //               '${editBackgrondImage!.path.split('.').first}/cover_image.jpg')
        // ],

        'image': editImage == null ? '' : base64Image,
        // : await MultipartFile.fromFile(editImage!.path,
        //     filename: '${editImage!.path.split('.').first}/image.png'),
        'cover_image': editBackgrondImage == null ? '' : base64Image1,
        // : await MultipartFile.fromFile(editBackgrondImage!.path,
        //     filename:
        //         '${editBackgrondImage!.path.split('.').first}/cover_image.jpg'),
        'username': editProfileUserNameController.text,
        'email': editProfileEmailController.text,
        'phone': editProfilePhoneController.text,
        'first_name': editFirstNameController.text,
        'last_name': editLastNameController.text,
        'phone': editProfilePhoneController.text,
        'bio': editDescriptioncController.text,
        'id': '76576576'
      });

      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/profile',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.data);
      return response;
    } catch (e) {
      return e;
    }
  }

  eventsOfCurrentWeek({required String token}) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/events?time_check=2&search=&X-localization=${sharedPrefs.getBool('language') ?? false ? 'fr' : 'en'}',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['code'] == 200) {
          getEventsOfCurrentWeek =
              GetEventsOfCurrentWeek.fromJson(response.data);
        } else {
          await eventsOfCurrentWeek(token: token);
        }
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
      await eventsOfCurrentWeek(token: token);
    }
  }

  allFutureEvents({required String token}) async {
    print("APP_ERROR: 100");
    // String userToken1 ="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vcGlwdGVzdG5ldC5jb20vYXBpL2xvZ2luIiwiaWF0IjoxNjk2NjEwOTM2LCJleHAiOjE2OTY2MTQ1MzYsIm5iZiI6MTY5NjYxMDkzNiwianRpIjoiN1RqcTR3Q2FDZkdRZXRwQiIsInN1YiI6IjQ2IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.AEruVoQegRTGkH9RJ79bDJROQWaO3KKWQ15nToG3rzQ";
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    try {
      print("APP_ERROR: 200");
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/events?tsearch=&X-localization=${sharedPrefs.getBool('language') ?? false ? 'fr' : 'en'}',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      print("APP_ERROR: 300");
      print("object$response");
      if (response.statusCode == 200) {
        print("APP_ERROR: 400");
        print("object1${response.statusCode}");
        if (response.data['code'] == 200) {
          print("APP_ERROR: 500");
          log.log("object2${response.data}");
          try {
            allFutureEventsList =
                GetEventsOfCurrentWeek.fromJson(response.data);
          } catch (e) {
            log.log("eee${e.toString()}");
          }
          // eventsNearByMeOnly.code = allFutureEventsList.code;
          // eventsNearByMeOnly.count = allFutureEventsList.count;
          // eventsNearByMeOnly.message = allFutureEventsList.message;
        } else {
          print("APP_ERROR: 600");
          await eventsOfCurrentWeek(token: token);
        }
      } else {
        print("APP_ERROR: 700");
        print(response.statusMessage);
      }
    } catch (e) {
      print("APP_ERROR: 800: ${e.toString()}");
      print(e);
      await eventsOfCurrentWeek(token: token);
    }
  }

  getAllUniversities() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    try {
      var headers = {
        'Content-Type': 'application/json',
        'x-Localization': sharedPrefs.getBool('language') ?? false ? 'fr' : 'en'
      };
      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/universities',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print('Universities');
        print(response.data);
        print(response.statusMessage);
        if (response.data['code'] == 200) {
          listOfUniversitiesModel = ListOfUniversities.fromJson(response.data);
        } else {
          await getAllUniversities();
        }
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
      await getAllUniversities();
    }
  }

  followOrUnfollowUser(
      bool follow, String myID, String correspondingUserID) async {
    log.log("response response");
    log.log("response $myID");
    log.log("response $correspondingUserID");
    log.log("response $follow");
    log.log("response Bearer$userToken");

    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'x-Localization': sharedPrefs.getBool('language') ?? false ? 'fr' : 'en',
      'Authorization': 'Bearer $userToken'
    };
    var data = {
      'user_id': correspondingUserID,
      'status': follow ? 1 : 0,
      'login_id': myID
    };

    log.log("response $data");

    var dio = Dio();
    var response = await dio.request(
      'http://piptestnet.com/api/follow-unfollow-user',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    log.log("response $response");

    return response;
  }

  getEventsWithFilters(
      int categoryID, int whatTime, String search, void setState) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken'
      };
      print(categoryID);

      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/events?category_id=$categoryID&time_check=$whatTime&search=$search&X-localization=${sharedPrefs.getBool('language') ?? false ? 'fr' : 'en'}',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      print(response.statusCode);
      log.log(response.data.toString());
      print(response.statusMessage);

      if (response.statusCode == 200) {
        if (response.data['code'] == 200) {
          getEventsWithFiltersModel =
              GetEventWithFilters.fromJson(response.data);
          getEventsWithFiltersModelAfterSearch = getEventsWithFiltersModel.data;
        } else {
          await getEventsWithFilters(categoryID, whatTime, search, setState);
          return;
        }
        setState;
      } else {
        print(response.statusMessage);
      }
      setState;
    } catch (e) {
      print(e);
      await showToasterror('Something Went Wrong While Fetching Events!');
      await showToasterror('Please Try Again!');
    }
  }

  getUserProfileDetails({required String token}) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var dio = Dio();
      dio.options.followRedirects = true;
      var response = await dio.request(
        'http://piptestnet.com/api/profile',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['code'] == 200) {
          userProfileDetails = UserProfileDetails.fromJson(response.data);
        } else {
          await getUserProfileDetails(token: token);
        }
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
      await getUserProfileDetails(token: token);
    }
  }

  followOrUnfollowAUser(
      bool follow, String myID, String correspondingUserID, void setState,
      {required String token}) async {
    await showToasterrorLongLength('Loading!');
    try {
      var response = await APIRequests()
          .followOrUnfollowUser(follow, myID, correspondingUserID);
      //log.log(response);

      if (response.statusCode == 200) {
        //  log.log(response.data.toString());
        if (response.data['code'] == 422) {
          // if (response.data['message'] == 'Validation error') {
          //   await showToasterror('Some Fields Are Missing. Please Try Again!');
          // } else {}
          await showToasterror('Something Went Wrong. Please Try Again!');
          //  print(response.data.toString());
        } else if (response.data['code'] == 200) {
          log.log("ffff");
          follow
              ? await showToasterror('Followed Successfully!')
              : await showToasterror('Unfollowed Successfully!');
          //print(response.data.toString());
        }
      } else {
        await showToasterror('Error Please Try Again!');
      }
      loader = !loader;
      await getMyFollowersList(myID, token: token);
      // await getMyFollowingList(
      //     myID); //TO UPDATE FOLLOWING AND FOLLOWERS LIST AFTER FOLLOW UNFOLLOW
      setState;
    } catch (e) {
      log.log(e.toString());
      await showToasterror('Error Please Try Agadddddddin!');
      loader = !loader;
    }
  }

  followOrUnfollowAccount(bool follow, String myID, String correspondingUserID,
      void setState) async {
    await showToasterrorLongLength('Loading!');
    try {
      var response = await APIRequests()
          .followOrUnfollowUser(follow, myID, correspondingUserID);
      if (response.statusCode == 200) {
        if (response.data['code'] == 422) {
          // if (response.data['message'] == 'Validation error') {
          //   await showToasterror('Some Fields Are Missing. Please Try Again!');
          // } else {}
          await showToasterror('Something Went Wrong. Please Try Again!');
          print(response.data.toString());
        } else if (response.data['code'] == 200) {
          follow
              ? await showToasterror('Followed Successfully!')
              : await showToasterror('Unfollowed Successfully!');
          print(response.data.toString());
          // return follow;
        }
      } else {
        await showToasterror('Error Please Try Again!');
      }
      loader = !loader;
      await getMyFollowersList1(myID);
      await getMyFollowingList1(
          myID); //TO UPDATE FOLLOWING AND FOLLOWERS LIST AFTER FOLLOW UNFOLLOW
      setState;
    } catch (e) {
      await showToasterror('Error Please Try Again!');
      loader = !loader;
      setState;
    }
  }

  logout() async {
    print("logout");
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken'
      };
      print(userToken is String);
      print(userToken is Map);
      print("headers$headers");
      print("token$userToken");
      print("logout12");
      var dio = Dio();
      print("logout125");
      // var res = Uri.parse(uri);
      var response = await dio.request(
        'http://piptestnet.com/api/logout',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );
      print(headers is String);
      print(headers is Map);

      print("resq$response");
      print("resq${response.statusMessage}");
      if (response.statusCode == 200) {
        print("logout");
        if (response.data['code'] == 200) {
          print("logout");
          await showToasterror('Logged Out Successfully!');
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      await showToasterror('Something went wrong!');
      print(e);
      return false;
    }
  }

  deleteAcount() async {
    print("delete");
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken'
      };
      print(userToken is String);
      print(userToken is Map);
      print("headers$headers");
      print("token$userToken");
      print("logout12");
      var dio = Dio();
      print("logout125");
      // var res = Uri.parse(uri);
      var response = await dio.request(
        'http://piptestnet.com/api/delete',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );
      print(headers is String);
      print(headers is Map);

      print("resqdelete$response");
      print("resqdelete${response.statusMessage}");
      if (response.statusCode == 200) {
        print("logout");
        if (response.data['code'] == 200) {
          print("logout");
          await showToasterror('Account Deleted Successfully!');
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      await showToasterror('Something went wrong!');
      print(e);
      return false;
    }
  }

  getMyFollowingList(String myUserID, {required String token}) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $userToken'
    };
    var data = {'user_id': myUserID};
    var dio = Dio();
    var response = await dio.request(
      'http://piptestnet.com/api/followings',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data['code'] == 200) {
        print(response.statusMessage);
        myFollowingList = MyFollowingList.fromJson(response.data);
        getFollowingListSearch = myFollowingList.data;
        print(myFollowingList.count);
      } else if (response.data['code'] == 200 &&
          response.data['message'] == 'Unauthorized Access!') {
        getMyFollowingList(myUserID, token: token);
        return;
      }
    } else {
      print(response.statusMessage);
    }
  }

  getUsersList() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer$userToken'
    };
    log.log("Bearer$userToken");
    // var data = {'user_id': myUserID};
    var dio = Dio();
    var response = await dio.request(
      'http://piptestnet.com/api/user_list',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      // data: data,
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.data['code'] == 200) {
        userslist = UsersListModel.fromJson(response.data);
        getUserListSearch = userslist.data;
        print("test${userslist.data}");
      } else {
        await getUsersList();
      }
    } else {
      print(response.statusMessage);
    }
  }

  getMyFollowingList1(String mypivotID) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $userToken'
    };
    var data = {'user_id': mypivotID};
    var dio = Dio();
    var response = await dio.request(
      'http://piptestnet.com/api/followings',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data['code'] == 200) {
        print(response.statusMessage);
        myFollowingList1 = AccountFollowingList.fromJson(response.data);
        getAccFollowingListSearch = myFollowingList1.data;
        print(myFollowingList1.count);
      } else if (response.data['code'] == 200 &&
          response.data['message'] == 'Unauthorized Access!') {
        getMyFollowingList1(mypivotID);
        return;
      }
    } else {
      print(response.statusMessage);
    }
  }

  getMyFollowersList1(String myUserID) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $userToken'
    };
    var data = {'user_id': myUserID};
    var dio = Dio();
    var response = await dio.request(
      'http://piptestnet.com/api/followers',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data['code'] == 200) {
        print(response.statusMessage);
        myFollowersList1 = MyFollowingList.fromJson(response.data);
        getFollowerListSearch = myFollowersList1.data;
        print(myFollowingList.count);
      } else if (response.data['code'] == 200 &&
          response.data['message'] == 'Unauthorized Access!') {
        getMyFollowingList1(myUserID);
        return;
      }
    } else {
      print(response.statusMessage);
    }
  }

  getMyFollowersList(String myUserID, {required String token}) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $userToken'
    };
    var data = {'user_id': myUserID};
    var dio = Dio();
    var response = await dio.request(
      'http://piptestnet.com/api/followers',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    print(response.statusCode);
    log.log(response.data.toString());

    if (response.statusCode == 200) {
      print(response.data);
      if (response.data['code'] == 200) {
        print(response.statusMessage);
        myFollowersList = MyFollowingList.fromJson(response.data);
        getFollowerListSearch = myFollowersList.data;
        print(myFollowingList.count);
      } else if (response.data['code'] == 200 &&
          response.data['message'] == 'Unauthorized Access!') {
        getMyFollowingList(myUserID, token: token);
        return;
      }
    } else {
      print(response.statusMessage);
    }
  }

  getCountriesFromAPICall() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/countries',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      print('API CALLEDDDDDDDDDDDD');
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.data['code'] == 200) {
          getCountriesFromAPI = GetCountriesFromAPI.fromJson(response.data);
        } else {
          getCountriesFromAPICall();
          return;
        }
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error : $e');
      getCountriesFromAPICall();
      return;
    }
  }

  contactUsApi(String msg) async {
    try {
      var headers = {'Authorization': 'Bearer $userToken'};
      var data = FormData.fromMap({'message': msg});
      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/contact-us',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        if (response.data['code'] == 200) {
          await showToasterror(
              'Your Request Has Been Received Successfully. We Will Get Back To You Soon!');
        } else {
          await showToasterror('Something Went Wrong Please Try Again!');
        }
      } else {
        print(response.statusMessage);
        await showToasterror('Something Went Wrong Please Try Again!');
      }
    } catch (e) {
      print(e);
      await showToasterror('Something Went Wrong Please Try Again!');
      return;
    }
  }

  login(String email, String password) async {
    SharedPreferences sharedPrefss = await SharedPreferences.getInstance();
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = FormData.fromMap({'email': email, 'password': password});

      var dio = Dio();
      log.log("data${data.fields}");
      var response = await dio.request(
        'http://piptestnet.com/api/login',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(response.data['code']);
        print(response.data);
        if (response.data['code'] == 200) {
          loginResponseModel = LoginResponse.fromJson(response.data);
          print(email);
          print(password);
          await sharedPrefss.setString('email', email);
          await sharedPrefss.setString('password', password);

          print(response.data['data']['token']);
          print(loginResponseModel.data!.token!);
          if (loginResponseModel.data != null) {
            userToken = loginResponseModel.data!.token!;
            userId = loginResponseModel.data!.user!.id!;
          }
          print('USER TOKEENNNNNNNNNNNN $userToken');
          SharedPreferences userpref = await SharedPreferences.getInstance();
          userpref ??= await SharedPreferences.getInstance();
          userpref.setString(authTokenIdentifier, userToken);

          return true;
        } else {
          await showToasterror(response.data['message']);

          // 'Invalid Credentials');
          return false;
        }
      } else {
        await showToasterror('Something Went Wrong Please Try Again!');
        return false;
      }
    } catch (e) {
      print(e);
      await showToasterror('Something Went Wrong Please Try Again!');
      return false;
    }
  }

  getHostedEventsOfUser({required String token}) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/events/hosted-events',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['code'] == 200) {
          hostedEventsOfUser = HostedEventsOfUser.fromJson(response.data);
        } else {
          await getHostedEventsOfUser(token: token);
          return;
        }
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      await getHostedEventsOfUser(token: token);
      return;
    }
  }

  getHostedEventsOfotherUser(String userId, {required String token}) async {
    try {
      var headers = {'Authorization': 'Bearer $userToken'};
      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/events/hosted-events?user_id=$userId',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      log.log(userId);

      if (response.statusCode == 200) {
        if (response.data['code'] == 200) {
          hostedEventsOfotherUser = HostedEventsOfUser.fromJson(response.data);
        } else {
          await getHostedEventsOfUser(token: token);
          return;
        }
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      await getHostedEventsOfUser(token: token);
      return;
    }
  }

  getEventDetails(String eventID, void setStateFunction) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'x-Localization': sharedPrefs.getBool('language') ?? false ? 'fr' : 'en',
      'Authorization': 'Bearer $userToken'
    };
    // print(eventID);
    var data = {'event_id': eventID};
    var dio = Dio();
    var response = await dio.request(
      'http://piptestnet.com/api/events/fetch-details',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    //print(response.statusCode);

    if (response.statusCode == 200) {
      //log.log(response.data.toString());

      if (response.data['code'] == 200) {
        log.log(response.data.toString());

        getEventDetailsModel = GetEventDetails.fromJson(response.data);
        setStateFunction;
        log.log("dsss");
        log.log("dsss${response.data}");

        log.log(getEventDetailsModel.data!.toJson().toString());
      } else if (response.data['code'] == 200 &&
          response.data['message'] == 'Unauthorized Access!') {
        showToasterror('Its taking a while please wait!');
        await getEventDetails(eventID, setStateFunction);
        return;
      }
    } else {
      print(response.statusMessage);
    }
  }
  // getMyFollowingList(String myUserID) async {
  //   var headers = {
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //     'Authorization': 'Bearer $userToken'
  //   };
  //   var data = {'user_id': myUserID};
  //   var dio = Dio();
  //   var response = await dio.request(
  //     'http://piptestnet.com/api/followings',
  //     options: Options(
  //       method: 'POST',
  //       headers: headers,
  //     ),
  //     data: data,
  //   );
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     print(response.data);
  //     if (response.data['code'] == 200) {
  //       print(response.statusMessage);
  //       myFollowingList = MyFollowingList.fromJson(response.data);
  //       getFollowingListSearch = myFollowingList.data;
  //       print(myFollowingList.count);
  //     } else if (response.data['code'] == 200 &&
  //         response.data['message'] == 'Unauthorized Access!') {
  //       getMyFollowingList(myUserID);
  //       return;
  //     }
  //   } else {
  //     print(response.statusMessage);
  //   }
  // }

  getinbox() async {
    SharedPreferences userpref = await SharedPreferences.getInstance();
    var myId = userpref.getInt("userId");
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $userToken'
    };
    var dio = Dio();
    var data = {'user_id': myId};
    var response = await dio.request(
      'http://piptestnet.com/api/inbox',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print("res${response.statusCode}");
      if (response.data['code'] == 200) {
        print("res${response.data}");
        chatInbox = MessagesResponseModel.fromJson(response.data);
        getFilterThreads = chatInbox.data;
        print("res$chatInbox");
      } else {
        await getinbox();
        return;
      }
    } else {
      print(response.statusMessage);
    }
  }

  getAccountinbox(String myId) async {
    print("object5555$myId");
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer$userToken'
    };
    var dio = Dio();
    var data = {'user_id': myId};
    print(data);
    print(headers);

    var response = await dio.request(
      'http://piptestnet.com/api/inbox',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    print("object1");
    if (response.statusCode == 200) {
      print("object2${response.statusCode}");
      print("res${response.statusCode}");
      if (response.data['code'] == 200) {
        print("res${response.data}");
        chatAccountInbox = MessagesResponseModel.fromJson(response.data);
        getAccountFilterThreads = chatAccountInbox.data;
        print("res$chatInbox");
      } else {
        // await getAccountinbox(myId);
        return [];
      }
    } else {
      print(response.statusMessage);
    }
  }

  getMessages() async {
    // SharedPreferences userpref = await SharedPreferences.getInstance();
    // var myId = userpref.getInt("userId");
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $userToken'
    };
    var dio = Dio();
    var data = {'conversation_id': "4"};
    var response = await dio.request(
      'http://piptestnet.com/api/get-messages',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print("res${response.statusCode}");
      if (response.data['code'] == 200) {
        print("res${response.data}");
        chatMessages = ChatMessagesModels.fromJson(response.data);
        print("res$chatInbox");
      } else {
        await getMessages();
        return;
      }
    } else {
      print(response.statusMessage);
    }
  }

  forgotPassword(String email) async {
    print("forgot");
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var data = FormData.fromMap({'email': email});
      print(userToken is String);
      print(userToken is Map);
      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/forgot-password',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(headers is String);
      print(headers is Map);
      if (response.statusCode == 200) {
        print("email verified successfully");
        if (response.data['code'] == 400) {
          await showToasterror('Sent Code Successfully!');
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      await showToasterror('Something went wrong!');
      print(e);
      return false;
    }
  }

  verifyOTP(String email, int code) async {
    print("forgot");
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var data = FormData.fromMap({'email': email, 'code': code});
      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/verify-otp',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        print("otp successfully");
        if (response.data['code'] == 200) {
          await showToasterror('OTP verified Successfully!');
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      await showToasterror('Something went wrong!');
      print(e);
      return false;
    }
  }

  resetPassword(String newPassword, String email) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var data =
          FormData.fromMap({'email': email, 'new_password': newPassword});
      var dio = Dio();
      var response = await dio.request(
        'http://piptestnet.com/api/reset-passwrod',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        if (response.data['code'] == 200) {
          await showToasterror('Reset Password Successfully!');
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      await showToasterror('Something went wrong!');
      print(e);
      return false;
    }
  }
}

double distanceBetweenPoints(
    double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371; // Radius of the Earth in kilometers

  double dLat = radians(lat2 - lat1);
  double dLon = radians(lon2 - lon1);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(radians(lat1)) * cos(radians(lat2)) * sin(dLon / 2) * sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c; // Distance in kilometers
}

double radians(double degrees) {
  return degrees * pi / 180;
}

checkDistanceBetweenTwoPoints(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) {


  double distance = distanceBetweenPoints(lat1, lon1, lat2, lon2);
  print("distance$distance");

  if (distance <= 10000) {
    return true;
  } else {
    return false;
  }
}

googleDistanceAPI() async {
  var dio = Dio();
  var response = await dio.request(
    'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=35.008631697001846, 71.27132927089094&origins=35.00863169700846, 73.2713292789094&key=AIzaSyDk1CcmJGWJMSu_jZz3WzU1SZzw4UNileU',
    options: Options(
      method: 'POST',
    ),
  );

  if (response.statusCode == 200) {
    print(json.encode(response.data));
  } else {
    print(response.statusMessage);
  }
}

Future<void> getUserLocation() async {
  try {
    await Geolocator.requestPermission();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      try {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );
        userLocation = position;
      } catch (e) {
        print('Error getting user location: $e');
      }
    } else {
      print('Location permission denied');
    }
  } catch (e) {
    print('Error getting user location: $e');
  }
}
