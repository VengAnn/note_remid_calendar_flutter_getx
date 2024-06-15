import 'dart:developer';

import 'package:get/get.dart';
import 'package:note_schedule_reminder/controllers/events_controller/event_controller.dart';
import 'package:note_schedule_reminder/models/task_res/event_task.dart';
import 'package:note_schedule_reminder/services/share_preferences.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class HistoryController extends GetxController {
  EventController eventController = Get.put(EventController());

  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<EventTask>?> getEventTaskFromServerByUserId() async {
    try {
      isLoading = true;
      update();

      List<EventTask>? eventTaskList = await eventController.getEventByUserId(
        user_Id: SharedPreferencesService.getUserId(),
      );

      if (eventTaskList != null) {
        isLoading = false;
        update();

        return eventTaskList;
      } else {
        isLoading = false;
        update();

        return null;
      }
    } catch (e) {
      isLoading = false;
      update();

      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        text: 'Error: $e',
      );
      log("error $e");
      return null;
    }
  }
}
