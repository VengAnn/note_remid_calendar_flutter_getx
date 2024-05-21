import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/widgets/onboarding_widget.dart';

class OnBoardingPageThree extends StatelessWidget {
  const OnBoardingPageThree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OnBoardingWidget(
      imageAsset: "assets/images/image_calendar_3.jpg",
      text: 'onboarding_three_text'.tr,
      showLogin: true,
    );
  }
}
