import 'package:get/get.dart';
import 'package:note_schedule_reminder/controllers/calendar_page_controller.dart';

Future<void> init() async {
  //api client

  //repositories

  //controllers
  Get.lazyPut(() => CalendarPageController());
}


/*
appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('title_appbar_text'.tr),
        actions: [
          InkWell(
            onTap: () {
           
            },
            child: CircleAvatar(
              radius: Dimensions.radius20,
              child: const Icon(Icons.person),
            ),
          ),
          SizedBox(
            width: Dimensions.width5,
          ),
        ],
      ),
    */