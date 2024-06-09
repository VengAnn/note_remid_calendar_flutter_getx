import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        // ignore: deprecated_member_use
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            //logo
            DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.calendar_today_rounded,
                  size: Dimensions.width20 * 2,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),

            // week tile
            Padding(
              padding: EdgeInsets.only(
                top: Dimensions.width10,
                left: Dimensions.width10,
              ),
              child: ListTile(
                title: Text("week_text".tr),
                leading: const Icon(Icons.calendar_view_week_outlined),
                onTap: () => Get.back(),
              ),
            ),

            // Month tile
            Padding(
              padding: EdgeInsets.only(
                top: Dimensions.width10,
                left: Dimensions.width10,
              ),
              child: ListTile(
                title: Text("month_text".tr),
                leading: const Icon(Icons.calendar_month_outlined),
                onTap: () {
                  // pop drawer
                  Navigator.of(context).pop();

                  // // Navigation to settings
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const SettingPage(),
                  //   ),
                  // );
                },
              ),
            ),
            // change language
            Padding(
              padding: EdgeInsets.only(
                top: Dimensions.width10,
                left: Dimensions.width10,
              ),
              child: ListTile(
                title: Text("change_language_text".tr),
                leading: const Icon(Icons.language_outlined),
                onTap: () => Get.toNamed(
                  RouteHelper.getOnBoardingLanguagePage(),
                  arguments: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
