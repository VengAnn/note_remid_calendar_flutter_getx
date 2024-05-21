import 'package:flutter/material.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';

class SimpleText extends StatelessWidget {
  final String text;
  final double? sizeText;
  final FontWeight fontWeight;
  final Color? textColor;

  const SimpleText({
    super.key,
    required this.text,
    this.sizeText,
    this.fontWeight = FontWeight.normal,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: sizeText ?? Dimensions.fontSize20 / 1.5,
        fontWeight: fontWeight,
        color: textColor ?? Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}
