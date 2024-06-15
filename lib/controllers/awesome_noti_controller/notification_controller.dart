import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/models/task_res/event_task.dart';
import 'package:note_schedule_reminder/models/task_sqlite/task_model.dart';
import 'package:note_schedule_reminder/pages/home/detail_task_page.dart';

class NotificationController {
  /// Handle when a new notification or schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Implement your logic here
  }

  /// Handle when a notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Implement your logic here
  }

  /// Handle when the user dismisses a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Implement your logic here
  }

  /// Handle when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Log the received action details
    log('Received Action:');
    log('Action ID: ${receivedAction.id}');
    log('Action Type: ${receivedAction.actionType}');
    log('Payload: ${receivedAction.payload}');

    if (receivedAction.payload != null) {
      // Deserialize Task from payload
      String? taskStr = receivedAction.payload!['task'];
      Map<String, dynamic> taskMap = jsonDecode(taskStr!);
      Task taskObj = Task.fromJson(taskMap);

      EventTask eventTask = EventTask(
        title: taskObj.title,
        note: taskObj.note,
        startTime: taskObj.startTime,
        endTime: taskObj.endTime,
        remind: taskObj.remind.toString(),
        color: taskObj.color,
        date: taskObj.date,
        repeat: taskObj.repeat,
        status: taskObj.isCompleted,
      );

      // Navigate or perform actions based on the received data
      Get.offAll(() => DetailTaskPage(eventTask: eventTask));

      log("Navigated to DetailTaskPage");
    } else {
      log('Payload is null');
    }
  }
}
