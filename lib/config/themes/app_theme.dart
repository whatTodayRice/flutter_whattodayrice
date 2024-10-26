import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.notoSans(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black),
        headlineMedium: GoogleFonts.notoSans(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
        titleMedium: GoogleFonts.notoSans(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.black),
        titleSmall: GoogleFonts.notoSans(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.black),
        bodyMedium: GoogleFonts.notoSans(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black),
        bodySmall: GoogleFonts.notoSans(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.black),
      ),
    );
  }

  static ThemeData get dartTheme {
    return ThemeData(
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.notoSans(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
        headlineMedium: GoogleFonts.notoSans(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
        titleMedium: GoogleFonts.notoSans(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.white),
        titleSmall: GoogleFonts.notoSans(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white),
        bodyMedium: GoogleFonts.notoSans(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
        bodySmall: GoogleFonts.notoSans(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.white),
      ),
    );
  }
}
