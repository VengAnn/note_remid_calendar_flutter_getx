// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:note_schedule_reminder/models/task_sqlite/task_model.dart';
// import 'package:note_schedule_reminder/pages/home/notification_page.dart';
// // ignore: depend_on_referenced_packages
// import 'package:timezone/data/latest.dart' as tz;
// // ignore: depend_on_referenced_packages
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_timezone/flutter_timezone.dart';

// class NotificationHelper {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   initializeNotification() async {
//     //tz.initializeTimeZones(); // Initialize time zones
//     _configureLocalTimeZone();
//     // this is for latest iOS settings
//     final DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//             requestSoundPermission: false,
//             requestBadgePermission: false,
//             requestAlertPermission: false,
//             onDidReceiveLocalNotification: onDidReceiveLocalNotification);

//     // initialize anddroid settings
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       iOS: initializationSettingsIOS,
//       android: initializationSettingsAndroid,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse:
//             (NotificationResponse? response) async {
//       await selectNotification(response?.payload);
//     });
//   }

//   displayNotification({required String title, required String body}) async {
//     // ignore: avoid_print
//     print("doing test");

//     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//       'channel id',
//       'channelName',
//       channelDescription: "channelDescription",
//       importance: Importance.max,
//       priority: Priority.max,
//     );
//     var iOSPlatformChannelSpecifics =
//         const DarwinNotificationDetails(); // Use the appropriate iOS details
//     var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'Themes changed',
//     );
//   }

//   scheduledNotification(int hour, int minutes, Task task) async {
//     try {
//       debugPrint("Scheduling Daily notification...");

//       const AndroidNotificationDetails androidPlatformChannelSpecifics =
//           AndroidNotificationDetails(
//         'channel id',
//         'channelName',
//         channelDescription: 'your channel description',
//       );

//       const NotificationDetails platformChannelSpecifics =
//           NotificationDetails(android: androidPlatformChannelSpecifics);

//       await flutterLocalNotificationsPlugin.zonedSchedule(
//         task.id!,
//         task.title,
//         task.note,
//         _convertTime(hour, minutes),

//         //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//         platformChannelSpecifics,
//         // ignore: deprecated_member_use
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents:
//             DateTimeComponents.time, // set this can notification dialy day
//         payload: "${task.title}| ${task.note}|",
//       );

//       debugPrint("Notification Dialy scheduled.");
//     } catch (e, stacktrace) {
//       debugPrint("Error scheduling notification: $e");
//       debugPrint("Stacktrace: $stacktrace");
//     }
//   }

//   // Method for scheduling a single notification
//   Future<void> scheduleSingleNotification(
//       int hour, int minutes, Task task) async {
//     log("hour: $hour  mm: $minutes -> id: ${task.id}");
//     try {
//       // ignore: avoid_print
//       print("Scheduling single notification...");

//       const AndroidNotificationDetails androidPlatformChannelSpecifics =
//           AndroidNotificationDetails(
//         'channel id',
//         'channelName',
//         channelDescription: 'your channel description',
//       );

//       const NotificationDetails platformChannelSpecifics =
//           NotificationDetails(android: androidPlatformChannelSpecifics);

//       await flutterLocalNotificationsPlugin.zonedSchedule(
//         task.id!,
//         task.title,
//         task.note,
//         _convertTime(hour, minutes),
//         platformChannelSpecifics,
//         // ignore: deprecated_member_use
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         payload: "${task.title}| ${task.note}|",
//       );

//       debugPrint("Single notification scheduled.");
//     } catch (e, stacktrace) {
//       debugPrint("Error scheduling single notification: $e");
//       debugPrint("Stacktrace: $stacktrace");
//     }
//   }

//   tz.TZDateTime _convertTime(int hour, int minutes) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduleDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

//     if (scheduleDate.isBefore(now)) {
//       scheduleDate = scheduleDate.add(const Duration(days: 1));
//     }
//     return scheduleDate;
//   }

//   Future<void> _configureLocalTimeZone() async {
//     tz.initializeTimeZones();
//     final String timeZone = await FlutterTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZone));
//   }

//   // Permissin ios for notifation
//   void requestIOSPermissions() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   }

//   //when click on notification
//   Future selectNotification(String? payload) async {
//     if (payload != null) {
//       // ignore: avoid_print
//       print('notification payload: $payload');
//     } else {
//       // ignore: avoid_print
//       print("Notification Done");
//     }

//     if (payload == "Themes changed") {
//       //don't go anywhere
//       debugPrint("Nothing navigate to");
//     } else {
//       Get.to(
//         () => NotifiedPage(label: payload),
//       );
//     }
//   }

//   Future onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     Get.dialog(const Text("Welcome to flutter"));
//     // display a dialog with the notification details, tap ok to go to another page

//     // showDialog(
//     //   //context: context,
//     //   builder: (BuildContext context) => CupertinoAlertDialog(
//     //     title: Text(title),
//     //     content: Text(body),
//     //     actions: [
//     //       CupertinoDialogAction(
//     //         isDefaultAction: true,
//     //         child: Text('Ok'),
//     //         onPressed: () async {
//     //           Navigator.of(context, rootNavigator: true).pop();
//     //           await Navigator.push(
//     //             context,
//     //             MaterialPageRoute(
//     //               builder: (context) => SecondScreen(payload),
//     //             ),
//     //           );
//     //         },
//     //       )
//     //     ],
//     //   ),
//     // );
//   }
// }
