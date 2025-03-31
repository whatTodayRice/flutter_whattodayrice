import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    this.onPressed,
    required this.title,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.textStyle,
    required this.elevation,
    required this.borderRadiusValue,
    required this.disabledForegroundColor,
    required this.disabledBackgroundColor,
  });

  final VoidCallback? onPressed;
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color disabledForegroundColor;
  final Color disabledBackgroundColor;

  final TextStyle textStyle;
  final double elevation;
  final double borderRadiusValue;

  factory AppElevatedButton.orange5Long({
    void Function()? onPressed,
    required String title,
  }) =>
      AppElevatedButton(
        onPressed: onPressed,
        title: title,
        backgroundColor: Colors.white,
        foregroundColor: AppColor.orange5,
        elevation: 0,
        borderRadiusValue: 14,
        textStyle: GoogleFonts.notoSans(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColor.orange5,
        ),
        disabledForegroundColor: Colors.white,
        disabledBackgroundColor: AppColor.borderGray,
      );

  factory AppElevatedButton.gray17Long({
    void Function()? onPressed,
    required String title,
  }) =>
      AppElevatedButton(
        onPressed: onPressed,
        title: title,
        backgroundColor: Colors.white,
        foregroundColor: AppColor.grayA4A4A4,
        elevation: 0,
        borderRadiusValue: 14,
        textStyle: GoogleFonts.notoSans(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColor.grayA4A4A4,
        ),
        disabledForegroundColor: Colors.white,
        disabledBackgroundColor: AppColor.borderGray,
      );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
        disabledForegroundColor: disabledForegroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue))),
        textStyle: textStyle,
        elevation: elevation,
        padding: EdgeInsets.zero,
        overlayColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Text(title),
    );
  }
}
