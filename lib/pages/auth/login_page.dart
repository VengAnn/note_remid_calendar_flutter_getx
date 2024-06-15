import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/components/dialogs.dart';
import 'package:note_schedule_reminder/components/loading_custom.dart';
import 'package:note_schedule_reminder/controllers/auth/login_controller.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:note_schedule_reminder/services/auth_service.dart';
import 'package:note_schedule_reminder/services/share_preferences.dart';
import 'package:note_schedule_reminder/utils/app_color.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';
import 'package:note_schedule_reminder/widgets/simple_text.dart';
import 'package:note_schedule_reminder/widgets/text_form_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController =
      TextEditingController(text: "venganncoco@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "1234567");

  final _formKey = GlobalKey<FormState>();

  bool hideShowPassword = false;
  bool _loginBtnTapped = false; // Track if the login button is tapped

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    // Check if the keyboard is open
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.colorWhite,
        body: SingleChildScrollView(
          physics: isKeyboardOpen
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: GetBuilder<LoginController>(
            builder: (loginController) {
              log("loading login: ${loginController.isLoading}");

              if (loginController.isLoading) {
                return SizedBox(
                  height: Dimensions.screenHeight,
                  child: const LoadingCustom(),
                );
              }
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                  ),
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Image.asset(
                            "assets/images/logo_login.jpg",
                            width: Dimensions.width20 * 10,
                          ),
                          // email
                          TextFormFieldWidget(
                            textEditingController: _emailController,
                            hintText: "email_text".tr,
                            titleText: "email_text".tr,
                            icon: Icons.email_outlined,
                            btnTapped: _loginBtnTapped,
                            textVilidation: "Please enter your email",
                            showInvalidEmail: true,
                          ),
                          TextFormFieldWidget(
                            textEditingController: _passwordController,
                            hintText: "password_text".tr,
                            titleText: "password_text".tr,
                            icon: Icons.password_outlined,
                            iconSuffix: hideShowPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            onTap: () {
                              setState(() {
                                hideShowPassword = !hideShowPassword;
                              });
                            },
                            showIconSuffix: true,
                            obscureText: hideShowPassword ? false : true,
                            btnTapped: _loginBtnTapped,
                            textVilidation: "Please enter password",
                          ),

                          SizedBox(height: Dimensions.height5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print("forget");
                                },
                                child: SimpleText(
                                  text: "forgot_password_text".tr,
                                  sizeText: Dimensions.fontSize15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height5),
                          // btn login
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _loginBtnTapped = true;
                                });

                                if (_emailController.text.isNotEmpty &&
                                    _passwordController.text.isNotEmpty) {
                                  loginController.login(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                }
                              }
                            },
                            child: Container(
                              width: Dimensions.screenWidth,
                              height: Dimensions.height20 * 2,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColor.colorBlue,
                                    AppColor.colorAmber,
                                  ],
                                ),
                              ),
                              child: Center(
                                child: SimpleText(text: 'login_text'.tr),
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                          // text if don't have a account
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SimpleText(
                                text: 'have_accout_text'.tr,
                                fontWeight: FontWeight.bold,
                                sizeText: Dimensions.fontSize20 / 1.5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // go to sign up page
                                  Get.toNamed(RouteHelper.getSignUpPage());
                                },
                                child: SimpleText(
                                  text: "sign_up_text".tr,
                                  textColor: AppColor.colorBlue,
                                  fontWeight: FontWeight.bold,
                                  sizeText: Dimensions.fontSize20 / 1.2,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height20),
                          // login with google account
                          InkWell(
                            onTap: () async {
                              // Show loading
                              Dialogs.showProgressBar(context);

                              UserCredential? userCredential =
                                  await AuthService.signInWithGoogle();
                              Dialogs.hideProgressBar(
                                  // ignore: use_build_context_synchronously
                                  context); // Hide loading in both cases

                              if (userCredential != null) {
                                // Access user information
                                var name = userCredential
                                    .additionalUserInfo?.profile?['name'];
                                var email = userCredential
                                    .additionalUserInfo?.profile?['email'];
                                // var photoUrl = userCredential
                                //     .additionalUserInfo?.profile?['picture'];

                                log("email: $email");
                                loginController.loginWithGoogle(email, name);

                                SharedPreferencesService.saveIsLoginWithGoogle(
                                    true);
                                // Navigate to CalendarPage
                                //Get.toNamed(RouteHelper.getCalenderPage());
                              } else {
                                Dialogs.showSnackBar(
                                    'Authentication failed or was cancelled');
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(Dimensions.width10 * 2),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.grey.shade200,
                              ),
                              child: Image.asset(
                                "assets/images/google.png",
                                width: Dimensions.width20 * 2,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
