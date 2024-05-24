import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:note_schedule_reminder/services/auth_service.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool hideShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorWhite,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
            ),
            child: SizedBox(
              height: Dimensions.screenHeight,
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
                      // go to home page
                      //Get.toNamed(RouteHelper.);
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
                      UserCredential? userCredential =
                          await AuthService.signInWithGoogle();
                      if (userCredential != null) {
                        log('Sign-in successful: ${userCredential.user}');
                        Get.toNamed(RouteHelper.getCalenderPage());
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
      ),
    );
  }
}
