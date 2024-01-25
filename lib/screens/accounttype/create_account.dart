import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/accounttype/associate_signup.dart';
import 'package:newproject/screens/accounttype/bussiness_sigup.dart';
import 'package:newproject/screens/accounttype/student_signup.dart';
import 'package:newproject/screens/login/sign_in_account.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/start_activity.dart';

import '../../model/countries_model.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String baseUrl = 'http://piptestnet.com/api/';

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  Future<CountriesModel> getListOfCountries() async {
    Dio dio = Dio();

    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    const Map<String, dynamic>? data = null;
    final result = await dio
        .fetch<Map<String, dynamic>>(_setStreamType<CountriesModel>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(
              dio.options,
              'countries',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: baseUrl)));
    final value = CountriesModel.fromJson(result.data!);
    return value;
  }

  List<Country> countries = [];

  GetCountry() async {
    CountriesModel list = await getListOfCountries();
    countries.addAll(list.data);

    log(list.data.first.name);
  }

  /* catch (e) {
      print("An exception was caught: $e");
      if (e is DioError) {
        // Handle Dio specific errors here
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: e.message,
        );
      } else {
        // Handle other kinds of errors
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: 'Unknown error occurred',
        );
      }
    } 
  }*/

  @override
  void initState() {
    GetCountry();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F1216),
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Center(
            child: SvgPicture.asset("assets/Logo v.2.svg"),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "I want to create an account as".tr,
            style: const TextStyle(
                color: Color(0xffF9FAFB),
                fontWeight: FontWeight.bold,
                fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: OutlineButton(
              title: "Student".tr,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => StudentSignUp(countries)));
              },
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: OutlineButton(
                title: "Association".tr,
                onTap: () {
                  StartActivity().start(context, AssociatePage(countries));
                },
              )),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: OutlineButton(
              title: "Business".tr,
              onTap: () {
                StartActivity().start(context, BusinessSignUp(countries));
              },
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?".tr,
                  style: const TextStyle(
                      color: Color(0xffF9FAFB),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    StartActivity().start(context, SignInAccount(countries));
                  },
                  child: Text(
                    "Login".tr,
                    style: const TextStyle(
                        color: buttonColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
