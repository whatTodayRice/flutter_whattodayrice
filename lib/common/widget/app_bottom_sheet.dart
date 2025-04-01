import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({super.key, this.asset, required this.content, required this.onTap});

  final Widget? asset;
  final String content;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 130,
        child: Center(
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (asset != null) asset!,
                SizedBox(width: 8.h),
                Text(content, style: AppTextStyle.bold20.copyWith(color: AppColor.orangeFF6060)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
