import 'package:flutter/material.dart';
import 'package:note_schedule_reminder/utils/app_color.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';
import 'package:note_schedule_reminder/widgets/simple_text.dart';

class OnBoardingWidget extends StatelessWidget {
  final String imageAsset;
  final String text;
  final bool showLogin;

  const OnBoardingWidget({
    Key? key,
    required this.imageAsset,
    required this.text,
    this.showLogin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: Dimensions.screenWidth,
              height: Dimensions.screenHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.green,
                  ],
                ),
              ),
            ),
            Positioned(
              top: Dimensions.screenHeight / 3.5,
              child: Container(
                width: Dimensions.screenWidth,
                height: Dimensions.height20 * 15,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan,
                      Colors.blueGrey,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.elliptical(10, 10),
                  ),
                ),
              ),
            ),
            Container(
              width: Dimensions.screenWidth,
              height: Dimensions.screenHeight / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.height20 * 10),
                  bottomRight: const Radius.elliptical(10, 10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: Dimensions.width10,
                      bottom: Dimensions.height10 * 2,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      child: Image.asset(
                        imageAsset,
                        width: Dimensions.height20 * 14,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: Dimensions.screenHeight / 1.8,
              child: Column(
                children: [
                  SizedBox(
                    width: Dimensions.screenWidth,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SimpleText(
                              text: text,
                              fontWeight: FontWeight.w600,
                              textColor: AppColor.colorWhite,
                              sizeText: Dimensions.fontSize21 / 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
