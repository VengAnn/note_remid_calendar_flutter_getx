import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_schedule_reminder/components/dialog_show.dart';
import 'package:note_schedule_reminder/components/loading_custom.dart';
import 'package:note_schedule_reminder/components/my_drawer.dart';
import 'package:note_schedule_reminder/controllers/auth/login_controller.dart';
import 'package:note_schedule_reminder/controllers/calendar_page_controller.dart';
import 'package:note_schedule_reminder/controllers/events_controller/event_controller.dart';
import 'package:note_schedule_reminder/models/task_res/event_task.dart';
import 'package:note_schedule_reminder/pages/home/detail_task_page.dart';
import 'package:note_schedule_reminder/services/share_preferences.dart';
import 'package:note_schedule_reminder/utils/app_constant.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Get.put(CalendarPageController());
    Get.put(LoginController());
    Get.put(EventController());

    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      body: GetBuilder<LoginController>(
        builder: (loginController) {
          return GetBuilder<EventController>(builder: (eventController) {
            return GetBuilder<CalendarPageController>(
              builder: (calendarPageController) {
                return SafeArea(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: Dimensions.height20 * 2.7,
                            width: Dimensions.screenWidth,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _scaffoldKey.currentState?.openDrawer();
                                  },
                                  icon: const Icon(Icons.menu),
                                ),
                                Text(
                                  'title_appbar_text'.tr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimensions.fontSize20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    calendarPageController.jumpToToday();
                                  },
                                  child: Icon(
                                    Icons.calendar_today_outlined,
                                    size: Dimensions.iconSize17 * 1.2,
                                  ),
                                ),
                                // profile settings
                                GestureDetector(
                                  onTap: () {
                                    _showSettingsDialog(
                                        context, loginController);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: Dimensions.width5),
                                    child:
                                        SharedPreferencesService.getProfile() !=
                                                null
                                            ? CircleAvatar(
                                                radius: Dimensions.radius20,
                                                backgroundImage: NetworkImage(
                                                    "${AppConstant.PathImg_Url}${SharedPreferencesService.getProfile()}"),
                                              )
                                            : Lottie.asset(
                                                'assets/animations/profile_animation.json',
                                                width: Dimensions.width20 * 3,
                                                height: Dimensions.width20 * 3,
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // show calendar full screen if view week
                          calendarPageController.calendarView ==
                                  CalendarView.week
                              ? Expanded(
                                  child: showCalendar(),
                                )
                              : calendarPageController.calendarView ==
                                      CalendarView.day
                                  ? Expanded(
                                      child: showCalendar(),
                                    )
                                  :
                                  // calendar view month show a bit heigth
                                  Expanded(
                                      child: SizedBox(
                                        child: showCalendar(),
                                      ),
                                    ),
                        ],
                      ),
                      //
                      loginController.isLoading
                          ? const LoadingCustom()
                          : eventController.isLoading
                              ? const LoadingCustom()
                              : SizedBox(),
                    ],
                  ),
                );
              },
            );
          });
        },
      ),
      floatingActionButton: GetBuilder<LoginController>(
        builder: (loginController) {
          return GetBuilder<EventController>(
            builder: (eventController) {
              return loginController.isLoading
                  ? const SizedBox()
                  : eventController.isLoading
                      ? const SizedBox()
                      : FloatingActionButton(
                          onPressed: () {
                            _showBottomSheet(context);
                          },
                          child: const Icon(Icons.add),
                        );
            },
          );
        },
      ),
    );
  }
}

class showCalendar extends StatelessWidget {
  const showCalendar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CalendarPageController calendarController =
        Get.find<CalendarPageController>();

    return SfCalendar(
      controller: calendarController.calendarController,
      onTap: (CalendarTapDetails details) {
        if (details.appointments == null || details.appointments!.isEmpty) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return DraggableScrollableSheet(
                initialChildSize: 0.2, // Initial height
                minChildSize: 0.2,
                maxChildSize: 0.9,
                expand: false,
                builder: (context, scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      height: Dimensions.screenHeight,
                      color: Colors.transparent,
                      child: DialogShow(),
                    ),
                  );
                },
              );
            },
          );
        } else if (details.appointments != null) {
          // the first tap on calendar view month return don't see anything is have data

          Appointment tappedAppointment = details.appointments!.first;
          List<Object>? objList = tappedAppointment.resourceIds;
          // passing to list of EventTask
          List<EventTask> eventTaskList = [];
          for (var item in objList!) {
            if (item is EventTask) {
              eventTaskList.add(item);
            }
          }
          // Find the EventTask with matching id save in appointment
          EventTask? tappedEventTask;
          for (var e in eventTaskList) {
            if (e.eventId == tappedAppointment.id) {
              tappedEventTask = e;
              break;
            }
          }
          if (tappedEventTask != null) {
            log("Tapped tappedEventTask: ${tappedEventTask.title} - ${tappedEventTask.date}");
            // go to detail page
            Get.to(() => DetailTaskPage(
                  eventTask: tappedEventTask,
                ));
          }
        }
      },
      view: calendarController.calendarView,
      onSelectionChanged: (CalendarSelectionDetails details) {},
      dataSource: _getCalendarDataSource(),
      headerStyle: CalendarHeaderStyle(
        textAlign: TextAlign.center,
        backgroundColor: Colors.grey[300],
        textStyle: TextStyle(
          fontSize: Dimensions.fontSize20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      viewHeaderStyle: ViewHeaderStyle(
        dayTextStyle: TextStyle(
          fontSize: Dimensions.fontSize15,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
        dateTextStyle: TextStyle(
          fontSize: Dimensions.fontSize15,
          color: Colors.red,
        ),
      ),
      monthViewSettings: MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
        showAgenda: true,
        agendaViewHeight: Dimensions.height20 * 15,
        agendaStyle: AgendaStyle(
          backgroundColor: Colors.blue[200],
          dayTextStyle: TextStyle(
            fontSize: Dimensions.fontSize15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          dateTextStyle: TextStyle(
            fontSize: Dimensions.fontSize15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      todayHighlightColor: Colors.orange,
      selectionDecoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

//
_DataSource _getCalendarDataSource() {
  List<Appointment> appointments =
      Get.find<CalendarPageController>().appointments;

  return _DataSource(appointments);
}

//
class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}

//
void _showSettingsDialog(
    BuildContext context, LoginController loginController) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.width10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "settings account",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {},
                    child: ListTile(
                      leading: SharedPreferencesService.getProfile() != null
                          ? CircleAvatar(
                              radius: Dimensions.radius20,
                              backgroundImage: NetworkImage(
                                  "${AppConstant.PathImg_Url}${SharedPreferencesService.getProfile()}"),
                            )
                          : CircleAvatar(child: Icon(Icons.person)),
                      title: Text("username"),
                      subtitle: Text("venganncoco@gmail.com"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();

                      loginController.logout();
                    },
                    child: const ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("logout"),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: Dimensions.width5,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

//
void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Builder(builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            color: Colors.transparent,
            child: DialogShow(),
          ),
        );
      });
    },
  );
}
