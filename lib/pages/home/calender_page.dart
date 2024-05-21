import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/components/dialog_show.dart';
import 'package:note_schedule_reminder/controllers/calendar_page_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarPageController calendarPageController =
      Get.put(CalendarPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: GetBuilder<CalendarPageController>(
        builder: (calendarController) {
          return Center(
            child: Stack(
              children: [
                SfCalendar(
                  onSelectionChanged:
                      (CalendarSelectionDetails calendarSelectionDetails) {},
                  view: CalendarView.week,
                  dataSource: _DataSource(calendarController.appointments),
                  selectionDecoration: BoxDecoration(
                    border: Border.all(
                        color:
                            Colors.transparent), // Remove cell border selection
                  ),
                  onTap: (CalendarTapDetails details) {
                    calendarController.handleDateSelection(details.date!);

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
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ],
                  timeRegionBuilder:
                      (BuildContext context, TimeRegionDetails details) {
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
              ],
            ),
          );
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
