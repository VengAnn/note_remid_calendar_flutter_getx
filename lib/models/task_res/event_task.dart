class EventTask {
  int? eventId;
  int? userId;
  String? title;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  String? remind;
  String? repeat;
  int? color;
  int? status;
  String? createdAt;
  String? updatedAt;

  EventTask(
      {this.eventId,
      this.userId,
      this.title,
      this.note,
      this.date,
      this.startTime,
      this.endTime,
      this.remind,
      this.repeat,
      this.color,
      this.status,
      this.createdAt,
      this.updatedAt});

  EventTask.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    userId = json['user_id'];
    title = json['title'];
    note = json['note'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    remind = json['Remind'];
    repeat = json['Repeat'];
    color = json['color'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['note'] = this.note;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['Remind'] = this.remind;
    data['Repeat'] = this.repeat;
    data['color'] = this.color;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
