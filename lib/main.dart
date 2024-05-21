import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/pages/auth/login_page.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:note_schedule_reminder/services/share_preferences.dart';
import 'package:note_schedule_reminder/translations/app_translate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize SharedPreferencesService
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  String? selectedLanguage =
      await sharedPreferencesService.loadSelectedLanguage();

  if (selectedLanguage == null || selectedLanguage.isEmpty) {
    selectedLanguage = 'en';
  }

  runApp(
    MyApp(selectedLanguage: selectedLanguage),
  );
}

class MyApp extends StatelessWidget {
  final String selectedLanguage;

  const MyApp({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Schedule Reminder APP',
      theme: ThemeData(
        brightness: Brightness.light, // Set brightness
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white.withOpacity(0.9),
      ),
      // translations: AppTranslations(),
      // locale: Locale(selectedLanguage), // Use selected language
      // fallbackLocale: const Locale('en'),
      // initialRoute: RouteHelper.getSplashPage(),
      //getPages: RouteHelper.routes,
      home: const LoginPage(),
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
