import 'package:get/get.dart';
import 'package:note_schedule_reminder/controllers/auth/login_controller.dart';
import 'package:note_schedule_reminder/controllers/events_controller/event_controller.dart';
import 'package:note_schedule_reminder/controllers/task_controller/task_controller.dart';
import 'package:note_schedule_reminder/pages/auth/sign_up_page.dart';

Future<void> init_Dependency_Injection() async {
  //api client

  //repositories

  // Register all controllers
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => SignUpPage());

  Get.lazyPut(() => TaskController());
  //Get.lazyPut(() => OnboardingController());
  //Get.lazyPut(() => CalendarPageController());
  
  // event controller
  Get.lazyPut(() => EventController());
}
