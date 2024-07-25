import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_schedule_reminder/components/dialog_show.dart';
import 'package:note_schedule_reminder/models/task_res/event_task.dart';
import 'package:note_schedule_reminder/models/task_sqlite/task_model.dart';
import 'package:note_schedule_reminder/utils/app_color.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';
import 'package:note_schedule_reminder/widgets/simple_text.dart';

class TaskTileWidget extends StatelessWidget {
  final EventTask task;

  const TaskTileWidget({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width5 * 2),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: Dimensions.width10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleText(
            text: task.date!,
            textColor: task.color == 2 ? Colors.black : Colors.white,
          ),
          Row(
            children: [
              Icon(
                Icons.done_all_outlined,
              ),
              SizedBox(width: Dimensions.width5),
              SimpleText(text: task.startTime!),
              Spacer(),
              // icon more for editing
              GestureDetector(
                onTap: () {
                  _showBottomSheet(context, task);
                },
                child: Icon(Icons.more_vert_outlined),
              ),
            ],
          ),
          SizedBox(height: Dimensions.height5),
          //
          Container(
            padding: EdgeInsets.all(Dimensions.width10),
            //  width: SizeConfig.screenWidth * 0.78,
            decoration: BoxDecoration(
              color: _getBGClr(task.color ?? 0),
              borderRadius: BorderRadius.circular(Dimensions.width10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title ?? "",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:
                                task.color == 2 ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: task.color == 2
                                ? Colors.black
                                : Colors.grey[200],
                            size: Dimensions.iconSize17,
                          ),
                          SizedBox(width: Dimensions.width10),
                          Text(
                            "${task.startTime} - ${task.endTime}",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: Dimensions.fontSize15,
                                color: task.color == 2
                                    ? Colors.black
                                    : Colors.grey[100],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10),
                      Text(
                        task.note ?? "",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: task.color == 2
                                ? Colors.black
                                : Colors.grey[100],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                  height: Dimensions.height20 * 2,
                  width: 0.5,
                  color: task.color == 2
                      ? Colors.black
                      : Colors.grey[200]!.withOpacity(0.7),
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    task.status == 1 ? "COMPLETED" : "TODO",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: task.color == 2 ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return AppColor.bluishClr;
      case 1:
        return AppColor.pinkClr;
      case 2:
        return AppColor.yellowClr;
      default:
        return AppColor.bluishClr;
    }
  }
}

//
void _showBottomSheet(BuildContext context, EventTask eTask) {
  Task task = Task(
    id: eTask.eventId,
    isCompleted: eTask.status,
    title: eTask.title,
    date: eTask.date,
    remind: int.parse(eTask.remind!),
    note: eTask.note,
    startTime: eTask.startTime,
    endTime: eTask.endTime,
    color: eTask.color,
    repeat: eTask.repeat,
  );

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              color: Colors.transparent,
              child: DialogShow(
                isForUpdate: true,
                task: task,
              ),
            ),
          );
        },
      );
    },
  );
}
