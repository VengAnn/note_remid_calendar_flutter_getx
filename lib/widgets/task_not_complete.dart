import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/models/task_res/event_task.dart';
import 'package:note_schedule_reminder/widgets/simple_text.dart';
import 'package:note_schedule_reminder/widgets/task_tile_widget.dart';
import 'package:note_schedule_reminder/widgets/text_form_field_widget.dart';

class TaskNotComplete extends StatefulWidget {
  TaskNotComplete({
    Key? key,
    this.eventTaskList,
  }) : super(key: key);

  final List<EventTask>? eventTaskList;

  @override
  _TaskNotCompleteState createState() => _TaskNotCompleteState();
}

class _TaskNotCompleteState extends State<TaskNotComplete> {
  TextEditingController textEditingController = TextEditingController();
  List<EventTask>? filteredTasks;

  @override
  void initState() {
    super.initState();
    filteredTasks = widget.eventTaskList;
  }

  void filterTasks(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredTasks = widget.eventTaskList;
      } else {
        filteredTasks = widget.eventTaskList!
            .where((task) =>
                task.title!.toLowerCase().contains(query.toLowerCase()) ||
                task.note!.toLowerCase().contains(query.toLowerCase()) ||
                task.date!.toLowerCase().contains(query.toLowerCase()) ||
                task.startTime!.toLowerCase().contains(query.toLowerCase()) ||
                task.endTime!.toLowerCase().contains(query.toLowerCase()) ||
                task.remind!.toLowerCase().contains(query.toLowerCase()) ||
                task.repeat!.toLowerCase().contains(query.toLowerCase()) ||
                task.color
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                task.status
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.eventTaskList!.isEmpty
        ? Center(child: SimpleText(text: "Empty data"))
        : Scaffold(
            body: Column(
              children: [
                TextFormFieldWidget(
                  textEditingController: textEditingController,
                  hintText: "text_search".tr,
                  titleText: "",
                  icon: Icons.search_outlined,
                  onChanged: filterTasks,
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: filteredTasks!.length,
                      itemBuilder: (context, index) {
                        return TaskTileWidget(task: filteredTasks![index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
