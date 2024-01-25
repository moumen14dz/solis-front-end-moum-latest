import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/accounttype/create_account.dart';
import 'package:newproject/screens/login/sign_in_account.dart';
import 'package:newproject/utils/colors.dart';

import '../../model/countries_model.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/back.png",
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            SvgPicture.asset("assets/Logo v.2.svg"),
            const Spacer(),
            Text(
              "Welcome to Solis!".tr,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Text(
              "Choose a preferred way".tr,
              style: TextStyle(
                  color: Colors.white.withOpacity(.6),
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const CreateAccount()));
              },
              child: Container(
                width: Get.width,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: buttonColor,
                ),
                child: Center(
                  child: Text(
                    'Create an account'.tr,
                    style: const TextStyle(
                      fontFamily: "Mulish",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => SignInAccount(countries)));
              },
              child: Container(
                width: Get.width,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: buttonColor, width: 2)),
                child: Center(
                  child: Text(
                    'Login'.tr,
                    style: const TextStyle(
                        fontFamily: "Mulish",
                        fontWeight: FontWeight.w600,
                        color: buttonColor),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
