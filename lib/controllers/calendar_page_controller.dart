import 'dart:developer';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

class CalendarPageController extends GetxController {
  DateTime selectedTime = DateTime.now();
  List<DateTime> dateTimels = [];

  late DateTime startTime;
  late DateTime endTime;

  List<Appointment> appointments = [];

  @override
  void onInit() {
    super.onInit();
    // Get the current datetime
    DateTime currentDate = DateTime.now();
    // Initialize and set the default to current
    startTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 9, 0);
    endTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 10, 0);

    // Initialize some appointments
    appointments = _getDummyAppointments();
    update();
  }

  void updateStartAndEndTimes() {
    if (dateTimels.isNotEmpty) {
      startTime = dateTimels.first;
      endTime = dateTimels.last.add(
          const Duration(hours: 1)); // Add 1 hour to the last time in the list

      update();
      log("Updated start time: $startTime");
      log("Updated end time: $endTime");
    }
  }

  void addAndSortDateTime(DateTime dateTime) {
    dateTimels.add(dateTime);
    dateTimels.sort();
    updateStartAndEndTimes();
    log("Sorted dateTimels: $dateTimels");
  }

  void updateSelectedTime(DateTime newTime) {
    selectedTime = newTime;
    update();
  }

  void handleDateSelection(DateTime selectedDateTime) {
    updateSelectedTime(selectedDateTime);

    final dateTimeWithTime = DateTime(
      selectedDateTime.year,
      selectedDateTime.month,
      selectedDateTime.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    if (dateTimels.isNotEmpty &&
        (dateTimels.first.year != selectedDateTime.year ||
            dateTimels.first.month != selectedDateTime.month ||
            dateTimels.first.day != selectedDateTime.day)) {
      // If dateTime selected not the same as dateTime List, clear it out
      dateTimels.clear();
    }

    addAndSortDateTime(dateTimeWithTime);
  }

  // Get the Appointment
  List<Appointment> _getDummyAppointments() {
    return [
      Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: 'Meeting',
        color: Colors.blue,
      ),
      Appointment(
        startTime: startTime.add(const Duration(days: 1)),
        endTime: endTime.add(const Duration(days: 1)),
        subject: 'Conference',
        color: Colors.green,
      ),
    ];
  }
}
