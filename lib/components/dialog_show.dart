import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_schedule_reminder/components/dialogs.dart';
import 'package:note_schedule_reminder/controllers/calendar_page_controller.dart';
import 'package:note_schedule_reminder/controllers/events_controller/event_controller.dart';
import 'package:note_schedule_reminder/controllers/task_controller/task_controller.dart';
import 'package:note_schedule_reminder/models/task_res/event_task.dart';
import 'package:note_schedule_reminder/models/task_sqlite/task_model.dart';
import 'package:note_schedule_reminder/services/share_preferences.dart';
import 'package:note_schedule_reminder/utils/app_style.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';
import 'package:note_schedule_reminder/widgets/my_button_widget.dart';
import 'package:note_schedule_reminder/widgets/my_input_textfield_reuseable.dart';
import 'package:note_schedule_reminder/widgets/simple_text.dart';

// ignore: must_be_immutable
class DialogShow extends StatefulWidget {
  final bool isForUpdate;
  final Task? task; // Add this parameter to pass existing task data

  DialogShow({
    Key? key,
    this.isForUpdate = false,
    this.task,
  }) : super(key: key);

  @override
  State<DialogShow> createState() => _DialogShowState();
}

class _DialogShowState extends State<DialogShow> {
  // ignore: unused_field
  final TaskController _taskController = Get.put(TaskController());

  late TextEditingController _titleController;
  late TextEditingController _noteController;

  int selectedIndexColor = 0;
  late DateTime _selectedDate;
  late String _startTime;
  late String _endTime;
  int _selectedRemider = 0;
  String _selectedRepeat = "None";

  List<int> remindList = [0, 5, 10, 15];
  // respeat can have more then this like None, Daily, weekly, monthly
  List<String> repeatList = ["None", "Daily"];

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _noteController = TextEditingController(text: widget.task?.note ?? '');
    _selectedDate = widget.task != null
        ? DateTime.parse(widget.task!.date!)
        : DateTime.now();
    _startTime =
        widget.task?.startTime ?? DateFormat("hh:mm a").format(DateTime.now());
    _endTime = widget.task?.endTime ??
        DateFormat("hh:mm a").format(DateTime.now().add(Duration(hours: 1)));
    _selectedRemider = widget.task?.remind ?? 0;
    _selectedRepeat = widget.task?.repeat ?? "None";
    selectedIndexColor = widget.task?.color ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 9,
      color: Colors.white,
      padding: EdgeInsets.all(Dimensions.width10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Row(
            children: [
              SimpleText(
                text: widget.isForUpdate ? "Update Task" : "Create a new Task",
                sizeText: Dimensions.fontSize21,
                fontWeight: FontWeight.w600,
              ),
              const Spacer(),
              //btn close
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          //
          MyInputTextFieldReusable(
            title: "Tittle",
            hint: "Enter title here",
            textEditingController: _titleController,
          ),
          MyInputTextFieldReusable(
            title: "Note",
            hint: "Enter note here",
            textEditingController: _noteController,
          ),
          MyInputTextFieldReusable(
            title: "Date",
            // format _selectedDate obj to string MM/DD/YYYY
            hint: DateFormat.yMd().format(_selectedDate),
            widget: IconButton(
              onPressed: () {
                // when click show Date Picker
                _getDateFromUser();
              },
              icon: const Icon(
                Icons.calendar_today_outlined,
                color: Colors.grey,
              ),
            ),
          ),

          //this Row have two expanded
          Row(
            children: [
              Expanded(
                child: MyInputTextFieldReusable(
                  title: "Start Time",
                  hint: _startTime,
                  widget: IconButton(
                    onPressed: () {
                      _getTimeFromUser(isStartTime: true);
                    },
                    icon: const Icon(Icons.timer_rounded),
                  ),
                ),
              ),
              //sizedbox
              SizedBox(width: Dimensions.width10),
              Expanded(
                child: MyInputTextFieldReusable(
                  title: "End Time",
                  hint: _endTime,
                  widget: IconButton(
                    onPressed: () {
                      _getTimeFromUser(isStartTime: false);
                    },
                    icon: const Icon(Icons.timer_outlined),
                  ),
                ),
              ),
            ],
          ),

          //Remind
          MyInputTextFieldReusable(
            focusNode: _focusNode,
            title: "Remind",
            hint: "$_selectedRemider minutes ealy",
            widget: DropdownButton(
              elevation: 4,
              style: subTitleStyle,
              underline: Container(height: 0),
              items: remindList
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.toString(),
                      child: Text(
                        e.toString(),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRemider = int.parse(newValue!);
                });
              },
            ),
          ),
          //Repeat
          MyInputTextFieldReusable(
            title: "Repeat",
            hint: _selectedRepeat,
            widget: DropdownButton(
              elevation: 4,
              style: subTitleStyle,
              underline: Container(height: 0),
              // loop all element in repeatList one by one to drowDownMenu Items
              items: repeatList
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRepeat = newValue!;
                });
              },
            ),
          ),

          // add a bit space
          SizedBox(height: Dimensions.height20),
          // btn create new task and color palette
          //Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _colorPallet(),
              // button create Task
              MyButton(
                label: widget.isForUpdate ? "Update Task" : "Create Task",
                ontap: () {
                  _validateDate();
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  // vilidation
  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      if (DateFormat("hh:mm a").parse(_startTime) !=
          DateFormat("hh:mm a").parse(_endTime)) {
        // if isForUpdate is true update the data in local storage and server
        if (widget.isForUpdate) {
          if (widget.task != null) {
            _updateTaskToDB();
            _updateToServer();
          } else {
            Dialogs.showSnackBar("task on update is null or empty");
          }

          // when update already get again like refresh to see what changed
          Get.find<CalendarPageController>().getEventTaskFromServer();
          Get.find<CalendarPageController>().getTaskFromTaskController();
        } else {
          // otherwise isForUpdate is false add the data in local storage and server
          // add to database sqlite local storage
          _addTaskToDB();
          _addToServer();

          // when add everything successfully let's get from local storage task to alert notification
          // cuz in method getTaskFromTaskController  have method call alert Notification we need to call it to see notification
          // when add everything ok
          Get.find<CalendarPageController>().getEventTaskFromServer();
          Get.find<CalendarPageController>().getTaskFromTaskController();
        }

        Get.back();
      } else {
        Dialogs.showSnackBar("start time and end time can't the same!");
      }
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Dialogs.showSnackBar("All fields are required!");
    }
  }

  _updateTaskToDB() {
    // Format the selected date to yyyy-MM-dd before saving
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    Task task = Task(
      id: widget.task!.id,
      note: _noteController.text,
      title: _titleController.text,
      date: formattedDate,
      startTime: _startTime,
      endTime: _endTime,
      remind: _selectedRemider,
      repeat: _selectedRepeat,
      color: selectedIndexColor,
      isCompleted: widget.task!.isCompleted,
    );
    // update to database
    _taskController.updateTask(task);
    // when update to database ok get again to see what changed
    Get.find<CalendarPageController>().getTaskFromTaskController();
  }

  _updateToServer() {
    // print("update dialog : ${widget.task!.id}");

    // Format the selected date to yyyy-MM-dd before saving
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    // update to server
    Get.find<EventController>().updateEvent(
      eventTask: EventTask(
        eventId: widget.task!.id,
        note: _noteController.text,
        title: _titleController.text,
        date: formattedDate,
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemider.toString(), // convert to string
        repeat: _selectedRepeat,
        color: selectedIndexColor,
        status: 1,
      ),
    );
    // when update to server ok get again to see what changed
    Get.find<CalendarPageController>().getEventTaskFromServer();
  }

  _addToServer() {
    // Format the selected date to yyyy-MM-dd before saving
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    // add to server
    Get.find<EventController>().addEvent(
      token: SharedPreferencesService.getToken(),
      eventTask: EventTask(
        note: _noteController.text,
        title: _titleController.text,
        date: formattedDate,
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemider.toString(), // convert to string
        repeat: _selectedRepeat,
        color: selectedIndexColor,
      ),
      userId: SharedPreferencesService.getUserId(),
    );
    // when add to server ok get again to see what changed
    Get.find<CalendarPageController>().getEventTaskFromServer();
  }

  _addTaskToDB() async {
    // Format the selected date to yyyy-MM-dd before saving
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    //add to sqflite
    int value = await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: formattedDate,
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemider,
        repeat: _selectedRepeat,
        color: selectedIndexColor,
        isCompleted: 0,
      ),
    );
    debugPrint("id in db is $value");
  }

  // ColorsPallete select
  _colorPallet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        //select colors
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) {
              return Padding(
                padding: EdgeInsets.only(right: Dimensions.width5 / 2),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexColor = index;
                    });
                  },
                  child: CircleAvatar(
                    radius: Dimensions.radius15,
                    backgroundColor: index == 0
                        ? Colors.blue
                        : index == 1
                            ? Colors.pink
                            : Colors.yellow,
                    child: selectedIndexColor == index
                        ? Icon(
                            Icons.done,
                            size: Dimensions.height5 * 2.5,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // // getDate From input user
  // _getDateFromUser() async {
  //   DateTime? _pickerDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2021),
  //     lastDate: DateTime(2121),
  //     locale: Get.locale!, // Use current app locale dynamically
  //   );

  //   // check
  //   if (_pickerDate != null) {
  //     setState(() {
  //       _selectedDate = _pickerDate;
  //       debugPrint("picker time's: $_selectedDate");
  //     });
  //   } else {
  //     debugPrint("it's null or something is wrong!");
  //   }
  // }

  // //
  // _getTimeFromUser({required bool isStartTime}) async {
  //   var pickerTime = await _showTimePicker();
  //   if (pickerTime == null) {
  //     debugPrint("Time canceld");
  //   } else {
  //     // this formate picktime to hh:mm a
  //     // ignore: use_build_context_synchronously
  //     String formatedTime = pickerTime.format(context);
  //     if (isStartTime == true) {
  //       setState(() {
  //         _startTime = formatedTime;
  //       });
  //     } else if (isStartTime == false) {
  //       setState(() {
  //         _endTime = formatedTime;
  //       });
  //     }
  //   }
  // }

  // _showTimePicker() {
  //   return showTimePicker(
  //     initialEntryMode: TimePickerEntryMode.input,
  //     context: context,
  //     initialTime: TimeOfDay(
  //       // startTime -> 10:45 AM

  //       hour: int.parse(_startTime.split(":")[0]),
  //       minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
  //     ),
  //   );
  // }

  _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2121),
      builder: (BuildContext context, Widget? child) {
        return Localizations.override(
          context: context,
          locale: Locale('en', 'US'), // Set to English locale
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        debugPrint("Picked date: $_selectedDate");
      });
    } else {
      debugPrint("Date picker canceled or null");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickerTime = await _showTimePicker();

    if (pickerTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = _formatTimeOfDay(pickerTime);
        } else {
          _endTime = _formatTimeOfDay(pickerTime);
        }
      });
    } else {
      debugPrint("Time picker canceled or null");
    }
  }

  _showTimePicker() {
    // Parse the start time string to get hour and minute
    List<String> timeParts = _startTime.split(":");
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1].split(" ")[0]);

    // Determine if it's AM or PM based on the period in _startTime
    String period = timeParts[1].split(" ")[1]; // AM or PM

    // Adjust hour for 24-hour format if needed
    if (period.toUpperCase() == "PM" && hour < 12) {
      hour += 12; // Convert PM hour to 24-hour format
    } else if (period.toUpperCase() == "AM" && hour == 12) {
      hour = 0; // Midnight hour (12 AM) is 0 in 24-hour format
    }

    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: Localizations.override(
            context: context,
            locale: Locale('en', 'US'), // Set to English locale
            child: child!,
          ),
        );
      },
    );
  }

// Function to format TimeOfDay to string with AM/PM
  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dt = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat.jm().format(dt); // Formats time as "h:mm AM/PM"
  }
}
