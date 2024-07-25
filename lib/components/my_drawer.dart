import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/controllers/calendar_page_controller.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarPageController>(
        builder: (calendarPageController) {
      return SafeArea(
        child: Drawer(
          // ignore: deprecated_member_use
          backgroundColor: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              //logo header
              Padding(
                padding: EdgeInsets.only(
                  top: Dimensions.width20 * 2,
                  left: Dimensions.width10,
                ),
                child: Center(
                  child: Icon(
                    Icons.calendar_today_rounded,
                    size: Dimensions.width20 * 2,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
              // Divider
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height20),
                child: const Divider(
                  thickness: 2,
                ),
              ),
              // day tile
              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.width10,
                ),
                child: ListTile(
                  title: Text("day_text".tr),
                  leading: const Icon(Icons.calendar_today_rounded),
                  onTap: () {
                    calendarPageController.setCalendarView(CalendarView.day);
                    Get.back();
                  },
                ),
              ),
              // week tile
              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.width10,
                ),
                child: ListTile(
                  title: Text("week_text".tr),
                  leading: const Icon(Icons.calendar_view_week_outlined),
                  onTap: () {
                    calendarPageController.setCalendarView(CalendarView.week);
                    Get.back();
                  },
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
                    calendarPageController.setCalendarView(CalendarView.month);
                    // pop drawer
                    Navigator.of(context).pop();
                  },
                ),
              ),
              // history
              Padding(
                padding: EdgeInsets.only(
                  top: Dimensions.width10,
                  left: Dimensions.width10,
                ),
                child: ListTile(
                  title: Text("history_text".tr),
                  leading: const Icon(Icons.history),
                  onTap: () {
                    // when click this close drawer(by Get.back()) and go to page history
                    Get.back();
                    Get.toNamed(
                      RouteHelper.getHistoryPage(),
                    );
                  },
                ),
              ),
              // settings
              // change language
              Padding(
                padding: EdgeInsets.only(
                  top: Dimensions.width10,
                  left: Dimensions.width10,
                ),
                child: ListTile(
                  title: Text("change_language_text".tr),
                  leading: const Icon(Icons.language_outlined),
                  onTap: () {
                    // when click this close drawer(by Get.back()) and go to page change language
                    Get.back();
                    Get.toNamed(
                      RouteHelper.getOnBoardingLanguagePage(),
                      arguments: true,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
