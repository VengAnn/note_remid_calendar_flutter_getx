import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';

// TextStyle
TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: Dimensions.fontSize20,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  ));
}

// TextStyle Header
TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: (Dimensions.fontSize20 * 2) - 10, //40-10=30
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ));
}

// TextStyle title
TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: Dimensions.fontSize20 - 4,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ));
}

// TextStyle subTitle
TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: Dimensions.fontSize20 - 6,
    fontWeight: FontWeight.w400,
    color: Colors.grey[400],
  ));
}

TextStyle get styleColorWhite {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: Dimensions.fontSize20 - 6,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ));
}
