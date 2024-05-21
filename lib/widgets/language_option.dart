import 'package:flutter/material.dart';
import 'package:note_schedule_reminder/widgets/simple_text.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';

class LanguageOption extends StatelessWidget {
  final String textLanguage;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;
  final double? sizeText;

  const LanguageOption({
    super.key,
    required this.textLanguage,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
    this.sizeText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
        padding: EdgeInsets.all(Dimensions.width20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(Dimensions.radius10),
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: Dimensions.width20 * 2.5,
            ),
            SizedBox(height: Dimensions.width5),
            SimpleText(
              text: textLanguage,
              fontWeight: FontWeight.bold,
              sizeText: sizeText,
            ),
          ],
        ),
      ),
    );
  }
}
