import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:lottie/lottie.dart';
import 'package:note_schedule_reminder/services/share_preferences.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(const Duration(seconds: 3), () async {
      // if user already logged in or authenticated navigation to home page
      // if (AuthService.auth.currentUser != null) {
      //   Get.offNamed(
      //     RouteHelper.getCalenderPage(),
      //   );
      // }

      // if user not logged in or not authenticated navigation to login page
      // we check if onboarding page is already show (mean existing) navigation to login page
      bool isExistOnboarding =
          await SharedPreferencesService.loadOnboardingExist();
      if (isExistOnboarding) {
        Get.offNamed(
          RouteHelper.getLoginPage(),
        );
      } else {
        Get.offNamed(
          RouteHelper.getOnBoardingLanguagePage(),
          arguments: false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0), // Slide from right
                end: Offset.zero, // To the center
              ).animate(animation),
              child: Lottie.asset(
                'assets/animations/logo_animation.json',
                // width: 100,
                // height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10),
          Center(
            child: Text(
              'splash_text'.tr,
            ),
          ),
        ],
      ),
    );
  }
}
