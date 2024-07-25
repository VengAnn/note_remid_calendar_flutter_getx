import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_schedule_reminder/components/dialogs.dart';
import 'package:note_schedule_reminder/controllers/events_controller/event_controller.dart';
import 'package:note_schedule_reminder/controllers/task_controller/task_controller.dart';
import 'package:note_schedule_reminder/models/task_res/event_task.dart';
import 'package:note_schedule_reminder/models/task_sqlite/task_model.dart';
import 'package:note_schedule_reminder/services/awesome_noti_helper.dart';
import 'package:note_schedule_reminder/services/share_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

class CalendarPageController extends GetxController {
  DateTime selectedTime = DateTime.now();
  // List<DateTime> dateTimels = [];

  late DateTime startTime;
  late DateTime endTime;

  List<Appointment> appointments = [];

  // this for change calendar view day or week or month
  CalendarView calendarView = CalendarView.day;
  final CalendarController calendarController = CalendarController();

  TaskController taskController = Get.put(TaskController());
  EventController eventController = Get.put(EventController());

  @override
  void onInit() {
    super.onInit();

    initializeTimes();

    getEventTaskFromServer();
  }

  void initializeTimes() {
    // Get the current datetime
    DateTime currentDate = DateTime.now();
    // Initialize and set the default to current
    startTime = DateTime(currentDate.year, currentDate.month, currentDate.day);
    endTime = DateTime(currentDate.year, currentDate.month, currentDate.day);
  }

  // alert awesome schedule notification
  void alertNotification({required Task task}) {
    try {
      if (task.date == null || task.startTime == null) {
        throw const FormatException('Date or Start Time is null');
      }

      DateTime taskDateTime = DateFormat("yyyy-MM-dd hh:mm a")
          .parse("${task.date} ${task.startTime}");
      DateTime now = DateTime.now();

      if (taskDateTime.isAfter(now)) {
        if (task.repeat == "None") {
          log("Task : ${task.startTime}, repeat : ${task.repeat}, task : ${task.remind}");
          // Subtract the reminder time from the taskDateTime if remind is not 0 and not null
          if (task.remind != null && task.remind != 0) {
            int remindMinutes = task.remind!;
            taskDateTime =
                taskDateTime.subtract(Duration(minutes: remindMinutes));
          }

          AwesomeNotificationHelper.scheduleNotificationWithDateTime(
            task: task,
            title: task.title!,
            body: task.note!,
            year: taskDateTime.year,
            month: taskDateTime.month,
            day: taskDateTime.day,
            hour: taskDateTime.hour,
            minute: taskDateTime.minute,
            summary: 'Something New',
          );
        } else if (task.repeat == "Daily") {
          // Handle repeating notifications
          log("Task : ${task.startTime}, repeat : ${task.repeat}, task : ${task.remind}");
          AwesomeNotificationHelper.scheduleDailyNotification(
            task: task,
            title: task.title!,
            body: task.note!,
            hour: taskDateTime.hour,
            minute: taskDateTime.minute,
            summary: 'Something New',
          );
        }
      }
    } catch (e) {
      log("Error in alertNotification: $e");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Dialogs.showSnackBar("Error in alertNotification: $e");
      });
    }
  }

  void deleteLocalStorageNotCurrentlyDateTime({required Task task}) {
    // delete local storage if not currently date time
    DateTime taskDateTime = DateFormat("yyyy-MM-dd hh:mm a")
        .parse("${task.date} ${task.startTime}");
    DateTime now = DateTime.now();
    // Check if the task's date and time are in the past
    if (taskDateTime.isBefore(now)) {
      log("delete task now: ${task.date} ${task.startTime}");
      // Delete the task from local storage
      taskController.delele(task);
    }
  }

  Future<void> getTaskFromTaskController() async {
    await taskController.getTasks();

    for (Task task in taskController.taskList) {
      alertNotification(task: task);
      deleteLocalStorageNotCurrentlyDateTime(task: task);
    }
  }

  Future<void> getEventTaskFromServer() async {
    // ignore: await_only_futures
    final int userId = await SharedPreferencesService.getUserId();

    // Fetch event tasks from the server
    List<EventTask>? eventTaskList =
        await eventController.getEventByUserId(user_Id: userId);

    if (eventTaskList != null && eventTaskList.isNotEmpty) {
      // Convert all event tasks to appointments and update
      appointments = getEventTaskAsAppointments(eventTaskList);
      update(); // Assuming update method exists to notify listeners
    } else {
      // ignore: avoid_print
      print("Event task list is null or empty");
    }
  }

  // Function to convert eventTask to appointments
  List<Appointment> getEventTaskAsAppointments(List<EventTask> eventTaskList) {
    List<Appointment> appointmentsLocal = [];

    for (EventTask eventTask in eventTaskList) {
      // Parse the time string to a DateTime object using DateFormat
      DateTime startTime = DateFormat("yyy-MM-dd hh:mm a")
          .parse("${eventTask.date} ${eventTask.startTime}");
      DateTime endTime = DateFormat("yyy-MM-dd hh:mm a")
          .parse("${eventTask.date} ${eventTask.endTime}");

      if (startTime == endTime) {
        // If the start and end times are the same, increment the 1 hour to endtime
        endTime = endTime.add(const Duration(hours: 1));
      }

      appointmentsLocal.add(
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: eventTask.title ?? '',
          color: eventTask.color == 0
              ? Colors.blue
              : eventTask.color == 1
                  ? Colors.pink
                  : Colors.yellow,
          id: eventTask.eventId,
          notes: eventTask.note,
          isAllDay: eventTask.repeat == 'Daily' ? true : false,
          resourceIds: eventTaskList,
        ),
      );
    }
    return appointmentsLocal;
  }

  // void change calendar view or month
  void setCalendarView(CalendarView view) {
    // log("Changed view: $view");
    calendarView = view;
    update();
    calendarController.view = calendarView;
  }

  void jumpToToday() {
    calendarController.displayDate = DateTime.now();
    update();
  }
}
