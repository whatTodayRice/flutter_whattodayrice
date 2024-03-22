import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.notoSans(
        fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: GoogleFonts.notoSans(
        fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: GoogleFonts.notoSans(
        fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.black),
    titleSmall: GoogleFonts.notoSans(
        fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.black),
    bodyMedium: GoogleFonts.notoSans(
        fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500),
    bodySmall: GoogleFonts.notoSans(
        fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w400),
  );
  static final darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.notoSans(
        fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: GoogleFonts.notoSans(
        fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: GoogleFonts.notoSans(
        fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.white),
    titleSmall: GoogleFonts.notoSans(
        fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white),
    bodyMedium: GoogleFonts.notoSans(
        fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
    bodySmall: GoogleFonts.notoSans(
        fontSize: 12.sp, color: Colors.white, fontWeight: FontWeight.w400),
  );
}
