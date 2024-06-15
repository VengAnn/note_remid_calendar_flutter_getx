import 'dart:convert';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:note_schedule_reminder/models/task_sqlite/task_model.dart';

class AwesomeNotificationHelper {
  // Method to schedule a notification at a specific date and time
  static void scheduleNotificationWithDateTime(
      {required Task task,
      required String title,
      required String body,
      required int year,
      required int month,
      required int day,
      required int hour,
      required int minute,
      String? summary}) {
    // int notificationUniqueId = Random().nextInt(1000);
    DateTime scheduledDate = DateTime(year, month, day, hour, minute);

    print(
        "year : $year, month : $month, day : $day, hour : $hour and minute : $minute");

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: task.id!,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        summary: summary, // Adding summary to the notification content
        payload: {
          'task': jsonEncode(task.toJson()), // Serialize EventTask to JSON
          'title': title,
          'body': body,
        }, // Adding payload here
      ),
      schedule: NotificationCalendar.fromDate(
        date: scheduledDate,
        allowWhileIdle: true,
      ),
      // show text below when show notifications
      actionButtons: [
        NotificationActionButton(
          key: 'VIEW',
          label: 'View Details',
          autoDismissible: true,
        ),
      ],
    );
  }

  // Method to show a simple notification immediately
  static void showSimpleNotification(String title, String body,
      {String? summary}) {
    int notificationUniqueId = Random().nextInt(1000);

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationUniqueId,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        summary: summary, // Adding summary to the notification content
        payload: {'title': title, 'body': body}, // Adding payload here
      ),
      //
      actionButtons: [
        NotificationActionButton(
          key: 'VIEW',
          label: 'View Details',
          autoDismissible: true,
        ),
      ],
    );
  }

  // Method to schedule a daily notification at a specific time
  static void scheduleDailyNotification(
      {required Task task,
      required String title,
      required String body,
      required int hour,
      required int minute,
      String? summary}) {
    // int notificationUniqueId = Random().nextInt(1000);
    print("Dialy Notification:  hour : $hour and minute : $minute");
    
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: task.id!,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        summary: summary, // Adding summary to the notification content
        payload: {'title': title, 'body': body}, // Adding payload here
      ),
      schedule: NotificationCalendar(
        hour: hour,
        minute: minute,
        second: 0,
        millisecond: 0,
        repeats: true,
        allowWhileIdle: true,
      ),
      //
      actionButtons: [
        NotificationActionButton(
          key: 'VIEW',
          label: 'View Details',
          autoDismissible: true,
        ),
      ],
    );
  }
}
