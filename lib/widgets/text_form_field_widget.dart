import 'package:flutter/material.dart';
import 'package:note_schedule_reminder/utils/app_color.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';
import 'package:note_schedule_reminder/widgets/simple_text.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String titleText;
  final IconData icon;
  final IconData? iconSuffix;
  final bool showIconSuffix;

  const TextFormFieldWidget({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.titleText,
    required this.icon,
     this.iconSuffix,
    this.showIconSuffix = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //text
        SimpleText(
          text: titleText,
          textColor: AppColor.colorGrey,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.radius15),
            ),
          ),
          child: TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(icon),
              hintText: hintText,
              suffixIcon:
                  showIconSuffix == true ? Icon(iconSuffix) : const SizedBox(),
            ),
          ),
        ),
      ],
    );
  }
}
