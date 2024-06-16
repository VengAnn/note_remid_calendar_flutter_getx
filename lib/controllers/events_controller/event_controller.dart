import 'dart:developer';

import 'package:get/get.dart';
import 'package:note_schedule_reminder/components/dialogs.dart';
import 'package:note_schedule_reminder/data/repository_impl/events_repo_impl/event_repo_impl.dart';
import 'package:note_schedule_reminder/models/task_res/event_task.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:note_schedule_reminder/services/share_preferences.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class EventController extends GetxController {
  EventRepoImpl eventRepoImpl = new EventRepoImpl();

  bool isLoading = false;

  void addEvent(
      {required EventTask eventTask,
      required int userId,
      required token}) async {
    try {
      isLoading = true;
      update();

      final EventTask? eventTaskResponse = await eventRepoImpl.addEvent(
          eventTask: eventTask, userId: userId, token: token);

      if (eventTaskResponse != null) {
        isLoading = false;
        update();

        Dialogs.showSnackBar("Event Added");
      } else {
        isLoading = false;
        update();

        Dialogs.showSnackBar("Error: Event not added");
      }
    } catch (e) {
      isLoading = false;
      update();

      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        text: 'Error: $e',
      );
    }
  }

  // get events by user id
  Future<List<EventTask>?> getEventByUserId({required int user_Id}) async {
    try {
      isLoading = true;
      update();

      List<EventTask>? eventTaskList =
          await eventRepoImpl.getEventsByUserId(userId: user_Id);

      // ignore: unnecessary_null_comparison
      if (eventTaskList != null) {
        isLoading = false;
        update();

        return eventTaskList;
      }
      isLoading = false;
      update();

      return null;
    } catch (e) {
      isLoading = false;
      update();

      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        text: 'Error: $e',
      );
    }
    return null;
  }

  // update EvetTask
  Future<void> updateEvent({required EventTask eventTask}) async {
    try {
      isLoading = true;
      update();

      final EventTask? updatedEventTask = await eventRepoImpl.updateEvent(
        eventTask: eventTask,
        user_id: SharedPreferencesService.getUserId(),
        token: SharedPreferencesService.getToken()!,
      );

      if (updatedEventTask != null) {
        isLoading = false;
        update();

        Get.toNamed(RouteHelper.getCalenderPage());
        Dialogs.showSnackBar("Event task successfully updated");
      } else {
        isLoading = false;
        update();
        Dialogs.showSnackBar("Error: Event task not updated");
      }
    } catch (e) {
      isLoading = false;
      update();

      log("Error: $e");
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        text: 'Error: $e',
      );
    }
  }
}
