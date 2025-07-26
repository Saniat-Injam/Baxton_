import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTextStyle({
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.w400,
  double lineHeight = 21.0,
  TextAlign textAlign = TextAlign.center,
  Color color = Colors.black,
  TextDecoration decoration = TextDecoration.none,
  double letterSpacing = 0.0,
}) {
  return GoogleFonts.roboto(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: fontSize.sp / lineHeight.sp,
    color: color,
    decoration: TextDecoration.none,
    letterSpacing: letterSpacing,
  );
}

TextStyle getTextStyle2({
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.w400,
  double lineHeight = 21.0,
  TextAlign textAlign = TextAlign.center,
  Color color = Colors.black,
  TextDecoration decoration = TextDecoration.none,
  double letterSpacing = 0.0,
}) {
  return GoogleFonts.poppins(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: fontSize.sp / lineHeight.sp,
    color: color,
    decoration: TextDecoration.none,
    letterSpacing: letterSpacing,
  );
}

TextStyle getTextStyle3({
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.w400,
  double lineHeight = 21.0,
  TextAlign textAlign = TextAlign.center,
  Color color = Colors.black,
  TextDecoration decoration = TextDecoration.none,
  double letterSpacing = 0.0,
}) {
  return GoogleFonts.inter(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: fontSize.sp / lineHeight.sp,
    color: color,
    decoration: TextDecoration.none,
    letterSpacing: letterSpacing,
  );
}

TextStyle commonText({
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.w400,
  TextAlign textAlign = TextAlign.center,
  Color color = Colors.black,
  TextDecoration decoration = TextDecoration.none,
}) {
  return GoogleFonts.inter(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    decoration: TextDecoration.none,
  );
}
