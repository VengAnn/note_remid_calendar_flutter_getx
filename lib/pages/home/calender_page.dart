import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/components/dialog_show.dart';
import 'package:note_schedule_reminder/components/loading_custom.dart';
//import 'package:note_schedule_reminder/components/dialogs.dart';
import 'package:note_schedule_reminder/components/my_drawer.dart';
import 'package:note_schedule_reminder/controllers/auth/login_controller.dart';
import 'package:note_schedule_reminder/controllers/calendar_page_controller.dart';
// import 'package:note_schedule_reminder/services/auth_service.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarPageController calendarPageController =
      Get.put(CalendarPageController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    //print("calendarPage ${AuthService.auth.currentUser}");
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      body: GetBuilder<CalendarPageController>(
        builder: (calendarController) {
          return GetBuilder<LoginController>(builder: (loginController) {
            print("calendar ${loginController.isLoading}");
            return Center(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Stack(
                  children: [
                    // Custom drawer button without appbar this like app bar
                    Positioned(
                      top: 0,
                      child: SafeArea(
                        child: Container(
                          height: Dimensions.height20 * 2.7,
                          width: Dimensions.screenWidth,
                          color: Colors.white,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.menu),
                                onPressed: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                              ),
                              Text('title_appbar_text'.tr),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.calendar_today_outlined),
                                onPressed: () {},
                              ),
                              // btn show settings details
                              GestureDetector(
                                onTap: () {
                                  // dialog show settings
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return GetBuilder<LoginController>(
                                          builder: (loginController) {
                                        return Dialog(
                                          //insetPadding: EdgeInsets.zero, // Remove padding
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.width10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: const Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "settings account",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: const ListTile(
                                                        leading: CircleAvatar(
                                                          child: Icon(
                                                              Icons.person),
                                                        ),
                                                        title:
                                                            Text("name user"),
                                                        subtitle: Text(
                                                            "venganncoco@gmail.com"),
                                                      ),
                                                    ),
                                                    // btn logout
                                                    InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                        loginController
                                                            .logout();
                                                      },
                                                      child: const ListTile(
                                                        leading:
                                                            Icon(Icons.logout),
                                                        title: Text("logout"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // close button
                                                Positioned(
                                                  right: Dimensions.width5,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child:
                                                        const Icon(Icons.close),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  );
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: Dimensions.width5),
                                  child: CircleAvatar(
                                    radius: Dimensions.radius20,
                                    child: const Icon(Icons.person),
                                  ),
                                ),
                              ),
                              //
                            ],
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: Dimensions.height20 * 3.5),
                          child: SizedBox(
                            height: Dimensions.screenHeight -
                                (Dimensions.height20 * 3),
                            child: SfCalendar(
                              onSelectionChanged: (CalendarSelectionDetails
                                  calendarSelectionDetails) {},
                              view: CalendarView.week,
                              dataSource:
                                  _DataSource(calendarController.appointments),
                              selectionDecoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors
                                        .transparent), // Remove cell border selection
                              ),
                              onTap: (CalendarTapDetails details) {
                                calendarController
                                    .handleDateSelection(details.date!);

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
                                            color: Colors.transparent,
                                            child: const DialogShow(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              specialRegions: [
                                TimeRegion(
                                  startTime: calendarController.startTime,
                                  endTime: calendarController.endTime,
                                  enablePointerInteraction: false,
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                ),
                              ],
                              timeRegionBuilder: (BuildContext context,
                                  TimeRegionDetails details) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Column(
                                    children: [
                                      // Additional UI elements can go here
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    //
                    loginController.isLoading
                        ? SizedBox(
                            height: Dimensions.screenHeight,
                            width: Dimensions.screenWidth,
                            child: const LoadingCustom())
                        : const SizedBox(), // Show loading animation if isLoading is true
                  ],
                ),
              ),
            );
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // show the bottomSheet
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  color: Colors.transparent,
                  child: const DialogShow(),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // ignore: unused_element
  _DataSource _getCalendarDataSource() {
    List<Appointment> appointments = calendarPageController.appointments;
    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}

// dailog settings
Widget ShowDialogSettings() {
  return Container();
}
