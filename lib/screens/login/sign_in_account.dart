
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newproject/model/countries_model.dart';
import 'package:newproject/providers/global_providers.dart';
import 'package:newproject/screens/accounttype/create_account.dart';
import 'package:newproject/screens/dashboard/main_dashboard.dart';
import 'package:newproject/screens/login/forgot/email_get.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/start_activity.dart';
import 'package:newproject/utils/textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:newproject/common/constant.dart';
import '../../networking/rest_client/direct_implementation.dart';
import '../../utils/showtoast.dart';

class SignInAccount extends ConsumerStatefulWidget {
  const SignInAccount(List<Country> countries, {super.key});

  @override
  ConsumerState<SignInAccount> createState() => _SignInAccountState();
}

class _SignInAccountState extends ConsumerState<SignInAccount> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isPasswordHidden = true; // Default: Password is hidden
  TextEditingController loginPasswordController = TextEditingController();

  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isCheck = false;
  DateTime? lastBackPressed;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (lastBackPressed == null ||
              DateTime.now().difference(lastBackPressed!) >
                  const Duration(seconds: 3)) {
            // If it's been more than 2 seconds since the last back button press,
            // show a toast message
            lastBackPressed = DateTime.now();
            await showToasterror("Press back button again to exit");
            return false;
          } else {
            SystemNavigator.pop();
            return true;
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          backgroundColor: mainColor,
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                SvgPicture.asset("assets/Logo v.2.svg"),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "WELCOME BACK!".tr,
                  style: const TextStyle(
                      color: Color(0xffF9FAFB),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email".tr,
                            style: const TextStyle(
                                color: Color(0xffF9FAFB),
                                fontWeight: FontWeight.w300,
                                fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormInputField(
                              controller: loginEmailController,
                              hintText: "tobias@example.com",
                              textInputType: TextInputType.emailAddress),
                        ])),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password".tr,
                            style: const TextStyle(
                                color: Color(0xffF9FAFB),
                                fontWeight: FontWeight.w300,
                                fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            obscureText: _isPasswordHidden,
                            controller: loginPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an password';
                              }
                              // You can add more email validation checks here if needed
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordHidden
                                      ? Icons.visibility
                                      : Icons
                                          .visibility_off, // Choose icon based on the password visibility status
                                  color: iconColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordHidden = !_isPasswordHidden;
                                  });
                                },
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: mainTextFormColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: mainTextFormColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: mainTextFormColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: mainTextFormColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              fillColor: const Color(0xff21252A),
                              filled: true,
                              // labelText: "Password",
                              labelStyle: const TextStyle(color: Colors.white),
                              hintText: "******",
                              hintStyle: const TextStyle(color: Color(0xffA2A5AA)),
                              // labelStyle: const TextStyle(color: Color(0xff78E2A7)),
                            ),
                          ),
                        ])),
                Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(340, 49),
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () async {
                        if (loginEmailController.text.trim() == '') {
                          await showToasterror('Email Cannot Be Empty!');
                        } else if (loginPasswordController.text.trim() == '') {
                          await showToasterror('Password Cannot Be Empty');
                        } else {
                          await showToasterror('Loading!');

                          const snackBar = SnackBar(
                            content: Row(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 20),
                                Text("Signing in..."),
                              ],
                            ),
                            duration: Duration(
                                seconds:
                                    30), // Give a large duration to show it indefinitely
                          );

                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar); // Show SnackBar

                          try {
                            String deviceToken = '';
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            deviceToken =
                                pref.getString("fcm_token").toString();
                            print("fcm$deviceToken");
                            var result =
                                await ImplementRestClient().attemptLogIn(
                              email:
                                  loginEmailController.text.trim().toString(),
                              password: loginPasswordController.text
                                  .trim()
                                  .toString(),
                              device_token: deviceToken,
                            );
                            /*  log(result.data!.message);
                          log(result.data!.status);
                          log(result.data!.code.toString());
                          log(result.isSuccess.toString());
                       */
                            //  log(result.errorMessage!);

                            if (result.isSuccess) {
                              debugPrint("LogInSuccess");
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              String token = result.data!.data.token;
                              int userId = result.data!.data.user.id;
                              print("token $token");
                              

                              Future(() {
                                ref.read(saveTokenProvider(token));
                              });

                              // Remove SnackBar on success
                              StartActivity().start(
                                  context,
                                  const MainScreen(
                                      token: true,
                                      currentIndexOfMainScreenBottomBar: 0));
                              //   loginPasswordController.clear();
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              await pref.setString('email',
                                  loginEmailController.text.trim().toString());
                              await pref.setString(
                                  'password',
                                  loginPasswordController.text
                                      .trim()
                                      .toString());
                              pref.setString("token", token);
                              userToken = token;
                              SharedPreferences userpref =
                                  await SharedPreferences.getInstance();
                              userpref.setInt("userId", userId);
                            } else {
                              result.errorMessage == "Unauthorized"
                                  ? await showToasterror(
                                      "Please enter correct email and password".tr)
                                  : await showToasterror(result.errorMessage!
                                      //"Please enter correct email and password"
                                      );

                              // Handle failure
                            }
                          } catch (error) {
                            debugPrint("Error: ${error.toString()}");

                            // Handle error
                          } finally {
                            ScaffoldMessenger.of(context)
                                .hideCurrentSnackBar(); // Remove SnackBar in any case
                          }
                        }
                      },
                      child: Text(
                        "Sign In".tr,
                        style: const TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 8, top: 10),
                  alignment: AlignmentDirectional.center,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const GetEmail()));
                      },
                      child: Text(
                        "Forgot Password!".tr,
                        style: const TextStyle(color: forgotColor),
                      )),
                ),
                const Spacer(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?".tr,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => const CreateAccount()));
                          },
                          child: Text(
                            "Create an account".tr,
                            style: const TextStyle(
                                color: buttonColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
