import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/controllers/history/history_controller.dart';
import 'package:note_schedule_reminder/models/task_res/event_task.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';
import 'package:note_schedule_reminder/widgets/simple_text.dart';
import 'package:note_schedule_reminder/widgets/task_complete.dart';
import 'package:note_schedule_reminder/widgets/task_not_complete.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<EventTask>? eventListCompleted = [];
  List<EventTask>? eventListNotCompleted = [];

  Future<void> getEventTaskFromServer() async {
    List<EventTask>? eventTaskLs =
        await Get.find<HistoryController>().getEventTaskFromServerByUserId();

    if (eventTaskLs != null) {
      for (EventTask eventTask in eventTaskLs) {
        log("res eventTaskLs : ${eventTask.date} - ${eventTask.note} - ${eventTask.status}");

        // loop task completed
        if (eventTask.status == 1) {
          eventListCompleted!.add(eventTask);
        }
        // loop task not completed
        else {
          eventListNotCompleted!.add(eventTask);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    Get.put(HistoryController());
    // use future.delay zero for fix something wrong !
    Future.delayed(Duration.zero, () async {
      getEventTaskFromServer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: SimpleText(
            text: 'title_text_histroy'.tr,
            sizeText: Dimensions.fontSize20,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: GetBuilder<HistoryController>(
          builder: (historyController) {
            return historyController.isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SafeArea(
                      child: Column(
                        children: [
                          Container(
                            height: Dimensions.height20 * 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200],
                            ),
                            child: TabBar(
                              indicator: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              dividerColor: Colors.transparent,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.blue,
                              tabs: [
                                Tab(
                                  child: SimpleText(
                                    text: "text_task_complete".tr,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Tab(
                                  child: SimpleText(
                                    text: "text_task_not_complete".tr,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                TaskCompleteContainer(
                                    eventTaskList: eventListCompleted),
                                TaskNotComplete(
                                    eventTaskList: eventListNotCompleted),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
