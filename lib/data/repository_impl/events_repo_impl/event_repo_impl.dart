import 'dart:developer';

import 'package:note_schedule_reminder/data/api/api_client.dart';
import 'package:note_schedule_reminder/data/repository/events_repo/event_repo.dart';
import 'package:note_schedule_reminder/models/task_res/event_task.dart';
import 'package:note_schedule_reminder/utils/app_constant.dart';

class EventRepoImpl extends EventRepo {
  ApiClient _apiClient = new ApiClient();

  @override
  Future<EventTask?> addEvent(
      {required EventTask eventTask, required userId, required token}) async {
    log("repo imple userid: $userId - title: ${eventTask.title} - note: ${eventTask.note}");
    log("repo imple date: ${eventTask.date} - startTime: ${eventTask.startTime} - endTime: ${eventTask.endTime}");
    log("repo imple remind: ${eventTask.remind} - repeat: ${eventTask.repeat} - color: ${eventTask.color}");
    try {
      final res = await _apiClient.postData(
        endpoint: AppConstant.Event_EndPoint,
        data: {
          "user_id": userId,
          "title": eventTask.title,
          "note": eventTask.note,
          "date": eventTask.date,
          "start_time": eventTask.startTime,
          "end_time": eventTask.endTime,
          "Remind": eventTask.remind,
          "Repeat": eventTask.repeat,
          "color": eventTask.color,
        },
        token: token,
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return eventTask;
      }
      throw Exception("Error:  ${res.data} code:${res.statusCode}");
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<EventTask?> deleteEvent({required EventTask eventTask}) {
    throw UnimplementedError();
  }

  @override
  Future<List<EventTask>> getAllEvents() {
    throw UnimplementedError();
  }

  @override
  Future<EventTask?> getEventById({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<EventTask?> updateEvent({required EventTask eventTask}) {
    throw UnimplementedError();
  }

  @override
  Future<List<EventTask>?> getEventsByUserId({required int userId}) async {
    try {
      final res = await _apiClient.fetchData(
          endpoint:
              AppConstant.Event_With_UserId_EndPoint + "/" + userId.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        List<dynamic> dataList = res.data as List<dynamic>;
        List<EventTask> eventList =
            dataList.map((e) => EventTask.fromJson(e)).toList();

        return eventList;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error : $e");
    }
  }
}
