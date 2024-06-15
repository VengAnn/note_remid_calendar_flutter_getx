import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/components/dialog_show.dart';
import 'package:note_schedule_reminder/models/task_res/event_task.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:note_schedule_reminder/utils/app_color.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';
import 'package:note_schedule_reminder/widgets/simple_text.dart';

class DetailTaskPage extends StatelessWidget {
  final EventTask? eventTask;

  const DetailTaskPage({
    super.key,
    this.eventTask,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.toNamed(RouteHelper.getCalenderPage());
          },
          icon: Icon(Icons.close_outlined),
        ),
        title: SimpleText(
          text: "title_text_detailPage".tr,
          sizeText: Dimensions.fontSize15 * 1.5,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.width10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: Dimensions.width20 * 2,
                  height: Dimensions.width20 * 2,
                  decoration: BoxDecoration(
                    color: eventTask!.color == 0
                        ? AppColor.bluishClr
                        : eventTask!.color == 1
                            ? AppColor.pinkClr
                            : AppColor
                                .yellowClr, // this will be dynmaic color follow task
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleText(
                        text: eventTask!.title!,
                        sizeText: Dimensions.fontSize15,
                        fontWeight: FontWeight.w500,
                      ),
                      // date
                      Row(
                        children: [
                          SimpleText(
                            text: eventTask!.date!,
                            sizeText: Dimensions.fontSize15,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.height10),
            //
            Row(
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  size: Dimensions.iconSize17 * 1.7,
                ),
                SizedBox(width: Dimensions.width10),
                SimpleText(
                  text: "${eventTask!.remind!} " +
                      "text_min_before_detailPage".tr,
                  sizeText: Dimensions.fontSize15,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            // note
            Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  size: Dimensions.iconSize17 * 1.7,
                ),
                SizedBox(width: Dimensions.width10),
                SimpleText(
                  text: eventTask!.note!,
                  sizeText: Dimensions.fontSize15,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: Dimensions.height5),
            // time
            Row(
              children: [
                // start time and end time
                Icon(
                  Icons.access_time_outlined,
                  size: Dimensions.iconSize17 * 1.7,
                ),
                SizedBox(width: Dimensions.width10),
                Expanded(
                  child: SimpleText(
                    text: "text_startTime".tr +
                        ": ${eventTask!.startTime!}" +
                        " - " +
                        "text_endTime".tr +
                        ": ${eventTask!.endTime}",
                    sizeText: Dimensions.fontSize15,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            // text repeat
            Row(
              children: [
                Icon(
                  Icons.repeat_one_outlined,
                  size: Dimensions.iconSize17 * 1.7,
                ),
                SizedBox(width: Dimensions.width10),
                SimpleText(
                  text: "text_repeat".tr + ": ${eventTask!.repeat}",
                  sizeText: Dimensions.fontSize15,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            // text task complete
            Row(
              children: [
                Icon(
                  Icons.check_outlined,
                  size: Dimensions.iconSize17 * 1.7,
                ),
                SizedBox(width: Dimensions.width10),
                SimpleText(
                  text:
                      "${eventTask!.status! == true ? 'text_task_complete'.tr : 'text_task_not_complete'.tr}",
                  sizeText: Dimensions.fontSize15,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Builder(builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            color: Colors.transparent,
            child: DialogShow(
              isForUpdate: true,
            ),
          ),
        );
      });
    },
  );
}
