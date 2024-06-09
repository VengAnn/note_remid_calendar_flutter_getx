import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final VoidCallback? onTap;
  final bool obscureText;
  final String? textVilidation;
  final bool? btnTapped;
  final bool? showInvalidEmail;

  const TextFormFieldWidget({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.titleText,
    required this.icon,
    this.iconSuffix,
    this.showIconSuffix = false,
    this.obscureText = false,
    this.onTap,
    this.btnTapped = false,
    this.textVilidation,
    this.showInvalidEmail = false,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //height: Dimensions.height20 * 2.5,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
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
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Dimensions.width10,
                  ),
                  suffixIcon: showIconSuffix == true
                      ? GestureDetector(
                          onTap: onTap,
                          child: Icon(iconSuffix),
                        )
                      : const SizedBox(),
                ),
                obscureText: obscureText,
              ),
            ),
            // Show validation message when button is tapped
            Padding(
              padding: EdgeInsets.only(
                left: Dimensions.width10,
                top: Dimensions.height5,
              ),
              // Show validation message when button is tapped and text is invalid
              child: btnTapped!
                  ? (textEditingController.text.isEmpty
                      ? Text(
                          textVilidation!,
                          style: const TextStyle(color: Colors.red),
                        )
                      : !GetUtils.isEmail(textEditingController.text.trim())
                          ? showInvalidEmail == true
                              ? Text(
                                  "text_valid_email".tr,
                                  style: const TextStyle(color: Colors.red),
                                )
                              : const SizedBox()
                          : const SizedBox())
                  : const SizedBox(),
            ),
          ],
        ),
      ],
    );
  }
}
