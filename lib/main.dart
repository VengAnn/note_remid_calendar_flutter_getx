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
