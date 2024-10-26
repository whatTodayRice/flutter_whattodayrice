import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';

class FabCloseButton extends StatelessWidget {
  const FabCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.w,
      height: 46.h,
      decoration: BoxDecoration(
        color: AppColor.orange5,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Icon(
        Icons.close,
        color: Colors.white,
        size: 28.w,
      ),
    );
  }
}
