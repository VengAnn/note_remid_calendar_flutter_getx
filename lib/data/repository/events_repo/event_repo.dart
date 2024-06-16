import 'package:note_schedule_reminder/models/task_res/event_task.dart';

abstract class EventRepo {
  Future<EventTask?> addEvent(
      {required EventTask eventTask, required userId, required token});

  Future<EventTask?> updateEvent(
      {required EventTask eventTask, required int user_id,required String token}) ;

  Future<EventTask?> deleteEvent({required EventTask eventTask});
  Future<List<EventTask>> getAllEvents();
  Future<EventTask?> getEventById({required int id});

  Future<List<EventTask>?> getEventsByUserId({required int userId});
}
