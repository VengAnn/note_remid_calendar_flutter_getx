import 'package:flutter/material.dart';
import 'package:note_schedule_reminder/utils/app_style.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';

class MyInputTextFieldReusable extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController? textEditingController;
  final Widget? widget;
  final FocusNode? focusNode;

  const MyInputTextFieldReusable({
    super.key,
    required this.title,
    required this.hint,
    this.textEditingController,
    this.widget,
    this.focusNode,
  });

  @override
  State<MyInputTextFieldReusable> createState() =>
      _MyInputTextFieldReusableState();
}

class _MyInputTextFieldReusableState extends State<MyInputTextFieldReusable> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: titleStyle,
          ),
          SizedBox(height: Dimensions.height5),
          // Container
          Container(
            height: Dimensions.height20 * 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    focusNode: widget.focusNode,
                    // if widget is null set readOnly is false otherwise true
                    readOnly: widget.widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Colors.grey[600],
                    controller: widget.textEditingController,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width10,
                      ),
                    ),
                  ),
                ),
                widget.widget == null
                    ? Container()
                    : Container(child: widget.widget),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
