import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/pages/onboarding/onboarding_one.dart';
import 'package:note_schedule_reminder/pages/onboarding/onboarding_three.dart';
import 'package:note_schedule_reminder/pages/onboarding/onboarding_two.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:note_schedule_reminder/utils/app_color.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';
import 'package:note_schedule_reminder/widgets/simple_text.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 1.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Dimensions.screenHeight,
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              children: const [
                OnBoardingPageOne(),
                OnBoardingPageTwo(),
                OnBoardingPageThree(),
              ],
            ),
          ),
          Positioned(
            bottom: Dimensions.height10 * 2,
            right: 0,
            left: 0,
            child: Container(
              height: 50,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Container(
                    width: _currentPage == index
                        ? Dimensions.width20
                        : Dimensions.width10,
                    height: Dimensions.height10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                      color: index == _currentPage
                          ? AppColor.colorAmber
                          : AppColor.colorWhite,
                    ),
                    margin: EdgeInsets.only(right: Dimensions.width10 / 2),
                  ),
                ),
              ),
            ),
          ),
          // if laset page view show login text
          _currentPage == 2
              ? Positioned(
                  bottom: Dimensions.height10 * 3,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.getLoginPage());
                    },
                    child: SimpleText(
                      text: 'login_text'.tr,
                      sizeText: Dimensions.fontSize20,
                      textColor: AppColor.colorBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
