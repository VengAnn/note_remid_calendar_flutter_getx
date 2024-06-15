import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/controllers/awesome_noti_controller/notification_controller.dart';
import 'package:note_schedule_reminder/database/database_helper.dart';
import 'package:note_schedule_reminder/firebase_options.dart';
import 'package:note_schedule_reminder/injection.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:note_schedule_reminder/services/share_preferences.dart';
import 'package:note_schedule_reminder/translations/app_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> _initializeFirebare() async {
  // initialize with firebare credentials
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void initializeAwesomeNotification() {
  AwesomeNotifications().initialize(
    null, // Use the default app icon
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeAwesomeNotification();
  await init_Dependency_Injection(); // initialize the dependencies getx
  await _initializeFirebare();
  await DBHelper.initDb(); // this initialize sqflite
  await SharedPreferencesService.init(); // this SharedPreferences

  String? selectedLanguage = SharedPreferencesService.loadSelectedLanguage();

  if (selectedLanguage == null || selectedLanguage.isEmpty) {
    selectedLanguage = 'en';
  }

  runApp(MyApp(
    selectedLanguage: selectedLanguage,
  ));

  // set for when tap on notification show what page i want to show
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    onNotificationCreatedMethod:
        NotificationController.onNotificationCreatedMethod,
    onNotificationDisplayedMethod:
        NotificationController.onNotificationDisplayedMethod,
    onDismissActionReceivedMethod:
        NotificationController.onDismissActionReceivedMethod,
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final String selectedLanguage;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  MyApp({
    Key? key,
    required this.selectedLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey, // Use GlobalKey for navigator

      // this custom calendar language with khmer ,vietnamese and english
      //locale: Locale('vi'), // Set default locale to Vietnamese
      locale: Locale(selectedLanguage), // Use selected language

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('vi'), // Vietnamese
        Locale('km'), // Khmer
      ],
      // end of customite language calendar

      debugShowCheckedModeBanner: false,
      title: 'Schedule Reminder APP',
      theme: ThemeData(
        brightness: Brightness.light, // Set brightness
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white.withOpacity(0.9),
      ),
      translations: AppTranslations(),
      fallbackLocale: const Locale('en'),
      // Set initial route based on whether notification was clicked
      initialRoute: RouteHelper.getSplashPage(),
      //home: HistoryPage(),
      getPages: RouteHelper.routes,
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   // ignore: library_private_types_in_public_api
//   _MyHomePageState createState() => _MyHomePageState();
// }

// late Map<DateTime, List<Appointment>> _dataCollection;

// class _MyHomePageState extends State<MyHomePage> {
//   late var _calendarDataSource;

//   @override
//   void initState() {
//     _dataCollection = getAppointments();
//     _calendarDataSource = MeetingDataSource(<Appointment>[]);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SfCalendar(
//       view: CalendarView.week,
//       monthViewSettings: const MonthViewSettings(
//           appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
//       dataSource: _calendarDataSource,
//       loadMoreWidgetBuilder:
//           (BuildContext context, LoadMoreCallback loadMoreAppointments) {
//         return FutureBuilder(
//           future: loadMoreAppointments(),
//           builder: (context, snapShot) {
//             return Container(
//               alignment: Alignment.center,
//               child: const CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation(Colors.blue),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Map<DateTime, List<Appointment>> getAppointments() {
//     final List<String> _subjectCollection = <String>[];
//     _subjectCollection.add('General Meeting');
//     _subjectCollection.add('Plan Execution');
//     _subjectCollection.add('Project Plan');
//     _subjectCollection.add('Consulting');
//     _subjectCollection.add('Support');
//     _subjectCollection.add('Development Meeting');
//     _subjectCollection.add('Scrum');
//     _subjectCollection.add('Project Completion');
//     _subjectCollection.add('Release updates');
//     _subjectCollection.add('Performance Check');

//     final List<Color> _colorCollection = <Color>[];
//     _colorCollection.add(const Color(0xFF0F8644));
//     _colorCollection.add(const Color(0xFF8B1FA9));
//     _colorCollection.add(const Color(0xFFD20100));
//     _colorCollection.add(const Color(0xFFFC571D));
//     _colorCollection.add(const Color(0xFF36B37B));
//     _colorCollection.add(const Color(0xFF01A1EF));
//     _colorCollection.add(const Color(0xFF3D4FB5));
//     _colorCollection.add(const Color(0xFFE47C73));
//     _colorCollection.add(const Color(0xFF636363));
//     _colorCollection.add(const Color(0xFF0A8043));

//     final Random random = Random();
//     var _dataCollection = <DateTime, List<Appointment>>{};
//     final DateTime today = DateTime.now();
//     final DateTime rangeStartDate = DateTime(today.year, today.month, today.day)
//         .add(const Duration(days: -1000));
//     final DateTime rangeEndDate = DateTime(today.year, today.month, today.day)
//         .add(const Duration(days: 1000));
//     for (DateTime i = rangeStartDate;
//         i.isBefore(rangeEndDate);
//         i = i.add(Duration(days: 1 + random.nextInt(2)))) {
//       final DateTime date = i;
//       final int count = 1 + random.nextInt(3);
//       for (int j = 0; j < count; j++) {
//         final DateTime startDate = DateTime(
//             date.year, date.month, date.day, 8 + random.nextInt(8), 0, 0);
//         final int duration = random.nextInt(3);
//         final Appointment meeting = Appointment(
//             subject: _subjectCollection[random.nextInt(7)],
//             startTime: startDate,
//             endTime:
//                 startDate.add(Duration(hours: duration == 0 ? 1 : duration)),
//             color: _colorCollection[random.nextInt(9)],
//             isAllDay: false);

//         if (_dataCollection.containsKey(date)) {
//           final List<Appointment> meetings = _dataCollection[date]!;
//           meetings.add(meeting);
//           _dataCollection[date] = meetings;
//         } else {
//           _dataCollection[date] = [meeting];
//         }
//       }
//     }
//     return _dataCollection;
//   }
// }

// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Appointment> source) {
//     appointments = source;
//   }

//   @override
//   Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
//     await Future.delayed(Duration(seconds: 1));
//     final List<Appointment> meetings = <Appointment>[];
//     DateTime appStartDate = startDate;
//     DateTime appEndDate = endDate;

//     while (appStartDate.isBefore(appEndDate)) {
//       final List<Appointment>? data = _dataCollection[appStartDate];
//       if (data == null) {
//         appStartDate = appStartDate.add(Duration(days: 1));
//         continue;
//       }
//       for (final Appointment meeting in data) {
//         if (appointments!.contains(meeting)) {
//           continue;
//         }
//         meetings.add(meeting);
//       }
//       appStartDate = appStartDate.add(Duration(days: 1));
//     }
//     appointments!.addAll(meetings);
//     notifyListeners(CalendarDataSourceAction.add, meetings);
//   }
// }
